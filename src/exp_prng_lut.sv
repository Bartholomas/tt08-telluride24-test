`default_nettype none
`include "./lfsr.sv"
`include "./log_lut_rom.sv"

module exp_prng_lut #(
    // lfsr parameters
    parameter LFSR_STATE_WID = 32,
    parameter LFSR_OUT_WID = 6,
    // log_lut_rom parameters
    parameter NUM_SEGMENTS = 64,
    parameter U_WID = 6,
    parameter X_WID = 16
)(
    input wire clk_i,
    input wire rst_i,
    output bit signed [X_WID-1:0] prng_o
);

    // Internal signals
    logic [LFSR_OUT_WID-1:0] lfsr_o;
    // logic [X_WID-1:0] x_o;

    // Instantiate lfsr
    lfsr #(
        .LFSR_STATE_WID(LFSR_STATE_WID),
        .LFSR_OUT_WID(LFSR_OUT_WID)
    ) lfsr_module (
        .clk(clk_i),
        .rst_i(rst_i),
        .lfsr_o(lfsr_o)
    );

    // Instantiate log_lut_rom
    log_lut_rom #(
        .NUM_SEGMENTS(NUM_SEGMENTS),
        .U_WID(U_WID),
        .X_WID(X_WID)
    ) log_lut_rom_module (
        .clk(clk_i),
        .u_i(lfsr_o),
        .x_o(prng_o)
    );

    // always @(posedge clk_i) begin
    //     prng_o <= x_o;
    // end

endmodule: exp_prng_lut