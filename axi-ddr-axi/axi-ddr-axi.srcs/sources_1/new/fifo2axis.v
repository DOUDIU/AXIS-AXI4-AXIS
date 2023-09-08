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
        //the max depth of the fifo: 2^FIFO_AW
        parameter FIFO_AW           = 8
		// AXI4Stream sink: Data Width
    ,   parameter AXIS_DATA_WIDTH	= 32
		// AXI4 sink: Data Width as same as the data depth of the fifo
    ,   parameter AXI4_DATA_WIDTH   = 128
)(
//----------------------------------------------------
// AXIS maxter port
	// Global ports
	input wire M_AXIS_ACLK,
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
	input wire M_AXIS_TREADY

//----------------------------------------------------
// backward FIFO read interface
    ,   input   wire           	brd_start
    ,   output  wire           	brd_rdy  
    ,   input   wire           	brd_vld  
    ,   input   wire [FDW-1:0] 	brd_din  
    ,   input   wire           	brd_empty
    ,   input   wire [FAW:0] 	brd_cnt  
);




endmodule
