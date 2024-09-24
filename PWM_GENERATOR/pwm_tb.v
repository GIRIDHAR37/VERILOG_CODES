`include "pwm.v"

module pwm_tb;
	
	localparam R = 8,T = 10;
	
	reg clk,rst_n;
	reg [R-1:0]duty;
	wire pwm_out;

	pwm #(.R(R)) dut(.clk(clk),
					 .rst_n(rst_n),
					 .duty(duty),
					 .pwm_out(pwm_out)
					);

	initial 
		#(7*2**R*T) $stop;

	always begin
		clk=1'b0;
		#(T/2);
		clk=1'b1;
		#(T/2);
	end

	initial begin
		rst_n = 1'b0;
		#2;
		rst_n = 1'b1;
		duty = 0.25 * (2**R);

		repeat(2*2**R) @(negedge clk);
		duty = 0.50 * (2**R);

		repeat(2*2**R) @(negedge clk);
		duty = 0.75 * (2**R);
	
	end

	initial begin
    	$monitor("Time: %0t, clk: %b, rst_n: %b, duty: %0d, pwm_out: %b", $time, clk, rst_n, duty, pwm_out);
	end
	  
endmodule
