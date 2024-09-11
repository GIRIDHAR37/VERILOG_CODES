module ksa(
    input [3:0] a, b,     // First operand and second operand
    input c_in,           // Carry-in input
    output [3:0] s,       // Sum of A and B
    output c_out          // Final carry-out
);

    wire [3:0] p, g;      // Propagate and Generate signals
    wire [3:0] c;         // Internal Carry signals

    // Step 1: Generate and Propagate signals
    assign p = a ^ b;     // Propagate signals
    assign g = a & b;     // Generate signals

    // Step 2: Prefix tree (carry computation)
    // Layer 1
    wire g1_0 = g[1] | (p[1] & g[0]);
    wire p1_0 = p[1] & p[0];

    wire g2_1 = g[2] | (p[2] & g1_0);
    wire p2_1 = p[2] & p1_0;

    wire g3_2 = g[3] | (p[3] & g2_1);
    
    // Step 3: Carry Propagation using c_in as the initial carry input
    assign c[0] = c_in;     // The first carry comes from c_in
    assign c[1] = g[0] | (p[0] & c_in);   // Carry for bit 1
    assign c[2] = g1_0 | (p1_0 & c_in);   // Carry for bit 2
    assign c[3] = g2_1 | (p2_1 & c_in);   // Carry for bit 3

    // Final carry-out
    assign c_out = g3_2 | (p[3] & c[3]);  // Final carry-out

    // Step 4: Final Sum computation
    assign s = p ^ c;  // Sum for each bit is the XOR of propagate and carry

endmodule

// output :
/*
# Time = 0 | a = 1001 | b = 0010 | c_in = 0 | s = 1011 | cout = 0
# Time = 10 | a = 0100 | b = 0000 | c_in = 1 | s = 0101 | cout = 0
# Time = 20 | a = 0000 | b = 0100 | c_in = 1 | s = 0101 | cout = 0
# Time = 30 | a = 0011 | b = 0001 | c_in = 1 | s = 0101 | cout = 0
# Time = 40 | a = 1000 | b = 0110 | c_in = 1 | s = 1111 | cout = 0
# Time = 50 | a = 1100 | b = 0110 | c_in = 1 | s = 0011 | cout = 1
# Time = 60 | a = 0011 | b = 0010 | c_in = 1 | s = 0110 | cout = 0
# Time = 70 | a = 0000 | b = 1001 | c_in = 0 | s = 1001 | cout = 0
# Time = 80 | a = 1000 | b = 0000 | c_in = 1 | s = 1001 | cout = 0
# Time = 90 | a = 1000 | b = 0110 | c_in = 1 | s = 1111 | cout = 0
# Time = 100 | a = 1011 | b = 1011 | c_in = 0 | s = 0110 | cout = 1
# Time = 110 | a = 1001 | b = 1110 | c_in = 1 | s = 1000 | cout = 1
# Time = 120 | a = 1111 | b = 0110 | c_in = 1 | s = 0110 | cout = 1
# Time = 130 | a = 1100 | b = 0110 | c_in = 0 | s = 0010 | cout = 1
# Time = 140 | a = 1111 | b = 1100 | c_in = 1 | s = 1100 | cout = 1
# Time = 150 | a = 0110 | b = 0011 | c_in = 0 | s = 1001 | cout = 0
# Time = 160 | a = 0110 | b = 0010 | c_in = 1 | s = 1001 | cout = 0
# Time = 170 | a = 0101 | b = 0101 | c_in = 0 | s = 1010 | cout = 0
# Time = 180 | a = 1111 | b = 0010 | c_in = 1 | s = 0010 | cout = 1
# Time = 190 | a = 0011 | b = 1011 | c_in = 1 | s = 1111 | cout = 0
# ** Note: $finish    : ksa_tb.v(34)
#    Time: 400 ps  Iteration: 0  Instance: /ksa_tb
*/
