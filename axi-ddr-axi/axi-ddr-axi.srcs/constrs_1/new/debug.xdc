create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list design_1_i/zynq_ultra_ps_e_0/inst/pl_clk0]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 24 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {design_1_i/fdma_test_0/inst/tpg_data_i[0]} {design_1_i/fdma_test_0/inst/tpg_data_i[1]} {design_1_i/fdma_test_0/inst/tpg_data_i[2]} {design_1_i/fdma_test_0/inst/tpg_data_i[3]} {design_1_i/fdma_test_0/inst/tpg_data_i[4]} {design_1_i/fdma_test_0/inst/tpg_data_i[5]} {design_1_i/fdma_test_0/inst/tpg_data_i[6]} {design_1_i/fdma_test_0/inst/tpg_data_i[7]} {design_1_i/fdma_test_0/inst/tpg_data_i[8]} {design_1_i/fdma_test_0/inst/tpg_data_i[9]} {design_1_i/fdma_test_0/inst/tpg_data_i[10]} {design_1_i/fdma_test_0/inst/tpg_data_i[11]} {design_1_i/fdma_test_0/inst/tpg_data_i[12]} {design_1_i/fdma_test_0/inst/tpg_data_i[13]} {design_1_i/fdma_test_0/inst/tpg_data_i[14]} {design_1_i/fdma_test_0/inst/tpg_data_i[15]} {design_1_i/fdma_test_0/inst/tpg_data_i[16]} {design_1_i/fdma_test_0/inst/tpg_data_i[17]} {design_1_i/fdma_test_0/inst/tpg_data_i[18]} {design_1_i/fdma_test_0/inst/tpg_data_i[19]} {design_1_i/fdma_test_0/inst/tpg_data_i[20]} {design_1_i/fdma_test_0/inst/tpg_data_i[21]} {design_1_i/fdma_test_0/inst/tpg_data_i[22]} {design_1_i/fdma_test_0/inst/tpg_data_i[23]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 5 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {design_1_i/fdma_test_0/inst/fdma_waddr_r[27]} {design_1_i/fdma_test_0/inst/fdma_waddr_r[28]} {design_1_i/fdma_test_0/inst/fdma_waddr_r[29]} {design_1_i/fdma_test_0/inst/fdma_waddr_r[30]} {design_1_i/fdma_test_0/inst/fdma_waddr_r[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 128 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {design_1_i/fdma_test_0/inst/fdma_wdata[0]} {design_1_i/fdma_test_0/inst/fdma_wdata[1]} {design_1_i/fdma_test_0/inst/fdma_wdata[2]} {design_1_i/fdma_test_0/inst/fdma_wdata[3]} {design_1_i/fdma_test_0/inst/fdma_wdata[4]} {design_1_i/fdma_test_0/inst/fdma_wdata[5]} {design_1_i/fdma_test_0/inst/fdma_wdata[6]} {design_1_i/fdma_test_0/inst/fdma_wdata[7]} {design_1_i/fdma_test_0/inst/fdma_wdata[8]} {design_1_i/fdma_test_0/inst/fdma_wdata[9]} {design_1_i/fdma_test_0/inst/fdma_wdata[10]} {design_1_i/fdma_test_0/inst/fdma_wdata[11]} {design_1_i/fdma_test_0/inst/fdma_wdata[12]} {design_1_i/fdma_test_0/inst/fdma_wdata[13]} {design_1_i/fdma_test_0/inst/fdma_wdata[14]} {design_1_i/fdma_test_0/inst/fdma_wdata[15]} {design_1_i/fdma_test_0/inst/fdma_wdata[16]} {design_1_i/fdma_test_0/inst/fdma_wdata[17]} {design_1_i/fdma_test_0/inst/fdma_wdata[18]} {design_1_i/fdma_test_0/inst/fdma_wdata[19]} {design_1_i/fdma_test_0/inst/fdma_wdata[20]} {design_1_i/fdma_test_0/inst/fdma_wdata[21]} {design_1_i/fdma_test_0/inst/fdma_wdata[22]} {design_1_i/fdma_test_0/inst/fdma_wdata[23]} {design_1_i/fdma_test_0/inst/fdma_wdata[24]} {design_1_i/fdma_test_0/inst/fdma_wdata[25]} {design_1_i/fdma_test_0/inst/fdma_wdata[26]} {design_1_i/fdma_test_0/inst/fdma_wdata[27]} {design_1_i/fdma_test_0/inst/fdma_wdata[28]} {design_1_i/fdma_test_0/inst/fdma_wdata[29]} {design_1_i/fdma_test_0/inst/fdma_wdata[30]} {design_1_i/fdma_test_0/inst/fdma_wdata[31]} {design_1_i/fdma_test_0/inst/fdma_wdata[32]} {design_1_i/fdma_test_0/inst/fdma_wdata[33]} {design_1_i/fdma_test_0/inst/fdma_wdata[34]} {design_1_i/fdma_test_0/inst/fdma_wdata[35]} {design_1_i/fdma_test_0/inst/fdma_wdata[36]} {design_1_i/fdma_test_0/inst/fdma_wdata[37]} {design_1_i/fdma_test_0/inst/fdma_wdata[38]} {design_1_i/fdma_test_0/inst/fdma_wdata[39]} {design_1_i/fdma_test_0/inst/fdma_wdata[40]} {design_1_i/fdma_test_0/inst/fdma_wdata[41]} {design_1_i/fdma_test_0/inst/fdma_wdata[42]} {design_1_i/fdma_test_0/inst/fdma_wdata[43]} {design_1_i/fdma_test_0/inst/fdma_wdata[44]} {design_1_i/fdma_test_0/inst/fdma_wdata[45]} {design_1_i/fdma_test_0/inst/fdma_wdata[46]} {design_1_i/fdma_test_0/inst/fdma_wdata[47]} {design_1_i/fdma_test_0/inst/fdma_wdata[48]} {design_1_i/fdma_test_0/inst/fdma_wdata[49]} {design_1_i/fdma_test_0/inst/fdma_wdata[50]} {design_1_i/fdma_test_0/inst/fdma_wdata[51]} {design_1_i/fdma_test_0/inst/fdma_wdata[52]} {design_1_i/fdma_test_0/inst/fdma_wdata[53]} {design_1_i/fdma_test_0/inst/fdma_wdata[54]} {design_1_i/fdma_test_0/inst/fdma_wdata[55]} {design_1_i/fdma_test_0/inst/fdma_wdata[56]} {design_1_i/fdma_test_0/inst/fdma_wdata[57]} {design_1_i/fdma_test_0/inst/fdma_wdata[58]} {design_1_i/fdma_test_0/inst/fdma_wdata[59]} {design_1_i/fdma_test_0/inst/fdma_wdata[60]} {design_1_i/fdma_test_0/inst/fdma_wdata[61]} {design_1_i/fdma_test_0/inst/fdma_wdata[62]} {design_1_i/fdma_test_0/inst/fdma_wdata[63]} {design_1_i/fdma_test_0/inst/fdma_wdata[64]} {design_1_i/fdma_test_0/inst/fdma_wdata[65]} {design_1_i/fdma_test_0/inst/fdma_wdata[66]} {design_1_i/fdma_test_0/inst/fdma_wdata[67]} {design_1_i/fdma_test_0/inst/fdma_wdata[68]} {design_1_i/fdma_test_0/inst/fdma_wdata[69]} {design_1_i/fdma_test_0/inst/fdma_wdata[70]} {design_1_i/fdma_test_0/inst/fdma_wdata[71]} {design_1_i/fdma_test_0/inst/fdma_wdata[72]} {design_1_i/fdma_test_0/inst/fdma_wdata[73]} {design_1_i/fdma_test_0/inst/fdma_wdata[74]} {design_1_i/fdma_test_0/inst/fdma_wdata[75]} {design_1_i/fdma_test_0/inst/fdma_wdata[76]} {design_1_i/fdma_test_0/inst/fdma_wdata[77]} {design_1_i/fdma_test_0/inst/fdma_wdata[78]} {design_1_i/fdma_test_0/inst/fdma_wdata[79]} {design_1_i/fdma_test_0/inst/fdma_wdata[80]} {design_1_i/fdma_test_0/inst/fdma_wdata[81]} {design_1_i/fdma_test_0/inst/fdma_wdata[82]} {design_1_i/fdma_test_0/inst/fdma_wdata[83]} {design_1_i/fdma_test_0/inst/fdma_wdata[84]} {design_1_i/fdma_test_0/inst/fdma_wdata[85]} {design_1_i/fdma_test_0/inst/fdma_wdata[86]} {design_1_i/fdma_test_0/inst/fdma_wdata[87]} {design_1_i/fdma_test_0/inst/fdma_wdata[88]} {design_1_i/fdma_test_0/inst/fdma_wdata[89]} {design_1_i/fdma_test_0/inst/fdma_wdata[90]} {design_1_i/fdma_test_0/inst/fdma_wdata[91]} {design_1_i/fdma_test_0/inst/fdma_wdata[92]} {design_1_i/fdma_test_0/inst/fdma_wdata[93]} {design_1_i/fdma_test_0/inst/fdma_wdata[94]} {design_1_i/fdma_test_0/inst/fdma_wdata[95]} {design_1_i/fdma_test_0/inst/fdma_wdata[96]} {design_1_i/fdma_test_0/inst/fdma_wdata[97]} {design_1_i/fdma_test_0/inst/fdma_wdata[98]} {design_1_i/fdma_test_0/inst/fdma_wdata[99]} {design_1_i/fdma_test_0/inst/fdma_wdata[100]} {design_1_i/fdma_test_0/inst/fdma_wdata[101]} {design_1_i/fdma_test_0/inst/fdma_wdata[102]} {design_1_i/fdma_test_0/inst/fdma_wdata[103]} {design_1_i/fdma_test_0/inst/fdma_wdata[104]} {design_1_i/fdma_test_0/inst/fdma_wdata[105]} {design_1_i/fdma_test_0/inst/fdma_wdata[106]} {design_1_i/fdma_test_0/inst/fdma_wdata[107]} {design_1_i/fdma_test_0/inst/fdma_wdata[108]} {design_1_i/fdma_test_0/inst/fdma_wdata[109]} {design_1_i/fdma_test_0/inst/fdma_wdata[110]} {design_1_i/fdma_test_0/inst/fdma_wdata[111]} {design_1_i/fdma_test_0/inst/fdma_wdata[112]} {design_1_i/fdma_test_0/inst/fdma_wdata[113]} {design_1_i/fdma_test_0/inst/fdma_wdata[114]} {design_1_i/fdma_test_0/inst/fdma_wdata[115]} {design_1_i/fdma_test_0/inst/fdma_wdata[116]} {design_1_i/fdma_test_0/inst/fdma_wdata[117]} {design_1_i/fdma_test_0/inst/fdma_wdata[118]} {design_1_i/fdma_test_0/inst/fdma_wdata[119]} {design_1_i/fdma_test_0/inst/fdma_wdata[120]} {design_1_i/fdma_test_0/inst/fdma_wdata[121]} {design_1_i/fdma_test_0/inst/fdma_wdata[122]} {design_1_i/fdma_test_0/inst/fdma_wdata[123]} {design_1_i/fdma_test_0/inst/fdma_wdata[124]} {design_1_i/fdma_test_0/inst/fdma_wdata[125]} {design_1_i/fdma_test_0/inst/fdma_wdata[126]} {design_1_i/fdma_test_0/inst/fdma_wdata[127]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 16 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {design_1_i/fdma_test_0/inst/fdma_wsize[0]} {design_1_i/fdma_test_0/inst/fdma_wsize[1]} {design_1_i/fdma_test_0/inst/fdma_wsize[2]} {design_1_i/fdma_test_0/inst/fdma_wsize[3]} {design_1_i/fdma_test_0/inst/fdma_wsize[4]} {design_1_i/fdma_test_0/inst/fdma_wsize[5]} {design_1_i/fdma_test_0/inst/fdma_wsize[6]} {design_1_i/fdma_test_0/inst/fdma_wsize[7]} {design_1_i/fdma_test_0/inst/fdma_wsize[8]} {design_1_i/fdma_test_0/inst/fdma_wsize[9]} {design_1_i/fdma_test_0/inst/fdma_wsize[10]} {design_1_i/fdma_test_0/inst/fdma_wsize[11]} {design_1_i/fdma_test_0/inst/fdma_wsize[12]} {design_1_i/fdma_test_0/inst/fdma_wsize[13]} {design_1_i/fdma_test_0/inst/fdma_wsize[14]} {design_1_i/fdma_test_0/inst/fdma_wsize[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 32 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {design_1_i/fdma_test_0/inst/fdma_waddr[0]} {design_1_i/fdma_test_0/inst/fdma_waddr[1]} {design_1_i/fdma_test_0/inst/fdma_waddr[2]} {design_1_i/fdma_test_0/inst/fdma_waddr[3]} {design_1_i/fdma_test_0/inst/fdma_waddr[4]} {design_1_i/fdma_test_0/inst/fdma_waddr[5]} {design_1_i/fdma_test_0/inst/fdma_waddr[6]} {design_1_i/fdma_test_0/inst/fdma_waddr[7]} {design_1_i/fdma_test_0/inst/fdma_waddr[8]} {design_1_i/fdma_test_0/inst/fdma_waddr[9]} {design_1_i/fdma_test_0/inst/fdma_waddr[10]} {design_1_i/fdma_test_0/inst/fdma_waddr[11]} {design_1_i/fdma_test_0/inst/fdma_waddr[12]} {design_1_i/fdma_test_0/inst/fdma_waddr[13]} {design_1_i/fdma_test_0/inst/fdma_waddr[14]} {design_1_i/fdma_test_0/inst/fdma_waddr[15]} {design_1_i/fdma_test_0/inst/fdma_waddr[16]} {design_1_i/fdma_test_0/inst/fdma_waddr[17]} {design_1_i/fdma_test_0/inst/fdma_waddr[18]} {design_1_i/fdma_test_0/inst/fdma_waddr[19]} {design_1_i/fdma_test_0/inst/fdma_waddr[20]} {design_1_i/fdma_test_0/inst/fdma_waddr[21]} {design_1_i/fdma_test_0/inst/fdma_waddr[22]} {design_1_i/fdma_test_0/inst/fdma_waddr[23]} {design_1_i/fdma_test_0/inst/fdma_waddr[24]} {design_1_i/fdma_test_0/inst/fdma_waddr[25]} {design_1_i/fdma_test_0/inst/fdma_waddr[26]} {design_1_i/fdma_test_0/inst/fdma_waddr[27]} {design_1_i/fdma_test_0/inst/fdma_waddr[28]} {design_1_i/fdma_test_0/inst/fdma_waddr[29]} {design_1_i/fdma_test_0/inst/fdma_waddr[30]} {design_1_i/fdma_test_0/inst/fdma_waddr[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 1 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list design_1_i/fdma_test_0/inst/fdma_rstn]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 1 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list design_1_i/fdma_test_0/inst/fdma_wareq]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 1 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list design_1_i/fdma_test_0/inst/fdma_wbusy]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 1 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list design_1_i/fdma_test_0/inst/fdma_wready]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 1 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list design_1_i/fdma_test_0/inst/fdma_wvalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 1 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list design_1_i/fdma_test_0/inst/tpg_de_i]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 1 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list design_1_i/fdma_test_0/inst/tpg_hs_i]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 1 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list design_1_i/fdma_test_0/inst/tpg_rstn_i]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 1 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list design_1_i/fdma_test_0/inst/tpg_vs_i]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets u_ila_0_pl_clk0]
