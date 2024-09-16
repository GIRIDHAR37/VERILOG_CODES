`include "casez.v"  // Include the CSA module

module case_z_tb;
  reg [1:0] data;
  wire [3:0] out;
  
  case_z dut(.data(data),.out(out));
  
  initial begin
    $monitor("data = %b -> out = %0h", data, out);
       data = 2'bx1;
    #1 data = 2'b0x;
    #1 data = 2'bx0;
    #1 data = 2'b1x;
    
       data = 2'bz1;
    #1 data = 2'b0z;
    #1 data = 2'bz0;
    #1 data = 2'b1z;
  end
endmodule

