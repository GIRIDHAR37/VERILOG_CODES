module sc(
    input clk,           // Clock input
    input rst,           // Reset input
    output reg [2:0] q,  // 3-bit output for current state
    output reg count // 16-bit counter to track number of sequences
);

    reg [2:0] next_state; // To store the next state

    // State transition logic
    always @(*) begin
        case (q)
            3'b000:begin next_state = 3'b001; count=1'b0; end // 0 -> 1
            3'b001:begin next_state = 3'b011; count=1'b0; end // 1 -> 3
            3'b011:begin next_state = 3'b111; count=1'b0; end // 3 -> 7
            3'b111:begin next_state = 3'b110; count=1'b0; end // 7 -> 6
            3'b110:begin next_state = 3'b100; count=1'b0; end // 6 -> 4
            3'b100:begin next_state = 3'b000; count=1'b1; end // 4 -> 0
            default:begin next_state = 3'b000; count=1'b0; end // Default to state 0
        endcase
    end

    // Flip-flop to store the current state
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            q <= 3'b000;  // Reset to state 0
            count <= 16'b0; // Reset counter
        end else begin
            q <= next_state;  // Update to next state
        end
    end

endmodule

// output :
/*

*/

