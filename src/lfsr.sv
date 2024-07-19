`default_nettype none

module lfsr #(
    parameter LFSR_STATE_WID = 32,
    parameter LFSR_OUT_WID = 6
)(
    input wire clk,
    input wire rst_i,
    output logic [LFSR_OUT_WID-1:0] lfsr_o
);

    logic [LFSR_STATE_WID-1:0] lfsr_state = 'b01;

    always @(posedge clk) begin

        // Update LFSR state
        if (rst_i) begin
            lfsr_state <= 'b01;
        end else begin
            // lfsr_state <= {lfsr_state[LFSR_STATE_WID-2:0], lfsr_state[3]^lfsr_state[2]};    // LFSR_STATE_WID=4
            lfsr_state <= {lfsr_state[LFSR_STATE_WID-2:0], lfsr_state[31] ^ lfsr_state[21] ^ lfsr_state[1] ^ lfsr_state[0]};    // LFSR_STATE_WID=32
        end

        // Assign output bit(s)
        lfsr_o <= lfsr_state[LFSR_STATE_WID-1:LFSR_STATE_WID-LFSR_OUT_WID];
    end

endmodule: lfsr

