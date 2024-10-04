// main module for universal shift register : 

module usr(input clk,clear,
		   input [1:0]s,
		   input sisr,sisl,
		   input [3:0]pin,
		   output [3:0]q
		  );

	   wire [3:0]d;
		
	   m41 m0({q[0],q[1],sisl,pin[0]},s,d[0]);
	   dff d0(clk,clear,d[0],q[0]);
	   m41 m1({q[1],q[2],q[0],pin[1]},s,d[1]);
	   dff d1(clk,clear,d[1],q[1]);
	   m41 m2({q[2],q[3],q[1],pin[2]},s,d[2]);
	   dff d2(clk,clear,d[2],q[2]);
	   m41 m3({q[3],sisr,q[2],pin[3]},s,d[3]);
	   dff d3(clk,clear,d[3],q[3]);

	
endmodule

// sub module for 4x1 mux :

module m41(input [3:0]i,
		   input [1:0]s,
		   output reg y
		  );

	   always @(*) begin 
	   		case(s)
				2'b00 : y <= i[0];
				2'b01 : y <= i[1];
				2'b10 : y <= i[2];
				2'b11 : y <= i[3];
				default : y <= 'bx;
			endcase
		end

endmodule

// sub module for d flip flop :

module dff(input clk,clear,d,
		   output reg q
		  );

	   always @(posedge clk) begin
	   		if(clear)
				q<=1'b0;
			else
				q<=d;
	   end

endmodule

