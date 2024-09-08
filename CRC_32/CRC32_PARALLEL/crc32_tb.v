//`timescale 1ns / 1ps
`include "crc32.v"

module crc32_parallel_tb;
  reg clk, rst, load, d_finish;
  reg [7:0] data_in;
  wire [7:0] crc_out;
  integer i;

  // Instantiate the CRC32 parallel module
  crc32_parallel dut(
    .clk(clk),
    .rst(rst),
    .load(load),
    .d_finish(d_finish),
    .data_in(data_in),
    .crc_out(crc_out)
  );

  // Clock generation
  always #5 clk = ~clk; // Clock period is 10 time units (50MHz)

  // Stimulus
  initial begin
    // Initialize signals
    clk = 0;
    rst = 1;
    load = 0;
    d_finish = 0;
    data_in = 8'b0;
    
    // Reset the system
    #10 rst = 0;
    #10 rst = 1;
    #10 rst = 0;

    // Generate random inputs
    for (i = 0; i < 10; i = i + 1) begin
      #10 load = 1;
      data_in = $random;  // Generate a random 8-bit value for data_in
      #10 load = 0;
      // Display current state and CRC output
      $display("Time = %0t | data_in = %b | crc_out = %b", $time, data_in, crc_out);
    end

    // Signal the end of data input
    #100 d_finish = 1;
    #10 d_finish = 0;

    // Repeat process
    #1000 rst = 1;  // Reset the system
    #10 rst = 0;

    for (i = 0; i < 10; i = i + 1) begin
      #10 load = 1;
      data_in = $random;  // Generate new random 8-bit values for data_in
      #10 load = 0;
      // Display current state and CRC output
      $monitor("Time = %0t | data_in = %b | crc_out = %b | d_finish = %b", $time, data_in, crc_out, d_finish);
    end

    // Finish simulation
    #1000 $finish;
  end

endmodule

