/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_pmendoza_ieee_tinyscan (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);




  // List all unused inputs to prevent warnings
  wire _unused = &{ena, uio_in[3:0], 1'b0};
  
  
    uni_reg u0 (
    .clk(clk),
    .reset(rst_n),
    .control(uio_in[7:4]),
    .data_i(ui_in[7:4]),
    .data_o(uo_out[3:0]),
    .SI(ui_in[0]), .SE(ui_in[1]), .SO(uio_out[0])
  );
  
  
  uni_reg_e u1 (
    .clk(clk),
    .reset(rst_n),
    .control(uio_in[7:4]),
    .data_i(ui_in[7:4]),
    .data_o(uo_out[7:4]),
    .SI(ui_in[2]), .SE(ui_in[3]), .SO(uio_out[1]), .ERR(uio_in[3:2])
  );
  
    
  assign uio_oe  = 8'b00000011;
  // All output pins must be assigned. If not used, assign to 0.
  assign uio_out[7:2] = 0;
  

endmodule