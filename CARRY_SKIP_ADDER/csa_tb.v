`include "csa.v"  // Include the CSA module

module csa_tb;
  // Inputs to the DUT (Design Under Test)
  reg [3:0] a, b;
  reg c_in;

  // Outputs from the DUT
  wire [3:0] s;
  wire c_out;

  // Instantiate the DUT (CSA module)
  csa dut (
    .a(a),
    .b(b),
    .c_in(c_in),
    .s(s),
    .c_out(c_out)
  );

  // Testbench Procedure
  initial begin 
    // Initialize monitor to continuously observe changes
    $monitor("Time = %0t | a = %b | b = %b | cin = %b | s = %b | cout = %b", 
              $time, a, b, c_in, s, c_out);

    // Run random test cases
    repeat(20) begin
      {a, b, c_in} = $random;  // Randomize inputs
      #10;                    // Add delay to let values propagate
    end

    // End simulation after tests
    #200; 
    $finish();
  end
  
endmodule

