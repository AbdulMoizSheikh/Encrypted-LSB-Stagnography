// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none
/*
 *-------------------------------------------------------------
 *
 * user_project_wrapper
 *
 * This wrapper enumerates all of the pins available to the
 * user for the user project.
 *
 * An example user project is provided in this wrapper.  The
 * example should be removed and replaced with the actual
 * user project.
 *
 *-------------------------------------------------------------
 */

module user_project_wrapper #(
    parameter BITS = 32
) (
`ifdef USE_POWER_PINS
    inout vdda1,	// User area 1 3.3V supply
    inout vdda2,	// User area 2 3.3V supply
    inout vssa1,	// User area 1 analog ground
    inout vssa2,	// User area 2 analog ground
    inout vccd1,	// User area 1 1.8V supply
    inout vccd2,	// User area 2 1.8v supply
    inout vssd1,	// User area 1 digital ground
    inout vssd2,	// User area 2 digital ground
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

    // Analog (direct connection to GPIO pad---use with caution)
    // Note that analog I/O is not available on the 7 lowest-numbered
    // GPIO pads, and so the analog_io indexing is offset from the
    // GPIO indexing by 7 (also upper 2 GPIOs do not have analog_io).
    inout [`MPRJ_IO_PADS-10:0] analog_io,

    // Independent clock (on independent integer divider)
    input   user_clock2,

    // User maskable interrupt signals
    output [2:0] user_irq
);

/*--------------------------------------*/
/* User project is instantiated  here   */
/*--------------------------------------*/

select_wrapper sel (
`ifdef USE_POWER_PINS
.vccd1(vccd1), 
.vssd1(vssd1),
`endif
.rst_wb(wb_rst_i),
.clk_wb(wb_clk_i),
.cover_wb(wbs_dat_i [7:0]),
.wb_cyc(wbs_cyc_i),
.wb_stb(wbs_stb_i),
.wb_we(wbs_we_i),
.wb_ack(wbs_ack_o),
.key1(io_in [0]),
.key2(io_in [1]),
.out_p(io_out [0]),
.out_wb(wbs_dat_o [7:0]),
.data1(io_in [2]),
.data2(io_in [3]),
.flag1(io_out [1]),
.flag2(io_out [2]),
.flag4(io_out [3]),
.clk_p(user_clock2),
.rst_p(io_in [4]),
.cover_p(io_in [5]),
.sel(io_in [6]),
.clk_flag(io_out [4]),
.flag5(io_out [5]),
.flag6(io_out [6]) );
endmodule
`default_nettype wire

//(* blackbox *)
//module OpampM ( inout vccd1, )

(* blackbox *)
module select_wrapper(

`ifdef USE_POWER_PINS
inout vccd1,
inout vssd1,
`endif
input rst_wb,
input clk_wb,
input [7:0] cover_wb,
input wb_cyc,wb_stb,wb_we,


input key1,key2,
input data1,data2,


input sel,

input clk_p,rst_p,cover_p,

output flag1,flag2,

output  [7:0] out_wb, 
output out_p,        
output  clk_flag,    
output wb_ack,     
output flag5,flag6,
output flag4,
);
endmodule
