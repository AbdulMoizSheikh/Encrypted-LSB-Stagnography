module user_project_wrapper (user_clock2,
    vccd1,
    vccd2,
    vdda1,
    vdda2,
    vssa1,
    vssa2,
    vssd1,
    vssd2,
    wb_clk_i,
    wb_rst_i,
    wbs_ack_o,
    wbs_cyc_i,
    wbs_stb_i,
    wbs_we_i,
    analog_io,
    io_in,
    io_oeb,
    io_out,
    la_data_in,
    la_data_out,
    la_oenb,
    user_irq,
    wbs_adr_i,
    wbs_dat_i,
    wbs_dat_o,
    wbs_sel_i);
 input user_clock2;
 input vccd1;
 input vccd2;
 input vdda1;
 input vdda2;
 input vssa1;
 input vssa2;
 input vssd1;
 input vssd2;
 input wb_clk_i;
 input wb_rst_i;
 output wbs_ack_o;
 input wbs_cyc_i;
 input wbs_stb_i;
 input wbs_we_i;
 inout [28:0] analog_io;
 input [37:0] io_in;
 output [37:0] io_oeb;
 output [37:0] io_out;
 input [127:0] la_data_in;
 output [127:0] la_data_out;
 input [127:0] la_oenb;
 output [2:0] user_irq;
 input [31:0] wbs_adr_i;
 input [31:0] wbs_dat_i;
 output [31:0] wbs_dat_o;
 input [3:0] wbs_sel_i;


 select_wrapper sel (.VGND(vssd1),
    .VPWR(vccd1),
    .clk_flag(io_out[4]),
    .clk_p(user_clock2),
    .clk_wb(wb_clk_i),
    .cover_p(io_in[5]),
    .data1(io_in[2]),
    .data2(io_in[3]),
    .flag1(io_out[1]),
    .flag2(io_out[2]),
    .flag4(io_out[3]),
    .flag5(io_out[5]),
    .flag6(io_out[6]),
    .key1(io_in[0]),
    .key2(io_in[1]),
    .out_p(io_out[0]),
    .rst_p(io_in[4]),
    .rst_wb(wb_rst_i),
    .sel(io_in[6]),
    .wb_ack(wbs_ack_o),
    .wb_cyc(wbs_cyc_i),
    .wb_stb(wbs_stb_i),
    .wb_we(wbs_we_i),
    .cover_wb({wbs_dat_i[7],
    wbs_dat_i[6],
    wbs_dat_i[5],
    wbs_dat_i[4],
    wbs_dat_i[3],
    wbs_dat_i[2],
    wbs_dat_i[1],
    wbs_dat_i[0]}),
    .out_wb({wbs_dat_o[7],
    wbs_dat_o[6],
    wbs_dat_o[5],
    wbs_dat_o[4],
    wbs_dat_o[3],
    wbs_dat_o[2],
    wbs_dat_o[1],
    wbs_dat_o[0]}));
endmodule
