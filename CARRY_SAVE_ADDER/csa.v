module csa(input [3:0]a,b,
		   input [3:0]c_in,
		   output [4:0]s,
		   output c_out
		  );

	wire [9:0]m;

// first stage adders :

	fa fa0(a[0],b[0],c_in[0],s[0],m[0]);
	fa fa1(a[1],b[1],c_in[1],m[1],m[2]);
	fa fa2(a[2],b[2],c_in[2],m[3],m[4]);
	fa fa3(a[3],b[3],c_in[3],m[5],m[6]);

// second stage adders :
	
	ha ha0(m[0],m[1],s[1],m[7]);
	fa fa4(m[2],m[3],m[7],s[2],m[8]);
	fa fa5(m[4],m[5],m[8],s[3],m[9]);
	ha ha1(m[6],m[9],s[4],c_out);

endmodule

// sub module for full adder 

module fa(input a,b,c_in,
		  output s,c_out
		 );

	assign s=a^b^c_in;
	assign c_out=((a&b)|(b&c_in)|(c_in&a));
endmodule

// sub module for half adder
module ha(input a,b,
		  output s,c
		   );

	assign s=a^b;
	assign c=a&b;

endmodule

// output :
/*

*/
