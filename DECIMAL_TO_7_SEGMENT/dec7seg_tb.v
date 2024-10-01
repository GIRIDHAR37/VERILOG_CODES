`timescale 1ns / 1ps
`include "dec7seg.v"

module dec7seg_tb;

  reg [3:0] dec;
  wire [6:0] seg;

  dec7seg dut(
    .dec(dec),
    .seg(seg)
  );

  initial begin
  	$monitor("dec : %0d seg : %b",dec,seg);
    	 dec = 4'd0;
    #100 dec = 4'd1;
    #100 dec = 4'd2;
    #100 dec = 4'd3;
    #100 dec = 4'd4;
    #100 dec = 4'd5;
    #100 dec = 4'd6;
    #100 dec = 4'd7;
    #100 dec = 4'd8;
	#100 dec = 4'd9;
	#100 dec = 4'd10;
    #1200 $finish();
  end
  
endmodule
