`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/07 10:22:54
// Design Name: 
// Module Name: axis2fifo
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


module axis2fifo#(
        //the max depth of the fifo: 2^FIFO_AW
        parameter FAW           = 8
		// AXI4Stream sink: Data Width
    ,   parameter AXIS_DATA_WIDTH	= 32
		// AXI4 sink: Data Width as same as the data depth of the fifo
    ,   parameter AXI4_DATA_WIDTH   = 128
    ,   parameter FRAME_DELAY = 2 //max 1024
)(
//----------------------------------------------------
// AXIS slave port
    // AXI4Stream sink: Clock
        input wire  S_AXIS_ACLK
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

    ,   input wire  S_AXIS_USER

//----------------------------------------------------
// FIFO forward: address related
    ,   input   wire fwr_rdy  
    ,   output  reg fwr_vld  
    ,   output  reg  [AXI4_DATA_WIDTH-1:0]     fwr_dat  
    ,   input   wire fwr_full
    ,   input   wire [FAW:0] fwr_cnt 

//----------------------------------------------------
// USER INTERFACE
    ,   output  reg [clogb2(FRAME_DELAY-1)-1:0]     frame_cnt
);
localparam data_interval = AXI4_DATA_WIDTH/AXIS_DATA_WIDTH;

assign  S_AXIS_TREADY = 1;	


reg     [$clog2(data_interval)-1 : 0]   data_buf_cnt;
reg     [AXI4_DATA_WIDTH-1 : 0]         fifo_data_buf;

reg     frame_valid = 0;

always@(posedge S_AXIS_ACLK or negedge S_AXIS_ARESETN) begin
    if(!S_AXIS_ARESETN) begin
        frame_valid     <=  0;
    end
    else if(S_AXIS_USER & S_AXIS_TREADY & S_AXIS_TVALID) begin
        frame_valid     <=  1;
    end
end

always@(posedge S_AXIS_ACLK or negedge S_AXIS_ARESETN) begin
    if(!S_AXIS_ARESETN) begin
        frame_cnt     <=  0;
    end
    else if(S_AXIS_USER & S_AXIS_TREADY & S_AXIS_TVALID) begin
        frame_cnt     <=  frame_cnt == FRAME_DELAY-1 ? 0 : frame_cnt + 1;
    end
end

always@(posedge S_AXIS_ACLK or negedge S_AXIS_ARESETN) begin
    if(!S_AXIS_ARESETN) begin
        data_buf_cnt    <=  0;
    end
    else if(S_AXIS_TREADY & S_AXIS_TVALID & (S_AXIS_USER | frame_valid)) begin
        data_buf_cnt    <=  data_buf_cnt == data_interval? 0 : data_buf_cnt + 1;
    end
end

always@(posedge S_AXIS_ACLK or negedge S_AXIS_ARESETN) begin
    if(!S_AXIS_ARESETN) begin
        fifo_data_buf   <=  0;
    end
    else if(S_AXIS_TREADY & S_AXIS_TVALID & (S_AXIS_USER | frame_valid)) begin
        fifo_data_buf   <=  {fifo_data_buf[0+:AXI4_DATA_WIDTH-AXIS_DATA_WIDTH], S_AXIS_TDATA};
    end
end

always@(posedge S_AXIS_ACLK or negedge S_AXIS_ARESETN) begin
    if(!S_AXIS_ARESETN) begin
        fwr_vld <= 1'b0;
        fwr_dat <= 0;
    end 
    else if((data_buf_cnt == data_interval-1) & S_AXIS_TREADY & S_AXIS_TVALID & (S_AXIS_USER | frame_valid)) begin
        fwr_vld <= 1'b1;
        fwr_dat <= {fifo_data_buf[0+:AXI4_DATA_WIDTH-AXIS_DATA_WIDTH], S_AXIS_TDATA}; 
    end
    else begin
        fwr_vld <= 1'b0;
        fwr_dat <= 0;
    end
end



// function called clogb2 that returns an integer which has the 
// value of the ceiling of the log base 2.                      
function integer clogb2 (input integer bit_depth);              
begin                                                           
for(clogb2=0; bit_depth>0; clogb2=clogb2+1)                   
    bit_depth = bit_depth >> 1;                                 
end                                                           
endfunction    




endmodule
