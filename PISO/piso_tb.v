`include "piso.v"

module piso_tb;
	reg [3:0]din;
	reg clk,rst,shift_mode;
	wire qout,qbarout;

	piso dut(.din(din),.clk(clk),.rst(rst),.shift_mode(shift_mode),.qout(qout),.qbarout(qbarout));

	initial begin
		clk=0;
		rst=1;
		#10 rst=0;
		$monitor("TIME : %0t din : %0b clk =%0b rst : %0b shift_mode : %0b qout : %0b qbarout : %0b",$time,din,clk,rst,shift_mode,qout,qbarout);
		#1000;
		$finish();
	end

	initial begin
		shift_mode=1'b0;
		#500 shift_mode=~shift_mode;
	end

	always #5 clk = ~clk;

	always begin
		din=$random;
		#20;
	end

endmodule
