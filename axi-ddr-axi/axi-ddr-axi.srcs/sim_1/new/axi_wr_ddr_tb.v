`timescale 1ns / 1ps

module axi_wr_ddr_tb();

localparam _DATA_WIDTH_ = 32;
localparam _PERIOD_ = 10;

reg     AXIS_ACLK   = 1'b0;
reg     AXIS_ARESETN= 1'b0;
wire    AXIS_TVALID;
wire    AXIS_TREADY;
wire    AXIS_TLAST;
wire    [_DATA_WIDTH_-1 : 0]        AXIS_TDATA;
wire    [(_DATA_WIDTH_/8)-1 : 0]    AXIS_TSTRB;

always #(_PERIOD_/2) AXIS_ACLK = ~AXIS_ACLK;

initial begin
    #(_PERIOD_*10);
    AXIS_ARESETN = 1'b1;
end

maxis_v1_0_M00_AXIS#
(
	// Width of S_AXIS address bus. The slave accepts the read and write addresses of width C_M_AXIS_TDATA_WIDTH.
	    .C_M_AXIS_TDATA_WIDTH (_DATA_WIDTH_)
	// Start count is the number of clock cycles the master will wait before initiating/issuing any transaction.
	,   .C_M_START_COUNT (300)
)u_maxis_v1_0_M00_AXIS(
	// Global ports
	    .M_AXIS_ACLK    (AXIS_ACLK      )
	//
	,  .M_AXIS_ARESETN  (AXIS_ARESETN   )
	// Master Stream Ports. TVALID indicates that the master is driving a valid transfer, A transfer takes place when both TVALID and TREADY are asserted.
	,  .M_AXIS_TVALID   (AXIS_TVALID    )
	// TDATA is the primary payload that is used to provide the data that is passing across the interface from the master.
	,  .M_AXIS_TDATA    (AXIS_TDATA     )
	// TSTRB is the byte qualifier that indicates whether the content of the associated byte of TDATA is processed as a data byte or a position byte.
	,  .M_AXIS_TSTRB    (AXIS_TSTRB     )
	// TLAST indicates the boundary of a packet.
	,  .M_AXIS_TLAST    (AXIS_TLAST     )
	// TREADY indicates that the slave can accept a transfer in the current cycle.
	,  .M_AXIS_TREADY   (AXIS_TREADY    )
);


axis2ddr_top u_axis2ddr_top(
//----------------------------------------------------
// AXIS slave port
        .S_AXIS_ACLK        (AXIS_ACLK        )
    ,   .S_AXIS_ARESETN     (AXIS_ARESETN     )
    ,   .S_AXIS_TREADY      (AXIS_TREADY      )
    ,   .S_AXIS_TDATA       (AXIS_TDATA       )
    ,   .S_AXIS_TSTRB       (AXIS_TSTRB       )
    ,   .S_AXIS_TLAST       (AXIS_TLAST       )
    ,   .S_AXIS_TVALID      (AXIS_TVALID      )
/*
//----------------------------------------------------
// AXI-FULL master port
    ,   .INIT_AXI_TXN           (INIT_AXI_TXN   )
    ,   .TXN_DONE               (TXN_DONE       )
    ,   .ERROR                  (ERROR          )
    ,   .M_AXI_ACLK             (M_AXI_ACLK     )
    ,   .M_AXI_ARESETN          (M_AXI_ARESETN  )

    //----------------Write Address Channel----------------//
    ,   .M_AXI_AWID             (M_AXI_AWID     )
    ,   .M_AXI_AWADDR           (M_AXI_AWADDR   )
    ,   .M_AXI_AWLEN            (M_AXI_AWLEN    )
    ,   .M_AXI_AWSIZE           (M_AXI_AWSIZE   )
    ,   .M_AXI_AWBURST          (M_AXI_AWBURST  )
    ,   .M_AXI_AWLOCK           (M_AXI_AWLOCK   )
    ,   .M_AXI_AWCACHE          (M_AXI_AWCACHE  )
    ,   .M_AXI_AWPROT           (M_AXI_AWPROT   )
    ,   .M_AXI_AWQOS            (M_AXI_AWQOS    )
    ,   .M_AXI_AWUSER           (M_AXI_AWUSER   )
    ,   .M_AXI_AWVALID          (M_AXI_AWVALID  )
    ,   .M_AXI_AWREADY          (M_AXI_AWREADY  )

    //----------------Write Data Channel----------------//
    ,   .M_AXI_WDATA            (M_AXI_WDATA    )
    ,   .M_AXI_WSTRB            (M_AXI_WSTRB    )
    ,   .M_AXI_WLAST            (M_AXI_WLAST    )
    ,   .M_AXI_WUSER            (M_AXI_WUSER    )
    ,   .M_AXI_WVALID           (M_AXI_WVALID   )
    ,   .M_AXI_WREADY           (M_AXI_WREADY   )

    //----------------Write Response Channel----------------//
    ,   .M_AXI_BID              (M_AXI_BID      )
    ,   .M_AXI_BRESP            (M_AXI_BRESP    )
    ,   .M_AXI_BUSER            (M_AXI_BUSER    )
    ,   .M_AXI_BVALID           (M_AXI_BVALID   )
    ,   .M_AXI_BREADY           (M_AXI_BREADY   )

    //----------------Read Address Channel----------------//
    ,   .M_AXI_ARID             (M_AXI_ARID     )
    ,   .M_AXI_ARADDR           (M_AXI_ARADDR   )
    ,   .M_AXI_ARLEN            (M_AXI_ARLEN    )
    ,   .M_AXI_ARSIZE           (M_AXI_ARSIZE   )
    ,   .M_AXI_ARBURST          (M_AXI_ARBURST  )
    ,   .M_AXI_ARLOCK           (M_AXI_ARLOCK   )
    ,   .M_AXI_ARCACHE          (M_AXI_ARCACHE  )
    ,   .M_AXI_ARPROT           (M_AXI_ARPROT   )
    ,   .M_AXI_ARQOS            (M_AXI_ARQOS    )
    ,   .M_AXI_ARUSER           (M_AXI_ARUSER   )
    ,   .M_AXI_ARVALID          (M_AXI_ARVALID  )
    ,   .M_AXI_ARREADY          (M_AXI_ARREADY  )

    //----------------Read Data Channel----------------//
    ,   .M_AXI_RID              (M_AXI_RID      )
    ,   .M_AXI_RDATA            (M_AXI_RDATA    )
    ,   .M_AXI_RRESP            (M_AXI_RRESP    )
    ,   .M_AXI_RLAST            (M_AXI_RLAST    )
    ,   .M_AXI_RUSER            (M_AXI_RUSER    )
    ,   .M_AXI_RVALID           (M_AXI_RVALID   )
    ,   .M_AXI_RREADY           (M_AXI_RREADY   )
*/
);


// saxis_v1_0_S00_AXIS#(
//     // Users to add parameters here

//     // User parameters ends
//     // Do not modify the parameters beyond this line

//     // AXI4Stream sink: Data Width
//         .C_S_AXIS_TDATA_WIDTH (32)
// )u_saxis_v1_0_S00_AXIS(
//     // Users to add ports here

//     // User ports ends
//     // Do not modify the ports beyond this line

//     // AXI4Stream sink: Clock
//         .S_AXIS_ACLK    (AXIS_ACLK      )
//     // AXI4Stream sink: Reset
//     ,   .S_AXIS_ARESETN (AXIS_ARESETN   )
//     // Ready to accept data in
//     ,   .S_AXIS_TREADY  (AXIS_TREADY    )
//     // Data in
//     ,   .S_AXIS_TDATA   (AXIS_TDATA     )
//     // Byte qualifier
//     ,   .S_AXIS_TSTRB   (AXIS_TSTRB     )
//     // Indicates boundary of last packet
//     ,   .S_AXIS_TLAST   (AXIS_TLAST     )
//     // Data is in valid
//     ,   .S_AXIS_TVALID  (AXIS_TVALID    )
// );





// function called clogb2 that returns an integer which has the 
// value of the ceiling of the log base 2.
function integer clogb2 (input integer bit_depth);
begin
for(clogb2=0; bit_depth>0; clogb2=clogb2+1)
	bit_depth = bit_depth >> 1;
end
endfunction // WAIT_COUNT_BITS is the width of the wait counter.

endmodule
