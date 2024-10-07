module m4b(input [3:0]a,b,
		   output [7:0]s
		  );

	   wire [27:0]g;

//     for s[0] bit
	   and(s[0],a[0],b[0]);
//     for s[1] bit
	   and(g[0],a[1],b[0]);
	   and(g[1],a[0],b[1]);
	   ha ha0(g[0],g[1],s[1],g[2]);
//     for s[2] bit
	   and(g[3],a[2],b[0]);
	   and(g[4],a[1],b[1]);
	   and(g[5],a[0],b[2]);
	   fa fa0(g[2],g[3],g[4],g[6],g[7]);
	   fa fa1(g[6],g[7],g[5],s[2],g[8]);
//     for s[3] bit
	   and(g[9],a[3],b[0]);
	   and(g[10],a[2],b[1]);
	   and(g[11],a[1],b[2]);
	   and(g[12],a[0],b[3]);
	   fa fa2(g[8],g[9],g[10],g[13],g[14]);
	   fa fa3(g[11],g[13],g[14],g[15],g[16]);
	   fa fa4(g[12],g[15],g[16],s[3],g[17]);
//     for s[4] bit
	   and(g[18],a[3],b[1]);
	   and(g[19],a[2],b[2]);
	   and(g[20],a[1],b[3]);
	   fa fa5(g[17],g[18],g[19],g[21],g[22]);
	   fa fa6(g[20],g[21],g[22],s[4],g[23]);
//     for s[5] bit
	   and(g[24],a[3],b[2]);
	   and(g[25],a[2],b[3]);
	   fa fa7(g[23],g[24],g[25],s[5],g[26]);
//     for s[6] and s[7] bits
	   and(g[27],a[3],b[3]);
	   ha ha1(g[26],g[27],s[6],s[7]);
	
endmodule

// sub module for 1-bit full adder

module fa(input a,b,c_in,
		  output s,c_out
		 );

	   assign s=a^b^c_in;
	   assign c_out=(a&b)|(b&c_in)|(c_in&a);

endmodule

// submodule for 1-bit half adder

module ha(input a,b,
		  output s,c
		 );

	   assign s=a^b;
	   assign c=a&b;

endmodule

// output :
/*
# a : 1000 * b : 0110 = s : 00110000
# a : 0110 * b : 0110 = s : 00011100
# a : 0010 * b : 1110 = s : 00011100
# a : 1010 * b : 1010 = s : 01100100
# a : 1111 * b : 0110 = s : 00111010
# a : 0100 * b : 1110 = s : 00111000
# a : 1011 * b : 0101 = s : 00101111
# a : 0000 * b : 0101 = s : 00000000
# a : 0101 * b : 1001 = s : 00101101
# a : 1010 * b : 1000 = s : 01010000
# ** Note: $finish    : m4b_tb.v(20)
#    Time: 80 ps  Iteration: 0  Instance: /m4b_tb
*/
