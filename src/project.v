/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none
`include "./exp_prng_lut.sv"


module tt_um_exp_prng_lfsr (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  wire [16-1:0] result;

  exp_prng_lut #(
      .LFSR_STATE_WID(32),
      .LFSR_OUT_WID(6),
      .NUM_SEGMENTS(64),
      .U_WID(6),
      .X_WID(16)
  )(
      .clk_i(clk),
      .rst_i(!rst_n),
      .prng_o(result)
  );

  assign uo_out = result[15:8];
  assign uio_out = result[7:0];
  assign uio_oe = 8'b1111_1111;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
