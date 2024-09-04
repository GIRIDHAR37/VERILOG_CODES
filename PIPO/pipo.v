module pipo(input [3:0]din,
			input clk,rst,
			output reg [3:0]q,qbar
		   );

	   always @(posedge clk) begin
			if(rst) begin
				q<=1'b0;
				qbar<=1'b1;
			end
			else begin
				q<=din;
				qbar<= ~q;
			end
		end

endmodule

// output :
/*
*/

