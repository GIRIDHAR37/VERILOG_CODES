module csa(
    input [3:0] A,  // 4-bit input A
    input [3:0] B,  // 4-bit input B
    input Cin,      // Carry input
    output [3:0] S, // 4-bit sum output
    output Cout     // Carry output
);

    wire [3:0] sum0, sum1;    // sum when carry is 0 and 1
    wire [3:1] carry0, carry1; // carry when Cin = 0 and Cin = 1
    wire mux_cout;            // selected carry output

    // Full Adder when Cin = 0
    full_adder FA0_0(.A(A[0]), .B(B[0]), .Cin(1'b0), .Sum(sum0[0]), .Cout(carry0[1]));
    full_adder FA1_0(.A(A[1]), .B(B[1]), .Cin(carry0[1]), .Sum(sum0[1]), .Cout(carry0[2]));
    full_adder FA2_0(.A(A[2]), .B(B[2]), .Cin(carry0[2]), .Sum(sum0[2]), .Cout(carry0[3]));
    full_adder FA3_0(.A(A[3]), .B(B[3]), .Cin(carry0[3]), .Sum(sum0[3]), .Cout(mux_cout));

    // Full Adder when Cin = 1
    full_adder FA0_1(.A(A[0]), .B(B[0]), .Cin(1'b1), .Sum(sum1[0]), .Cout(carry1[1]));
    full_adder FA1_1(.A(A[1]), .B(B[1]), .Cin(carry1[1]), .Sum(sum1[1]), .Cout(carry1[2]));
    full_adder FA2_1(.A(A[2]), .B(B[2]), .Cin(carry1[2]), .Sum(sum1[2]), .Cout(carry1[3]));
    full_adder FA3_1(.A(A[3]), .B(B[3]), .Cin(carry1[3]), .Sum(sum1[3]), .Cout(Cout));

    // Multiplexers to select sum based on Cin
    mux2x1 MUX0(.in0(sum0[0]), .in1(sum1[0]), .sel(Cin), .out(S[0]));
    mux2x1 MUX1(.in0(sum0[1]), .in1(sum1[1]), .sel(Cin), .out(S[1]));
    mux2x1 MUX2(.in0(sum0[2]), .in1(sum1[2]), .sel(Cin), .out(S[2]));
    mux2x1 MUX3(.in0(sum0[3]), .in1(sum1[3]), .sel(Cin), .out(S[3]));

    // Multiplexer to select carry output based on Cin
    mux2x1 MUX_COUT(.in0(mux_cout), .in1(carry1[3]), .sel(Cin), .out(Cout));

endmodule

// Full Adder module
module full_adder (
    input A,       // 1-bit input A
    input B,       // 1-bit input B
    input Cin,     // Carry input
    output Sum,    // 1-bit sum output
    output Cout    // 1-bit carry output
);

    assign Sum = A ^ B ^ Cin;
    assign Cout = (A & B) | (B & Cin) | (Cin & A);

endmodule

// 2x1 Multiplexer Module
module mux2x1 (
    input in0,     // Input 0
    input in1,     // Input 1
    input sel,     // Select signal
    output out     // Output
);

    assign out = (sel) ? in1 : in0;

endmodule

// output :
/*
# Time = 0 | a = 1001 | b = 0010 | cin = 0 | s = 1011 | cout = 0
# Time = 10 | a = 0100 | b = 0000 | cin = 1 | s = 0101 | cout = 0
# Time = 20 | a = 0000 | b = 0100 | cin = 1 | s = 0101 | cout = 0
# Time = 30 | a = 0011 | b = 0001 | cin = 1 | s = 0101 | cout = 0
# Time = 40 | a = 1000 | b = 0110 | cin = 1 | s = 1111 | cout = 0
# Time = 50 | a = 1100 | b = 0110 | cin = 1 | s = 0011 | cout = 1
# Time = 60 | a = 0011 | b = 0010 | cin = 1 | s = 0110 | cout = 0
# Time = 70 | a = 0000 | b = 1001 | cin = 0 | s = 1001 | cout = 0
# Time = 80 | a = 1000 | b = 0000 | cin = 1 | s = 1001 | cout = 0
# Time = 90 | a = 1000 | b = 0110 | cin = 1 | s = 1111 | cout = 0
# Time = 100 | a = 1011 | b = 1011 | cin = 0 | s = 0110 | cout = 1
# Time = 110 | a = 1001 | b = 1110 | cin = 1 | s = 1000 | cout = 1
# Time = 120 | a = 1111 | b = 0110 | cin = 1 | s = 0110 | cout = 1
# Time = 130 | a = 1100 | b = 0110 | cin = 0 | s = 0010 | cout = 1
# Time = 140 | a = 1111 | b = 1100 | cin = 1 | s = 1100 | cout = 1
# Time = 150 | a = 0110 | b = 0011 | cin = 0 | s = 1001 | cout = 0
# Time = 160 | a = 0110 | b = 0010 | cin = 1 | s = 1001 | cout = x
# Time = 170 | a = 0101 | b = 0101 | cin = 0 | s = 1010 | cout = 0
# Time = 180 | a = 1111 | b = 0010 | cin = 1 | s = 0010 | cout = 1
# Time = 190 | a = 0011 | b = 1011 | cin = 1 | s = 1111 | cout = 0
# ** Note: $finish    : csa_tb.v(35)
#    Time: 400 ps  Iteration: 0  Instance: /csa_tb
*/
