`timescale 1ns / 1ps

module dec7seg(
  input [3:0] dec,
  output reg [6:0] seg
);

  always @(*) begin
    case (dec)   //  abcdefg
      4'd0: seg = 7'b1111110;
      4'd1: seg = 7'b0110000;
      4'd2: seg = 7'b1101101;
      4'd3: seg = 7'b1111001;
      4'd4: seg = 7'b0110011;
      4'd5: seg = 7'b1011011;
      4'd6: seg = 7'b1011111;
      4'd7: seg = 7'b1110000;
	  4'd8: seg = 7'b1111111;
	  4'd9: seg = 7'b1111011;
      default: seg = 7'b0000000;
    endcase
  end
endmodule

// output :
/*
# dec : 0 seg : 1111110
# dec : 1 seg : 0110000
# dec : 2 seg : 1101101
# dec : 3 seg : 1111001
# dec : 4 seg : 0110011
# dec : 5 seg : 1011011
# dec : 6 seg : 1011111
# dec : 7 seg : 1110000
# dec : 8 seg : 1111111
# dec : 9 seg : 1111011
# dec : 10 seg : 0000000
# ** Note: $finish    : dec7seg_tb.v(27)
#    Time: 2200 ns  Iteration: 0  Instance: /dec7seg_tb
*/
