`include "pipo.v"

module pipo_tb;
	reg [3:0]din;
	reg clk,rst;
	wire [3:0]q,qbar;

	pipo dut(.din(din),.clk(clk),.rst(rst),.q(q),.qbar(qbar));

	initial begin
		clk=0;
		rst=1;
		#15;
		rst=0;
		din=0;
		$monitor("TIME : %0t clk : %0b rst : %0b din : %0b q : %0b qbar : %0b",$time,clk,rst,din,q,qbar);
		#500;
		$finish();
	end

	always #10 clk=~clk;
	always #20 din=$random;
	
endmodule	
