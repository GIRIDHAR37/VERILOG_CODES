module booths_multiplier(
  input signed [3:0] multiplicand, multiplier,
  output reg signed [7:0] product
  );

  reg [1:0] booth_state;
  integer bit_index;
  reg current_bit;
  reg [3:0] neg_multiplier;

  always @(multiplicand, multiplier)
  begin
    product = 8'd0;
    current_bit = 1'b0;
    neg_multiplier = -multiplier;
    
    for (bit_index = 0; bit_index < 4; bit_index = bit_index + 1)
    begin
      booth_state = { multiplicand[bit_index], current_bit };
      case(booth_state)
        2'd2 : product[7:4] = product[7:4] + neg_multiplier;
        2'd1 : product[7:4] = product[7:4] + multiplier;
      endcase
      product = product >> 1;
      product[7] = product[6];
      current_bit = multiplicand[bit_index];
    end
  end
  
endmodule

// output :
/*
# multiplicand =   3, multiplier =   1, product =    3
# multiplicand =  -6, multiplier =   7, product =  -42
# multiplicand =  -2, multiplier =  -5, product =   10
# multiplicand =  -5, multiplier =  -5, product =   25
# ** Note: $finish    : bm_tb.v(24)
#    Time: 40 ps  Iteration: 0  Instance: /bm_tb
*/

