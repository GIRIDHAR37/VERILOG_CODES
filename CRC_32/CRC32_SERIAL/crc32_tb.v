`include "crc32.v"

module crc32_serial_tb;

    reg clk;             // Clock signal
    reg rst;             // Reset signal (active low)
    reg load;            // Start encoding signal
    reg d_finish;        // Encoding end signal
    reg crc_in;          // Input data bit for encoding
    wire crc_out;        // Output encoded bit

    // Instantiate the CRC-32 module
    crc32_serial dut(
        .clk(clk), 
        .rst(rst), 
        .load(load), 
        .d_finish(d_finish), 
        .crc_in(crc_in), 
        .crc_out(crc_out)
    ); 

    initial begin
        // Initialize signals
        clk = 0;
        rst = 0; 
        load = 0; 
        d_finish = 0; 
        crc_in = 0;

        // Apply reset
        #10 rst = 1; 
        #10 rst = 0; 
        #10 rst = 1; 

        // Provide input data and start loading
        #10 crc_in = 1; // Enter the data to be encoded
        #10 load = 1;   // Load the data
        #10 load = 0;   // Stop loading
        #10 d_finish = 0; 

        // Simulate the encoding process for several clock cycles
        #800 d_finish = 1; // Signal encoding is complete
        #10 d_finish = 0;
    end

    // Clock signal generation: toggle every 5 ns
    always #(5) clk = ~clk;

    // Input data signal toggles every 20 ns for simulating a data stream
    always #(20) crc_in = ~crc_in;

	initial begin 
	 	$monitor("Time : %0t, clk : %0b, rst : %0b, load : %0b crc_in : %0b crc_out : %0b d_finish : %0b",$time,clk,rst,load,crc_in,crc_out,d_finish);
		#1000;
		$finish();
	end

endmodule

