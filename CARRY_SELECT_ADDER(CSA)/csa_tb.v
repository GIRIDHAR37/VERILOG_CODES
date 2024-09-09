`include "csa.v"  // Include the CSA module

module csa_tb;
  // Inputs to the DUT (Design Under Test)
  reg [3:0] a, b;
  reg cin;

  // Outputs from the DUT
  wire [3:0] s;
  wire cout;

  // Instantiate the DUT (CSA module)
  csa dut (
    .A(a),
    .B(b),
    .Cin(cin),
    .S(s),
    .Cout(cout)
  );

  // Testbench Procedure
  initial begin 
    // Initialize monitor to continuously observe changes
    $monitor("Time = %0t | a = %b | b = %b | cin = %b | s = %b | cout = %b", 
              $time, a, b, cin, s, cout);

    // Run random test cases
    repeat(20) begin
      {a, b, cin} = $random;  // Randomize inputs
      #10;                    // Add delay to let values propagate
    end

    // End simulation after tests
    #200; 
    $finish();
  end
  
endmodule

