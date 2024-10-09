`include "bm.v"

module bm_tb;
  reg signed [3:0] multiplicand;
  reg signed [3:0] multiplier;
  wire signed [7:0] product;
  
  booths_multiplier dut (multiplicand, multiplier, product);

  initial begin
    $monitor("multiplicand = %d, multiplier = %d, product = %d", multiplicand, multiplier, product);
    multiplicand = 4'd0011; // 3
    multiplier = 4'b0001;   // 1
    #10;
    multiplicand = 4'b1010; // -6
    multiplier = 4'b0111;   //  7
    #10;
    multiplicand = 4'b1110; // -2
    multiplier = 4'b1011;   // -5
    #10;
    multiplicand = 4'b1011; // -5
    multiplier = 4'b1011;   // -5
    #10;
    $finish();
  end
endmodule
