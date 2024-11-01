// main module for 4-bit gray code counter -> gcc4b

module gcc4b(
	input clk,rst, 
	output [3:0]q,qbar
	);

	wire [3:0]d;
	wire [12:0]g;

	xnor(g[0],q[3],q[2]);
	not(g[1],g[0]);
	and(g[2],q[1],g[1]);
	and(g[3],qbar[1],g[0]);
	or(d[0],g[2],g[3]);
	dff d0(clk,rst,d[0],q[0],qbar[0]);

	xnor(g[4],q[3],q[2]);
	and(g[5],qbar[0],q[1]);
	and(g[6],g[4],q[0]);
	or(d[1],g[5],g[6]);
	dff d1(clk,rst,d[1],q[1],qbar[1]);
	
	and3b a0(qbar[3],q[1],qbar[0],g[7]);
	or(g[8],qbar[1],q[0]);
	and(g[9],q[2],g[8]);
	or(d[2],g[7],g[9]);
	dff d2(clk,rst,d[2],q[2],qbar[2]);

	and3b a1(q[2],qbar[1],qbar[0],g[10]);
	or(g[11],q[0],q[1]);
	and(g[12],q[3],g[11]);
	or(d[3],g[10],g[12]);
	dff d3(clk,rst,d[3],q[3],qbar[3]);

endmodule

// submodule of d-flipflop required for main module of 4-bit gray code counter

module dff(input clk,rst,d,
		   output reg q,qbar
		  );

		always @(posedge clk) begin
			if(rst) begin
				q<=1'b0;
				qbar<=1'b1;
			end
			else begin
				q<=d;
				qbar<=~d;
			end
		end

endmodule

// submodule for 3-input and gate for main module of 4-bit graycode counter 

module and3b(input a,b,c,
		     output y
			);

	  assign y=a&b&c;

endmodule
