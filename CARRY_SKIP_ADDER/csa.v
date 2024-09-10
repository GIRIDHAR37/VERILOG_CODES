module csa(input [3:0]a,b,
		   input c_in,
		   output [3:0]s,
		   output c_out
		  );

	wire [3:0]p,c;
	wire by_pass;

	fa fa0(a[0],b[0],c_in,s[0],c[0]);
	fa fa1(a[1],b[1],c[0],s[1],c[1]);
	fa fa2(a[2],b[2],c[1],s[2],c[2]);
	fa fa3(a[3],b[3],c[2],s[3],c[3]);

//	assign p=a^b;

	assign p[0]=a[0]^b[0];
	assign p[1]=a[1]^b[1];
	assign p[2]=a[2]^b[2];
	assign p[3]=a[3]^b[3];

	and4 a0(p[0],p[1],p[2],p[3],by_pass);

	assign c_out = by_pass ? c[3] : c_in;

endmodule

// sub module for full adder 

module fa(input a,b,c_in,
		  output s,c_out
		 );

	assign s=a^b^c_in;
	assign c_out=((a&b)|(b&c_in)|(c_in&a));
endmodule

// sub module for 4 input and gate

module and4(input a,b,c,d,
		   	output y
		   );

	assign y=a&b&c&d;

endmodule

// output :
/*
# Time = 0 | a = 1001 | b = 0010 | cin = 0 | s = 1011 | cout = 0
# Time = 10 | a = 0100 | b = 0000 | cin = 1 | s = 0101 | cout = 1
# Time = 20 | a = 0000 | b = 0100 | cin = 1 | s = 0101 | cout = 1
# Time = 30 | a = 0011 | b = 0001 | cin = 1 | s = 0101 | cout = 1
# Time = 40 | a = 1000 | b = 0110 | cin = 1 | s = 1111 | cout = 1
# Time = 50 | a = 1100 | b = 0110 | cin = 1 | s = 0011 | cout = 1
# Time = 60 | a = 0011 | b = 0010 | cin = 1 | s = 0110 | cout = 1
# Time = 70 | a = 0000 | b = 1001 | cin = 0 | s = 1001 | cout = 0
# Time = 80 | a = 1000 | b = 0000 | cin = 1 | s = 1001 | cout = 1
# Time = 90 | a = 1000 | b = 0110 | cin = 1 | s = 1111 | cout = 1
# Time = 100 | a = 1011 | b = 1011 | cin = 0 | s = 0110 | cout = 0
# Time = 110 | a = 1001 | b = 1110 | cin = 1 | s = 1000 | cout = 1
# Time = 120 | a = 1111 | b = 0110 | cin = 1 | s = 0110 | cout = 1
# Time = 130 | a = 1100 | b = 0110 | cin = 0 | s = 0010 | cout = 0
# Time = 140 | a = 1111 | b = 1100 | cin = 1 | s = 1100 | cout = 1
# Time = 150 | a = 0110 | b = 0011 | cin = 0 | s = 1001 | cout = 0
# Time = 160 | a = 0110 | b = 0010 | cin = 1 | s = 1001 | cout = 1
# Time = 170 | a = 0101 | b = 0101 | cin = 0 | s = 1010 | cout = 0
# Time = 180 | a = 1111 | b = 0010 | cin = 1 | s = 0010 | cout = 1
# Time = 190 | a = 0011 | b = 1011 | cin = 1 | s = 1111 | cout = 1
# ** Note: $finish    : csa_tb.v(35)
#    Time: 400 ps  Iteration: 0  Instance: /csa_tb
*/
