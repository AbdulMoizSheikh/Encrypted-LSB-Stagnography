`default_nettype none

module user_proj_dummy 
(
`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,

    // IOs
    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,

    // IRQ
    output [2:0] irq,
    // Independent clock (on independent integer divider)
    input   user_clock2
);
    reg start;
    wire done;
    wire sys_clk;
    //  WB Interface
    //  3 32 regsisters:
    //  MP  (RW)    0x00 
    //  MC  (RW)    0x04
    //  P   (RO)    0x08
    
    // IO
    // Not used

    // LA
    // Not used

    // IRQ
    assign irq = 3'b000;	// Unused

    dummy uut (
        .clk(user_clock2),
        .in(io_in[10:0]),
        .out(io_out[3:0]),
        .flag1(io_out[4]),
        .flag2(io_out[5]),
        .wb_rst(wb_rst_i),
        .wb_clk(wb_clk_i)
    );

endmodule
