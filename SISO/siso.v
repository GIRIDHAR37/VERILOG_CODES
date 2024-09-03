module siso(input din,clk,rst,
			output reg q,qbar
		   );

	   reg [2:0]w;

	   always @(posedge clk) begin
	   		assign qbar=~q;
			if(rst) begin
				q<=1'b0;
			end
			else begin
				w[0]<=din;
				w[1]<=w[0];
				w[2]<=w[1];
				q<=w[2];
			end
		end

endmodule

// output :
/*
# TIME : 15 clk : 1 rst : 0 din : 0 q : 0 qbar : 1
# TIME : 20 clk : 0 rst : 0 din : 1 q : 0 qbar : 1
# TIME : 30 clk : 1 rst : 0 din : 1 q : x qbar : x
# TIME : 40 clk : 0 rst : 0 din : 0 q : x qbar : x
# TIME : 50 clk : 1 rst : 0 din : 0 q : x qbar : x
# TIME : 60 clk : 0 rst : 0 din : 1 q : x qbar : x
# TIME : 70 clk : 1 rst : 0 din : 1 q : x qbar : x
# TIME : 80 clk : 0 rst : 0 din : 0 q : x qbar : x
# TIME : 90 clk : 1 rst : 0 din : 0 q : 1 qbar : 0
# TIME : 100 clk : 0 rst : 0 din : 1 q : 1 qbar : 0
# TIME : 110 clk : 1 rst : 0 din : 1 q : 0 qbar : 1
# TIME : 120 clk : 0 rst : 0 din : 0 q : 0 qbar : 1
# TIME : 130 clk : 1 rst : 0 din : 0 q : 1 qbar : 0
# TIME : 140 clk : 0 rst : 0 din : 1 q : 1 qbar : 0
# TIME : 150 clk : 1 rst : 0 din : 1 q : 0 qbar : 1
# TIME : 160 clk : 0 rst : 0 din : 0 q : 0 qbar : 1
# TIME : 170 clk : 1 rst : 0 din : 0 q : 1 qbar : 0
# TIME : 180 clk : 0 rst : 0 din : 1 q : 1 qbar : 0
# TIME : 190 clk : 1 rst : 0 din : 1 q : 0 qbar : 1
# TIME : 200 clk : 0 rst : 0 din : 0 q : 0 qbar : 1
# TIME : 210 clk : 1 rst : 0 din : 0 q : 1 qbar : 0
# TIME : 220 clk : 0 rst : 0 din : 1 q : 1 qbar : 0
# TIME : 230 clk : 1 rst : 0 din : 1 q : 0 qbar : 1
# TIME : 240 clk : 0 rst : 0 din : 0 q : 0 qbar : 1
# TIME : 250 clk : 1 rst : 0 din : 0 q : 1 qbar : 0
# TIME : 260 clk : 0 rst : 0 din : 1 q : 1 qbar : 0
# TIME : 270 clk : 1 rst : 0 din : 1 q : 0 qbar : 1
# TIME : 280 clk : 0 rst : 0 din : 0 q : 0 qbar : 1
# TIME : 290 clk : 1 rst : 0 din : 0 q : 1 qbar : 0
# TIME : 300 clk : 0 rst : 0 din : 1 q : 1 qbar : 0
# TIME : 310 clk : 1 rst : 0 din : 1 q : 0 qbar : 1
# TIME : 320 clk : 0 rst : 0 din : 0 q : 0 qbar : 1
# TIME : 330 clk : 1 rst : 0 din : 0 q : 1 qbar : 0
# TIME : 340 clk : 0 rst : 0 din : 1 q : 1 qbar : 0
# TIME : 350 clk : 1 rst : 0 din : 1 q : 0 qbar : 1
# TIME : 360 clk : 0 rst : 0 din : 0 q : 0 qbar : 1
# TIME : 370 clk : 1 rst : 0 din : 0 q : 1 qbar : 0
# TIME : 380 clk : 0 rst : 0 din : 1 q : 1 qbar : 0
# TIME : 390 clk : 1 rst : 0 din : 1 q : 0 qbar : 1
# TIME : 400 clk : 0 rst : 0 din : 0 q : 0 qbar : 1
# TIME : 410 clk : 1 rst : 0 din : 0 q : 1 qbar : 0
# TIME : 420 clk : 0 rst : 0 din : 1 q : 1 qbar : 0
# TIME : 430 clk : 1 rst : 0 din : 1 q : 0 qbar : 1
# TIME : 440 clk : 0 rst : 0 din : 0 q : 0 qbar : 1
# TIME : 450 clk : 1 rst : 0 din : 0 q : 1 qbar : 0
# TIME : 460 clk : 0 rst : 0 din : 1 q : 1 qbar : 0
# TIME : 470 clk : 1 rst : 0 din : 1 q : 0 qbar : 1
# TIME : 480 clk : 0 rst : 0 din : 0 q : 0 qbar : 1
# TIME : 490 clk : 1 rst : 0 din : 0 q : 1 qbar : 0
# TIME : 500 clk : 0 rst : 0 din : 1 q : 1 qbar : 0
# TIME : 510 clk : 1 rst : 0 din : 1 q : 0 qbar : 1
# ** Note: $finish    : siso_tb.v(17)
#    Time: 515 ps  Iteration: 0  Instance: /siso_tb
*/

