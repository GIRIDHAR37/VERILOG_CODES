`include "pfa.v"

module pfa_tb;
	parameter SIZE=16;

	reg [SIZE-1:0]a,b;
	reg c_in;

	wire [SIZE-1:0]s;
	wire c_out;

	pfa #(SIZE) dut(.a(a),
		           .b(b),
				   .c_in(c_in),
				   .s(s),
				   .c_out(c_out) 
				   );

	initial begin

    	$monitor("Time = %0t | a = %0d | b = %0d | cin = %b | s = %0d | cout = %b", $time, a, b, c_in, s, c_out);

    	repeat(20) begin
			a = $urandom_range(10000,50000);
      		b = $urandom_range(50000,100000); 
			c_in   = $random;
	  		#10;                    
		end

    	#200; 
    	$finish();

  end
  
endmodule
