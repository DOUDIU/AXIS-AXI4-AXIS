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
    ,   input wire  S_AXIS_TREADY
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

wire tx_en;
reg	[10:0]   	frame_cnt = 0;
reg	[31:0]		pixel_cnt;
reg [127:0]		brd_din_buf;



assign	M_AXIS_TVALID 	=	S_AXIS_TVALID 	;
assign  M_AXIS_TSTRB	=	S_AXIS_TSTRB	;
assign 	M_AXIS_TLAST	=	S_AXIS_TLAST	;
assign	M_AXIS_USER		=	S_AXIS_USER		;	
assign 	M_AXIS_TDATA 	= (frame_cnt == FRAME_DELAY + 1) ? (brd_din_buf>>(96 - (pixel_cnt[1:0])*32)) : 0;

assign  brd_rdy = ((frame_cnt == FRAME_DELAY + 1) && (tx_en & pixel_cnt[1:0] == 2'b11)) | ((frame_cnt == FRAME_DELAY) & S_AXIS_USER);


//FIFO read enable generation
assign tx_en = M_AXIS_TREADY && M_AXIS_TVALID;



always@(posedge S_AXIS_ACLK) begin
    if(!S_AXIS_ARESETN) begin
        frame_cnt   <=  0;
    end
    else if(S_AXIS_USER & S_AXIS_TVALID & S_AXIS_TREADY) begin
        frame_cnt   <=  (frame_cnt >= FRAME_DELAY + 1) ? frame_cnt : (frame_cnt + 1);
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
		pixel_cnt	<=	0;
	end
	else if(tx_en)begin
		pixel_cnt	<=	pixel_cnt + 1;
	end
	else if(pixel_cnt==327680)begin
		pixel_cnt	<=	0;
	end
end

endmodule
