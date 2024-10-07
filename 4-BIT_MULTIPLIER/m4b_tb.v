`include "m4b.v"

module m4b_tb;

	reg [3:0]a,b;
	wire [7:0]s;
	
	m4b dut(.a(a),.b(b),.s(s));

	initial begin
		repeat(10) begin
			a=$urandom_range(0,15);
			b=$urandom_range(0,15);
			$monitor("a : %b * b : %b = s : %b",a,b,s);
			#1;
		end
	end

	initial begin
		#80 $finish();
	end
	
endmodule
