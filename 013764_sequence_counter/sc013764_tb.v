`timescale 1ns / 1ps
`include "sc013764.v"

module sc_tb;

    // Testbench signals
    reg clk,rst;
    wire [2:0] q; 
	wire count;

    // Instantiate the sc module
    sc dut (
        .clk(clk),
        .rst(rst),
        .q(q),
		.count(count)
    );

    // Clock generation (50% duty cycle)
    initial begin	    
//	    d=3'b100;
        clk = 0;
        forever #5 clk = ~clk;  // Toggle clock every 5 time units
    end

    // Test procedure
    initial begin
        // Initialize signals
        rst = 1;  // Apply reset
        #10;
		rst = 0;  // Release reset after 10 time units
        // Observe the outputs after reset is de-asserted
        #250;
        // End simulation
        $finish;
    end

    // Monitor the output signals during simulation
    initial begin
        $monitor("Time: %0d | q: %b | count: %b", $time, q, count);
    end

endmodule

