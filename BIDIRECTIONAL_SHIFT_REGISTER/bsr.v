module bsr(input ri,li,
		    input clk,rst,rl_mode,
			output [3:0]q,qbar
		   );

	   wire rl_mode_not;
	   wire [7:0]a;
	   wire [3:0]g;

	   not(rl_mode_not,rl_mode);

	   and(a[0],rl_mode,li);
	   and(a[1],rl_mode_not,q[1]);
	   or(g[0],a[0],a[1]);
	   dff d0(g[0],clk,rst,q[0],qbar[0]);

	   and(a[2],rl_mode,q[0]);
	   and(a[3],rl_mode_not,q[2]);
	   or(g[1],a[2],a[3]);
	   dff d1(g[1],clk,rst,q[1],qbar[1]);

	   and(a[4],rl_mode,q[1]);
	   and(a[5],rl_mode_not,q[3]);
	   or(g[2],a[4],a[5]);
	   dff d2(g[2],clk,rst,q[2],qbar[2]);

	   and(a[6],rl_mode,q[2]);
	   and(a[7],rl_mode_not,ri);
	   or(g[3],a[6],a[7]);
	   dff d3(g[3],clk,rst,q[3],qbar[3]);

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

// output :
/*
 TIME : 10000 ri : 0 li : 1 clk =0 rst : 0 rl_mode : 0 q : 0000 qbar : 1111
# TIME : 15000 ri : 0 li : 1 clk =1 rst : 0 rl_mode : 0 q : 0000 qbar : 1111
# TIME : 20000 ri : 1 li : 1 clk =0 rst : 0 rl_mode : 0 q : 0000 qbar : 1111
# TIME : 25000 ri : 1 li : 1 clk =1 rst : 0 rl_mode : 0 q : 1000 qbar : 1111
# TIME : 30000 ri : 1 li : 1 clk =0 rst : 0 rl_mode : 0 q : 1000 qbar : 1111
# TIME : 35000 ri : 1 li : 1 clk =1 rst : 0 rl_mode : 0 q : 1100 qbar : 0111
# TIME : 40000 ri : 1 li : 0 clk =0 rst : 0 rl_mode : 0 q : 1100 qbar : 0111
# TIME : 45000 ri : 1 li : 0 clk =1 rst : 0 rl_mode : 0 q : 1110 qbar : 0011
# TIME : 50000 ri : 1 li : 1 clk =0 rst : 0 rl_mode : 0 q : 1110 qbar : 0011
# TIME : 55000 ri : 1 li : 1 clk =1 rst : 0 rl_mode : 0 q : 1111 qbar : 0001
# TIME : 60000 ri : 0 li : 1 clk =0 rst : 0 rl_mode : 0 q : 1111 qbar : 0001
# TIME : 65000 ri : 0 li : 1 clk =1 rst : 0 rl_mode : 0 q : 0111 qbar : 0000
# TIME : 70000 ri : 1 li : 0 clk =0 rst : 0 rl_mode : 0 q : 0111 qbar : 0000
# TIME : 75000 ri : 1 li : 0 clk =1 rst : 0 rl_mode : 0 q : 1011 qbar : 1000
# TIME : 80000 ri : 1 li : 0 clk =0 rst : 0 rl_mode : 0 q : 1011 qbar : 1000
# TIME : 85000 ri : 1 li : 0 clk =1 rst : 0 rl_mode : 0 q : 1101 qbar : 0100
# TIME : 90000 ri : 1 li : 0 clk =0 rst : 0 rl_mode : 0 q : 1101 qbar : 0100
# TIME : 95000 ri : 1 li : 0 clk =1 rst : 0 rl_mode : 0 q : 1110 qbar : 0010
# TIME : 100000 ri : 1 li : 1 clk =0 rst : 0 rl_mode : 0 q : 1110 qbar : 0010
# TIME : 105000 ri : 1 li : 1 clk =1 rst : 0 rl_mode : 0 q : 1111 qbar : 0001
# TIME : 110000 ri : 0 li : 1 clk =0 rst : 0 rl_mode : 0 q : 1111 qbar : 0001
# TIME : 115000 ri : 0 li : 1 clk =1 rst : 0 rl_mode : 0 q : 0111 qbar : 0000
# TIME : 120000 ri : 0 li : 0 clk =0 rst : 0 rl_mode : 0 q : 0111 qbar : 0000
# TIME : 125000 ri : 0 li : 0 clk =1 rst : 0 rl_mode : 0 q : 0011 qbar : 1000
# TIME : 130000 ri : 0 li : 1 clk =0 rst : 0 rl_mode : 0 q : 0011 qbar : 1000
# TIME : 135000 ri : 0 li : 1 clk =1 rst : 0 rl_mode : 0 q : 0001 qbar : 1100
# TIME : 140000 ri : 0 li : 1 clk =0 rst : 0 rl_mode : 0 q : 0001 qbar : 1100
# TIME : 145000 ri : 0 li : 1 clk =1 rst : 0 rl_mode : 0 q : 0000 qbar : 1110
# TIME : 150000 ri : 1 li : 1 clk =0 rst : 0 rl_mode : 0 q : 0000 qbar : 1110
# TIME : 155000 ri : 1 li : 1 clk =1 rst : 0 rl_mode : 0 q : 1000 qbar : 1111
# TIME : 160000 ri : 1 li : 0 clk =0 rst : 0 rl_mode : 0 q : 1000 qbar : 1111
# TIME : 165000 ri : 1 li : 0 clk =1 rst : 0 rl_mode : 0 q : 1100 qbar : 0111
# TIME : 170000 ri : 0 li : 0 clk =0 rst : 0 rl_mode : 0 q : 1100 qbar : 0111
# TIME : 175000 ri : 0 li : 0 clk =1 rst : 0 rl_mode : 0 q : 0110 qbar : 0011
# TIME : 180000 ri : 0 li : 1 clk =0 rst : 0 rl_mode : 0 q : 0110 qbar : 0011
# TIME : 185000 ri : 0 li : 1 clk =1 rst : 0 rl_mode : 0 q : 0011 qbar : 1001
# TIME : 190000 ri : 0 li : 1 clk =0 rst : 0 rl_mode : 0 q : 0011 qbar : 1001
# TIME : 195000 ri : 0 li : 1 clk =1 rst : 0 rl_mode : 0 q : 0001 qbar : 1100
# TIME : 200000 ri : 1 li : 1 clk =0 rst : 0 rl_mode : 0 q : 0001 qbar : 1100
# TIME : 205000 ri : 1 li : 1 clk =1 rst : 0 rl_mode : 0 q : 1000 qbar : 1110
# TIME : 210000 ri : 1 li : 1 clk =0 rst : 0 rl_mode : 0 q : 1000 qbar : 1110
# TIME : 215000 ri : 1 li : 1 clk =1 rst : 0 rl_mode : 0 q : 1100 qbar : 0111
# TIME : 220000 ri : 0 li : 0 clk =0 rst : 0 rl_mode : 0 q : 1100 qbar : 0111
# TIME : 225000 ri : 0 li : 0 clk =1 rst : 0 rl_mode : 0 q : 0110 qbar : 0011
# TIME : 230000 ri : 1 li : 1 clk =0 rst : 0 rl_mode : 0 q : 0110 qbar : 0011
# TIME : 235000 ri : 1 li : 1 clk =1 rst : 0 rl_mode : 0 q : 1011 qbar : 1001
# TIME : 240000 ri : 1 li : 0 clk =0 rst : 0 rl_mode : 0 q : 1011 qbar : 1001
# TIME : 245000 ri : 1 li : 0 clk =1 rst : 0 rl_mode : 0 q : 1101 qbar : 0100
# TIME : 250000 ri : 0 li : 0 clk =0 rst : 0 rl_mode : 1 q : 1101 qbar : 0100
# TIME : 255000 ri : 0 li : 0 clk =1 rst : 0 rl_mode : 1 q : 1010 qbar : 0010
# TIME : 260000 ri : 0 li : 0 clk =0 rst : 0 rl_mode : 1 q : 1010 qbar : 0010
# TIME : 265000 ri : 0 li : 0 clk =1 rst : 0 rl_mode : 1 q : 0100 qbar : 0101
# TIME : 270000 ri : 1 li : 0 clk =0 rst : 0 rl_mode : 1 q : 0100 qbar : 0101
# TIME : 275000 ri : 1 li : 0 clk =1 rst : 0 rl_mode : 1 q : 1000 qbar : 1011
# TIME : 280000 ri : 0 li : 1 clk =0 rst : 0 rl_mode : 1 q : 1000 qbar : 1011
# TIME : 285000 ri : 0 li : 1 clk =1 rst : 0 rl_mode : 1 q : 0001 qbar : 0111
# TIME : 290000 ri : 1 li : 0 clk =0 rst : 0 rl_mode : 1 q : 0001 qbar : 0111
# TIME : 295000 ri : 1 li : 0 clk =1 rst : 0 rl_mode : 1 q : 0010 qbar : 1110
# TIME : 300000 ri : 0 li : 0 clk =0 rst : 0 rl_mode : 1 q : 0010 qbar : 1110
# TIME : 305000 ri : 0 li : 0 clk =1 rst : 0 rl_mode : 1 q : 0100 qbar : 1101
# TIME : 310000 ri : 0 li : 0 clk =0 rst : 0 rl_mode : 1 q : 0100 qbar : 1101
# TIME : 315000 ri : 0 li : 0 clk =1 rst : 0 rl_mode : 1 q : 1000 qbar : 1011
# TIME : 320000 ri : 1 li : 1 clk =0 rst : 0 rl_mode : 1 q : 1000 qbar : 1011
# TIME : 325000 ri : 1 li : 1 clk =1 rst : 0 rl_mode : 1 q : 0001 qbar : 0111
# TIME : 330000 ri : 1 li : 1 clk =0 rst : 0 rl_mode : 1 q : 0001 qbar : 0111
# TIME : 335000 ri : 1 li : 1 clk =1 rst : 0 rl_mode : 1 q : 0011 qbar : 1110
# TIME : 340000 ri : 1 li : 0 clk =0 rst : 0 rl_mode : 1 q : 0011 qbar : 1110
# TIME : 345000 ri : 1 li : 0 clk =1 rst : 0 rl_mode : 1 q : 0110 qbar : 1100
# TIME : 350000 ri : 0 li : 1 clk =0 rst : 0 rl_mode : 1 q : 0110 qbar : 1100
# TIME : 355000 ri : 0 li : 1 clk =1 rst : 0 rl_mode : 1 q : 1101 qbar : 1001
# TIME : 360000 ri : 1 li : 1 clk =0 rst : 0 rl_mode : 1 q : 1101 qbar : 1001
# TIME : 365000 ri : 1 li : 1 clk =1 rst : 0 rl_mode : 1 q : 1011 qbar : 0010
# TIME : 370000 ri : 0 li : 0 clk =0 rst : 0 rl_mode : 1 q : 1011 qbar : 0010
# TIME : 375000 ri : 0 li : 0 clk =1 rst : 0 rl_mode : 1 q : 0110 qbar : 0100
# TIME : 380000 ri : 1 li : 1 clk =0 rst : 0 rl_mode : 1 q : 0110 qbar : 0100
# TIME : 385000 ri : 1 li : 1 clk =1 rst : 0 rl_mode : 1 q : 1101 qbar : 1001
# TIME : 390000 ri : 0 li : 1 clk =0 rst : 0 rl_mode : 1 q : 1101 qbar : 1001
# TIME : 395000 ri : 0 li : 1 clk =1 rst : 0 rl_mode : 1 q : 1011 qbar : 0010
# TIME : 400000 ri : 1 li : 0 clk =0 rst : 0 rl_mode : 1 q : 1011 qbar : 0010
# TIME : 405000 ri : 1 li : 0 clk =1 rst : 0 rl_mode : 1 q : 0110 qbar : 0100
# TIME : 410000 ri : 1 li : 1 clk =0 rst : 0 rl_mode : 1 q : 0110 qbar : 0100
# TIME : 415000 ri : 1 li : 1 clk =1 rst : 0 rl_mode : 1 q : 1101 qbar : 1001
# TIME : 420000 ri : 1 li : 0 clk =0 rst : 0 rl_mode : 1 q : 1101 qbar : 1001
# TIME : 425000 ri : 1 li : 0 clk =1 rst : 0 rl_mode : 1 q : 1010 qbar : 0010
# TIME : 430000 ri : 1 li : 1 clk =0 rst : 0 rl_mode : 1 q : 1010 qbar : 0010
# TIME : 435000 ri : 1 li : 1 clk =1 rst : 0 rl_mode : 1 q : 0101 qbar : 0101
# TIME : 440000 ri : 0 li : 0 clk =0 rst : 0 rl_mode : 1 q : 0101 qbar : 0101
# TIME : 445000 ri : 0 li : 0 clk =1 rst : 0 rl_mode : 1 q : 1010 qbar : 1010
# TIME : 450000 ri : 0 li : 0 clk =0 rst : 0 rl_mode : 1 q : 1010 qbar : 1010
# TIME : 455000 ri : 0 li : 0 clk =1 rst : 0 rl_mode : 1 q : 0100 qbar : 0101
# TIME : 460000 ri : 1 li : 1 clk =0 rst : 0 rl_mode : 1 q : 0100 qbar : 0101
# TIME : 465000 ri : 1 li : 1 clk =1 rst : 0 rl_mode : 1 q : 1001 qbar : 1011
# TIME : 470000 ri : 0 li : 0 clk =0 rst : 0 rl_mode : 1 q : 1001 qbar : 1011
# TIME : 475000 ri : 0 li : 0 clk =1 rst : 0 rl_mode : 1 q : 0010 qbar : 0110
# TIME : 480000 ri : 1 li : 1 clk =0 rst : 0 rl_mode : 1 q : 0010 qbar : 0110
# TIME : 485000 ri : 1 li : 1 clk =1 rst : 0 rl_mode : 1 q : 0101 qbar : 1101
# TIME : 490000 ri : 1 li : 1 clk =0 rst : 0 rl_mode : 1 q : 0101 qbar : 1101
# TIME : 495000 ri : 1 li : 1 clk =1 rst : 0 rl_mode : 1 q : 1011 qbar : 1010
# TIME : 500000 ri : 1 li : 0 clk =0 rst : 0 rl_mode : 1 q : 1011 qbar : 1010
# TIME : 505000 ri : 1 li : 0 clk =1 rst : 0 rl_mode : 1 q : 0110 qbar : 0100
# ** Note: $finish    : bsr_tb.v(17)
#    Time: 510 ns  Iteration: 0  Instance: /bsr_tb
# 1
# Break in Module bsr_tb at bsr_tb.v line 17
*/
