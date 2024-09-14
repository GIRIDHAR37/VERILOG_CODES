`timescale 1ns / 1ps
`include "bsr.v"

module bsr_tb;
	reg ri,li;
	reg clk,rst,rl_mode;
	wire [3:0]q,qbar;

	bsr dut(.ri(ri),.li(li),.clk(clk),.rst(rst),.rl_mode(rl_mode),.q(q),.qbar(qbar));

	initial begin
		clk=0;
		rst=1;
		#10 rst=0;
		$monitor("TIME : %0t ri : %0b li : %0b clk =%0b rst : %0b rl_mode : %0b q : %b qbar : %b",$time,ri,li,clk,rst,rl_mode,q,qbar);
		#500;
		$finish();
	end

	initial begin
		rl_mode=1'b0;
		#250 rl_mode=~rl_mode;
	end

	always #5 clk = ~clk;

	always #10 ri=$random;
	always #10 li=$random;

endmodule
