module piso(input [3:0]din,
		    input clk,rst,shift_mode,
			output qout,qbarout
		   );
	   wire [2:0]q,qbar;
	   wire shift_mode_not;
	   wire [5:0]a;
	   wire [2:0]g;

	   not(shift_mode_not,shift_mode);

	   dff d0(din[0],clk,rst,q[0],qbar[0]);
	   and(a[0],shift_mode,q[0]);
	   and(a[1],shift_mode_not,din[1]);
	   or(g[0],a[0],a[2]);

	   dff d1(g[0],clk,rst,q[1],qbar[1]);
	   and(a[2],shift_mode,q[1]);
	   and(a[3],shift_mode_not,din[2]);
	   or(g[1],a[2],a[3]);

	   dff d2(g[1],clk,rst,q[2],qbar[2]);
	   and(a[4],shift_mode,q[2]);
	   and(a[5],shift_mode_not,din[3]);
	   or(g[2],a[4],a[5]);

	   dff d3(g[2],clk,rst,qout,qbarout);

endmodule

// submodule for D flipflop

module dff(input d,clk,rst,
		   output reg q,qbar
		  );

	   always @(posedge clk) begin

	   		if(rst) begin
				q<=1'b0;
				qbar<=1'b1;
			end
			else begin
			q<=d;
			qbar<=~q;
			end
	   end

endmodule

