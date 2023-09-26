module maxis_v1_0_M00_AXIS #
(
	// Width of S_AXIS address bus. The slave accepts the read and write addresses of width C_M_AXIS_TDATA_WIDTH.
	parameter integer C_M_AXIS_TDATA_WIDTH = 32,
	// Start count is the number of clock cycles the master will wait before initiating/issuing any transaction.
	parameter integer C_M_START_COUNT = 3
	
    ,   parameter FRAME_DELAY = 2 //max 1024
    ,   parameter PIXELS_HORIZONTAL = 1280
    ,   parameter PIXELS_VERTICAL = 1024
)(
	// Global ports
	input wire M_AXIS_ACLK,
	//
	input wire M_AXIS_ARESETN,
	// Master Stream Ports. TVALID indicates that the master is driving a valid transfer, A transfer takes place when both TVALID and TREADY are asserted.
	output wire M_AXIS_TVALID,
	// TDATA is the primary payload that is used to provide the data that is passing across the interface from the master.
	output wire [C_M_AXIS_TDATA_WIDTH-1 : 0] M_AXIS_TDATA,
	// TSTRB is the byte qualifier that indicates whether the content of the associated byte of TDATA is processed as a data byte or a position byte.
	output wire [(C_M_AXIS_TDATA_WIDTH/8)-1 : 0] M_AXIS_TSTRB,
	// TLAST indicates the boundary of a packet.
	output wire M_AXIS_TLAST,
	// TREADY indicates that the slave can accept a transfer in the current cycle.
	input wire M_AXIS_TREADY,

	output wire M_AXIS_TUSER
);

assign M_AXIS_TUSER = M_AXIS_TVALID & M_AXIS_TREADY & (M_AXIS_TDATA[27:0] == 0);
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
				SEND_STREAM 	= 2'b10, 	// In this state the 
											// stream data is output through M_AXIS_TDATA
											// State variable
				FRAME_INTERVAL = 2'b11;

reg [1:0] mst_exec_state;
// Example design FIFO read pointer
reg [bit_num-1:0] read_pointer;
// AXI Stream internal signals 
//wait counter. The master waits for the user defined number of clock cycles before initiating a transfer.
reg [20 : 0] count;
//streaming data valid 
wire axis_tvalid;
//Last of the streaming data 
wire axis_tlast; 
wire tx_en;
//The master has issued all the streaming data stored in FIFO
wire tx_done;
// I/O Connections assignments 
assign M_AXIS_TVALID 	= axis_tvalid;
assign M_AXIS_TDATA 	= read_pointer+{frame_cnt,vertical_cnt,16'h0};
assign M_AXIS_TLAST 	= axis_tlast;
assign M_AXIS_TSTRB 	= {(C_M_AXIS_TDATA_WIDTH/8){1'b1}};
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
				if (vertical_cnt == 0)
					mst_exec_state <= FRAME_INTERVAL;
				else 
					mst_exec_state <= INIT_COUNTER;
			INIT_COUNTER:
				// The slave starts accepting tdata when 
				// there tvalid is asserted to mark the 
				// presence of valid streaming data
				if ( count == C_M_START_COUNT - 1 )	begin 
					mst_exec_state <= SEND_STREAM;
					count <= 0;
				end
				else begin
					count <= count + 1; 
					mst_exec_state <= INIT_COUNTER;
				end
			SEND_STREAM:
				// The example design streaming master functionality starts // when the master drives output tdata from the FIFO and the slave // has finished storing the S_AXIS_TDATA
				if(tx_done) begin 
					mst_exec_state <= IDLE;
				end
				else begin 
					mst_exec_state <= SEND_STREAM;
				end
			FRAME_INTERVAL:
				// The slave starts accepting tdata when 
				// there tvalid is asserted to mark the 
				// presence of valid streaming data
				if ( count == 1000 - 1 )	begin 
					mst_exec_state <= SEND_STREAM;
					count <= 0;
				end
				else begin
					count <= count + 1; 
					mst_exec_state <= FRAME_INTERVAL;
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

reg     [3:0]   frame_cnt;
reg     [11:0]  vertical_cnt;

always@(posedge M_AXIS_ACLK) begin
    if(!M_AXIS_ARESETN) begin
        vertical_cnt   <=  0;
    end
    else if(M_AXIS_TLAST)begin
        vertical_cnt   <=  (vertical_cnt >= PIXELS_VERTICAL - 1) ? 0 : (vertical_cnt + 1);
    end
end

always@(posedge M_AXIS_ACLK) begin
    if(!M_AXIS_ARESETN) begin
        frame_cnt   <=  0;
    end
    else if(M_AXIS_TLAST & (vertical_cnt == PIXELS_VERTICAL - 1)) begin
        frame_cnt   <=  frame_cnt + 1;
    end
end

endmodule
