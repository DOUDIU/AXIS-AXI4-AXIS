`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/08 15:21:48
// Design Name: 
// Module Name: fifo2axis
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fifo2axis#(
    	parameter FDW = 32
    ,	parameter FAW = 8

    ,   parameter FRAME_DELAY = 2 //max 1024
    ,   parameter PIXELS_HORIZONTAL = 1280
    ,   parameter PIXELS_VERTICAL = 1024
	
		// AXI4Stream sink: Data Width
    ,   parameter AXIS_DATA_WIDTH	= 32
		// AXI4 sink: Data Width as same as the data depth of the fifo
    ,   parameter AXI4_DATA_WIDTH   = 128
	// Start count is the number of clock cycles the master will wait before initiating/issuing any transaction.
	,   parameter integer C_M_START_COUNT = 3
)(
//----------------------------------------------------
// AXIS maxter port
	// Global ports
	   input wire M_AXIS_ACLK
	,  input wire M_AXIS_ARESETN
	// Master Stream Ports. TVALID indicates that the master is driving a valid transfer, A transfer takes place when both TVALID and TREADY are asserted.
	,   output wire M_AXIS_TVALID
	// TDATA is the primary payload that is used to provide the data that is passing across the interface from the master.
	,   output wire [AXIS_DATA_WIDTH-1 : 0] M_AXIS_TDATA
	// TSTRB is the byte qualifier that indicates whether the content of the associated byte of TDATA is processed as a data byte or a position byte.
	,   output wire [(AXIS_DATA_WIDTH/8)-1 : 0] M_AXIS_TSTRB
	// TLAST indicates the boundary of a packet.
	,   output wire M_AXIS_TLAST
	// TREADY indicates that the slave can accept a transfer in the current cycle.
	,   input wire M_AXIS_TREADY

	,   output wire M_AXIS_USER

//----------------------------------------------------
// AXIS slave port
// introduced to align the interval with the original input
    // AXI4Stream sink: Clock
    ,   input wire  S_AXIS_ACLK
    // AXI4Stream sink: Reset
    ,   input wire  S_AXIS_ARESETN
    // Ready to accept data in
    ,   output wire  S_AXIS_TREADY
    // Data in
    ,   input wire [AXIS_DATA_WIDTH-1 : 0] S_AXIS_TDATA
    // Byte qualifier
    ,   input wire [(AXIS_DATA_WIDTH/8)-1 : 0] S_AXIS_TSTRB
    // Indicates boundary of last packet
    ,   input wire  S_AXIS_TLAST
    // Data is in valid
    ,   input wire  S_AXIS_TVALID

	,   input wire S_AXIS_USER

//----------------------------------------------------
// backward FIFO read interface
    ,   output  wire           	brd_rdy  
    ,   input   wire           	brd_vld  
    ,   input   wire [FDW-1:0] 	brd_din  
    ,   input   wire           	brd_empty
    ,   input   wire [FAW:0] 	brd_cnt  
);


reg	[10:0]   	frame_cnt = 0;
wire            burst_en;
reg [FDW-1:0] 	brd_din_buf;
reg [3:0]       din_buf_cnt;
reg				m_axis_user_flag;

// Total number of output data
localparam NUMBER_OF_OUTPUT_WORDS = PIXELS_HORIZONTAL/4;
// function called clogb2 that returns an integer which has the 
// value of the ceiling of the log base 2.
function integer clogb2 (input integer bit_depth);
begin
for(clogb2=0; bit_depth>0; clogb2=clogb2+1)
	bit_depth = bit_depth >> 1;
end
endfunction // WAIT_COUNT_BITS is the width of the wait counter.
localparam integer WAIT_COUNT_BITS = clogb2(C_M_START_COUNT-1);
// bit_num gives the minimum number of bits needed to address 'depth' size of FIFO.
localparam bit_num = clogb2(NUMBER_OF_OUTPUT_WORDS);
// Define the states of state machine 
// The control state machine oversees the writing of input streaming data to the FIFO,
// and outputs the streaming data from the FIFO
parameter [1:0] IDLE 			= 2'b00, 	// This is the initial/idle state
				INIT_COUNTER 	= 2'b01, 	// This state initializes the counter, once 
											// the counter reaches C_M_START_COUNT count,
											// the state machine changes state to SEND_STREAM
				SEND_STREAM 	= 2'b10; 	// In this state the 
											// stream data is output through M_AXIS_TDATA
											// State variable

reg [1:0] mst_exec_state;
// Example design FIFO read pointer
reg [bit_num-1:0] read_pointer;
reg [AXIS_DATA_WIDTH-1:0] m_axis_tdata;
// AXI Stream internal signals 
//wait counter. The master waits for the user defined number of clock cycles before initiating a transfer.
reg [WAIT_COUNT_BITS-1 : 0] count;
//streaming data valid 
wire  axis_tvalid;
//Last of the streaming data 
wire axis_tlast; 
wire tx_en;
//The master has issued all the streaming data stored in FIFO
wire tx_done;
// I/O Connections assignments 
assign M_AXIS_TVALID 	= axis_tvalid;

assign M_AXIS_TLAST 	= axis_tlast;
assign M_AXIS_TSTRB 	= {(AXIS_DATA_WIDTH/8){1'b1}};
// Control state machine implementation
always @(posedge M_AXIS_ACLK)begin
	if (!M_AXIS_ARESETN)
	// Synchronous reset (active low)
	begin 
		mst_exec_state <= IDLE;
		count <= 0;
	end
	else begin
		case (mst_exec_state)
			IDLE: 
                if(burst_en) begin
				    mst_exec_state <= SEND_STREAM;
                end
			SEND_STREAM:
				// The example design streaming master functionality starts // when the master drives output tdata from the FIFO and the slave // has finished storing the S_AXIS_TDATA
				if(tx_done) begin 
					mst_exec_state <= IDLE;
				end
				else begin 
					mst_exec_state <= SEND_STREAM;
				end
		endcase
	end
end
//tvalid generation 
//axis_tvalid is asserted when the control state machine's state is SEND_STREAM and
//number of output streaming data is less than the NUMBER_OF_OUTPUT_WORDS.

assign axis_tvalid = ((mst_exec_state == SEND_STREAM) && (read_pointer < NUMBER_OF_OUTPUT_WORDS));

// AXI tlast generation
assign axis_tlast = (read_pointer == NUMBER_OF_OUTPUT_WORDS - 1'b1) && tx_en;
assign tx_done = axis_tlast;
//FIFO read enable generation
assign tx_en = M_AXIS_TREADY && axis_tvalid;
//Streaming output data is read from FIFO
always @( posedge M_AXIS_ACLK )begin
	if(!M_AXIS_ARESETN)	begin
		read_pointer <= 0;
	end
	else if (tx_en)	begin
		read_pointer <= read_pointer + 32'b1;
	end
	else if(mst_exec_state == IDLE) begin
		read_pointer <= 0;
	end
end


assign  burst_en = (frame_cnt == FRAME_DELAY) & S_AXIS_TLAST;
assign  brd_rdy = burst_en || ((read_pointer[1:0] == 2'b11) && !axis_tlast);

assign 	M_AXIS_TDATA = (brd_din_buf>>(96 - (read_pointer[1:0])*32));
assign	M_AXIS_USER = m_axis_user_flag & tx_en;


always@(posedge S_AXIS_ACLK) begin
    if(!S_AXIS_ARESETN) begin
        frame_cnt   <=  0;
    end
    else if(S_AXIS_USER & S_AXIS_TVALID & S_AXIS_TREADY) begin
        frame_cnt   <=  (frame_cnt >= FRAME_DELAY) ? frame_cnt : (frame_cnt + 1);
    end
end

always@(posedge S_AXIS_ACLK) begin
    if(!S_AXIS_ARESETN) begin
        brd_din_buf   <=  0;
    end
    else if(brd_rdy)begin
        brd_din_buf   <=  brd_din;
    end
end

always@(posedge S_AXIS_ACLK) begin
    if(!S_AXIS_ARESETN) begin
        m_axis_user_flag   <=  0;
    end
    else if(S_AXIS_USER)begin
        m_axis_user_flag   <=  1;
    end
	else if(M_AXIS_USER) begin
        m_axis_user_flag   <=  0;
	end
end

endmodule
