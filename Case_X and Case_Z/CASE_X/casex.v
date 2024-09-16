module case_x(
  input  [1:0] data,
  output reg [3:0] out);
    
  always @(*) begin
    casex(data)
      2'b0z: out = 1;
      2'bz0: out = 2;
      2'b1z: out = 3;
      2'bxz: out = 4;
      
      2'b0x: out = 5;
      2'bx0: out = 6;
      2'b1x: out = 7;
      2'bx1: out = 8;

      default: $display("Invalid sel input");
    endcase
  end
endmodule
// output :
/*
# data = x1 -> out = 1
# data = 0x -> out = 1
# data = x0 -> out = 1
# data = z1 -> out = 1
# data = 0z -> out = 1
# data = z0 -> out = 1
# data = 1z -> out = 2
*/
