module pfa#(parameter SIZE=16)(
    input [SIZE-1:0] a, b,
    input c_in,
    output [SIZE-1:0] s,
    output c_out
);
    wire [SIZE:0] c_in_vec;
    genvar i;

    assign c_in_vec[0] = c_in;
    assign c_out = c_in_vec[SIZE];

    generate
        for (i = 0; i < SIZE; i = i + 1) begin
            fa fa_inst (
                .a(a[i]),
                .b(b[i]),
                .c_in(c_in_vec[i]),
                .s(s[i]),
                .c_out(c_in_vec[i + 1])
            );
        end
    endgenerate
endmodule

// Full Adder Module
module fa(
    input a, b,
    input c_in,
    output s,
    output c_out
);
    assign s = a ^ b ^ c_in;
    assign c_out = (a & b) | (b & c_in) | (c_in & a);
endmodule

// output :
/*
# Time = 0 | a = 26952 | b = 4109 | cin = 0 | s = 31061 | cout = 0
# Time = 10 | a = 29907 | b = 31514 | cin = 1 | s = 61422 | cout = 0
# Time = 20 | a = 43202 | b = 21116 | cin = 1 | s = 64319 | cout = 0
# Time = 30 | a = 12075 | b = 26499 | cin = 1 | s = 38575 | cout = 0
# Time = 40 | a = 30048 | b = 57044 | cin = 1 | s = 21557 | cout = 1
# Time = 50 | a = 45689 | b = 63278 | cin = 1 | s = 43432 | cout = 1
# Time = 60 | a = 21850 | b = 30061 | cin = 1 | s = 51912 | cout = 0
# Time = 70 | a = 41065 | b = 8647 | cin = 0 | s = 49712 | cout = 0
# Time = 80 | a = 17538 | b = 60166 | cin = 1 | s = 12169 | cout = 1
# Time = 90 | a = 24534 | b = 11565 | cin = 1 | s = 36100 | cout = 0
# Time = 100 | a = 41838 | b = 15916 | cin = 0 | s = 57754 | cout = 0
# Time = 110 | a = 43632 | b = 3430 | cin = 1 | s = 47063 | cout = 0
# Time = 120 | a = 48520 | b = 170 | cin = 1 | s = 48691 | cout = 0
# Time = 130 | a = 28702 | b = 63722 | cin = 0 | s = 26888 | cout = 1
# Time = 140 | a = 20162 | b = 22599 | cin = 1 | s = 42762 | cout = 0
# Time = 150 | a = 43097 | b = 2308 | cin = 0 | s = 45405 | cout = 0
# Time = 160 | a = 39573 | b = 60711 | cin = 1 | s = 34749 | cout = 1
# Time = 170 | a = 37521 | b = 53940 | cin = 0 | s = 25925 | cout = 1
# Time = 180 | a = 38997 | b = 6454 | cin = 1 | s = 45452 | cout = 0
# Time = 190 | a = 30331 | b = 59562 | cin = 1 | s = 24358 | cout = 1
# ** Note: $finish    : pfa_tb.v(31)
#    Time: 400 ps  Iteration: 0  Instance: /pfa_tb
*/