// output :
/*
# Time : 0 clk : 0 clear : 0 s : 00 sisr : 1 sisl : 0 pin : xxxx q : xxxx
# Time : 20 clk : 1 clear : 0 s : 00 sisr : 1 sisl : 0 pin : xxxx q : xxxx
# Time : 40 clk : 0 clear : 0 s : 00 sisr : 1 sisl : 0 pin : xxxx q : xxxx
# Time : 50 clk : 0 clear : 1 s : 00 sisr : 1 sisl : 0 pin : 0100 q : xxxx
# Time : 60 clk : 1 clear : 1 s : 00 sisr : 1 sisl : 0 pin : 0100 q : 0000
# Time : 80 clk : 0 clear : 1 s : 00 sisr : 1 sisl : 0 pin : 0100 q : 0000
# Time : 100 clk : 1 clear : 1 s : 01 sisr : 1 sisl : 0 pin : 0001 q : 0000
# Time : 120 clk : 0 clear : 1 s : 01 sisr : 1 sisl : 0 pin : 0001 q : 0000
# Time : 140 clk : 1 clear : 1 s : 01 sisr : 1 sisl : 0 pin : 0001 q : 0000
# Time : 150 clk : 1 clear : 1 s : 01 sisr : 1 sisl : 0 pin : 1001 q : 0000
# Time : 160 clk : 0 clear : 1 s : 01 sisr : 1 sisl : 0 pin : 1001 q : 0000
# Time : 180 clk : 1 clear : 1 s : 01 sisr : 1 sisl : 0 pin : 1001 q : 0000
# Time : 200 clk : 0 clear : 1 s : 10 sisr : 1 sisl : 0 pin : 0011 q : 0000
# Time : 220 clk : 1 clear : 1 s : 10 sisr : 1 sisl : 0 pin : 0011 q : 0000
# Time : 240 clk : 0 clear : 1 s : 10 sisr : 1 sisl : 0 pin : 0011 q : 0000
# Time : 250 clk : 0 clear : 1 s : 10 sisr : 1 sisl : 0 pin : 1101 q : 0000
# Time : 260 clk : 1 clear : 1 s : 10 sisr : 1 sisl : 0 pin : 1101 q : 0000
# Time : 280 clk : 0 clear : 1 s : 10 sisr : 1 sisl : 0 pin : 1101 q : 0000
# Time : 300 clk : 1 clear : 1 s : 11 sisr : 1 sisl : 0 pin : 1101 q : 0000
# Time : 320 clk : 0 clear : 1 s : 11 sisr : 1 sisl : 0 pin : 1101 q : 0000
# Time : 340 clk : 1 clear : 1 s : 11 sisr : 1 sisl : 0 pin : 1101 q : 0000
# Time : 350 clk : 1 clear : 1 s : 11 sisr : 1 sisl : 0 pin : 0101 q : 0000
# Time : 360 clk : 0 clear : 1 s : 11 sisr : 1 sisl : 0 pin : 0101 q : 0000
# Time : 380 clk : 1 clear : 1 s : 11 sisr : 1 sisl : 0 pin : 0101 q : 0000
# Time : 400 clk : 0 clear : 1 s : 00 sisr : 1 sisl : 0 pin : 0010 q : 0000
# Time : 420 clk : 1 clear : 1 s : 00 sisr : 1 sisl : 0 pin : 0010 q : 0000
# Time : 440 clk : 0 clear : 1 s : 00 sisr : 1 sisl : 0 pin : 0010 q : 0000
# Time : 450 clk : 0 clear : 1 s : 00 sisr : 1 sisl : 0 pin : 0001 q : 0000
# Time : 460 clk : 1 clear : 1 s : 00 sisr : 1 sisl : 0 pin : 0001 q : 0000
# Time : 480 clk : 0 clear : 1 s : 00 sisr : 1 sisl : 0 pin : 0001 q : 0000
# Time : 500 clk : 1 clear : 1 s : 01 sisr : 0 sisl : 1 pin : 1101 q : 0000
# Time : 520 clk : 0 clear : 1 s : 01 sisr : 0 sisl : 1 pin : 1101 q : 0000
# Time : 540 clk : 1 clear : 1 s : 01 sisr : 0 sisl : 1 pin : 1101 q : 0000
# Time : 550 clk : 1 clear : 1 s : 01 sisr : 0 sisl : 1 pin : 0110 q : 0000
# Time : 560 clk : 0 clear : 1 s : 01 sisr : 0 sisl : 1 pin : 0110 q : 0000
# Time : 580 clk : 1 clear : 1 s : 01 sisr : 0 sisl : 1 pin : 0110 q : 0000
# Time : 600 clk : 0 clear : 1 s : 10 sisr : 0 sisl : 1 pin : 1101 q : 0000
# Time : 620 clk : 1 clear : 1 s : 10 sisr : 0 sisl : 1 pin : 1101 q : 0000
# Time : 640 clk : 0 clear : 1 s : 10 sisr : 0 sisl : 1 pin : 1101 q : 0000
# Time : 660 clk : 1 clear : 1 s : 10 sisr : 0 sisl : 1 pin : 1101 q : 0000
# Time : 680 clk : 0 clear : 1 s : 10 sisr : 0 sisl : 1 pin : 1101 q : 0000
# Time : 700 clk : 1 clear : 1 s : 11 sisr : 0 sisl : 1 pin : 1100 q : 0000
# Time : 720 clk : 0 clear : 1 s : 11 sisr : 0 sisl : 1 pin : 1100 q : 0000
# Time : 740 clk : 1 clear : 1 s : 11 sisr : 0 sisl : 1 pin : 1100 q : 0000
# Time : 750 clk : 1 clear : 1 s : 11 sisr : 0 sisl : 1 pin : 1001 q : 0000
# Time : 760 clk : 0 clear : 1 s : 11 sisr : 0 sisl : 1 pin : 1001 q : 0000
# Time : 780 clk : 1 clear : 1 s : 11 sisr : 0 sisl : 1 pin : 1001 q : 0000
# Time : 800 clk : 0 clear : 1 s : 00 sisr : 0 sisl : 1 pin : 0110 q : 0000
# Time : 820 clk : 1 clear : 1 s : 00 sisr : 0 sisl : 1 pin : 0110 q : 0000
# Time : 840 clk : 0 clear : 1 s : 00 sisr : 0 sisl : 1 pin : 0110 q : 0000
# Time : 850 clk : 0 clear : 1 s : 00 sisr : 0 sisl : 1 pin : 0101 q : 0000
# Time : 860 clk : 1 clear : 1 s : 00 sisr : 0 sisl : 1 pin : 0101 q : 0000
# Time : 880 clk : 0 clear : 1 s : 00 sisr : 0 sisl : 1 pin : 0101 q : 0000
# Time : 900 clk : 1 clear : 1 s : 01 sisr : 0 sisl : 1 pin : 1010 q : 0000
# Time : 920 clk : 0 clear : 1 s : 01 sisr : 0 sisl : 1 pin : 1010 q : 0000
# Time : 940 clk : 1 clear : 1 s : 01 sisr : 0 sisl : 1 pin : 1010 q : 0000
# Time : 950 clk : 1 clear : 1 s : 01 sisr : 0 sisl : 1 pin : 0101 q : 0000
# Time : 960 clk : 0 clear : 1 s : 01 sisr : 0 sisl : 1 pin : 0101 q : 0000
# Time : 980 clk : 1 clear : 1 s : 01 sisr : 0 sisl : 1 pin : 0101 q : 0000
# ** Note: $finish    : usr_tb.v(30)
#    Time: 1 ns  Iteration: 0  Instance: /usr_tb
*/
