`include "pc1.v"

module pc1_tb;
	
	reg a,b,c,d;
	wire y;

	pc1 dut(.a(a),.b(b),.c(c),.d(d),.y(y));

	initial begin
		repeat(20) begin
			{a,b,c,d}=$urandom_range(0,15);
			$monitor("a : %0b, b : %0b, c : %0b, d : %0b, y : %0b",a,b,c,d,y);
			#1;
		end
		#55;
		$finish();
	end

endmodule
