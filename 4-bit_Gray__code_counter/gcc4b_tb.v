`include "gcc4b.v"

module gcc4b_tb;
	
	reg clk,rst;
	wire [3:0]q,qbar;

	gcc4b dut(.clk(clk),.rst(rst),.q(q),.qbar(qbar));

	initial begin
		clk=0;
		rst=1;
		#10;
		rst=0;
		$monitor("Time : %0t | clk : %b | rst : %b | q : %b | qbar : %b",$time,clk,rst,q,qbar);
		#1000 $finish;
	end

	always #5 clk=~clk;

endmodule

// output :
/*
# Time : 10 | clk : 0 | rst : 0 | q : 0000 | qbar : 1111
# Time : 15 | clk : 1 | rst : 0 | q : 0001 | qbar : 1110
# Time : 20 | clk : 0 | rst : 0 | q : 0001 | qbar : 1110
# Time : 25 | clk : 1 | rst : 0 | q : 0011 | qbar : 1100
# Time : 30 | clk : 0 | rst : 0 | q : 0011 | qbar : 1100
# Time : 35 | clk : 1 | rst : 0 | q : 0010 | qbar : 1101
# Time : 40 | clk : 0 | rst : 0 | q : 0010 | qbar : 1101
# Time : 45 | clk : 1 | rst : 0 | q : 0110 | qbar : 1001
# Time : 50 | clk : 0 | rst : 0 | q : 0110 | qbar : 1001
# Time : 55 | clk : 1 | rst : 0 | q : 0111 | qbar : 1000
# Time : 60 | clk : 0 | rst : 0 | q : 0111 | qbar : 1000
# Time : 65 | clk : 1 | rst : 0 | q : 0101 | qbar : 1010
# Time : 70 | clk : 0 | rst : 0 | q : 0101 | qbar : 1010
# Time : 75 | clk : 1 | rst : 0 | q : 0100 | qbar : 1011
# Time : 80 | clk : 0 | rst : 0 | q : 0100 | qbar : 1011
# Time : 85 | clk : 1 | rst : 0 | q : 1100 | qbar : 0011
# Time : 90 | clk : 0 | rst : 0 | q : 1100 | qbar : 0011
# Time : 95 | clk : 1 | rst : 0 | q : 1101 | qbar : 0010
# Time : 100 | clk : 0 | rst : 0 | q : 1101 | qbar : 0010
# Time : 105 | clk : 1 | rst : 0 | q : 1111 | qbar : 0000
# Time : 110 | clk : 0 | rst : 0 | q : 1111 | qbar : 0000
# Time : 115 | clk : 1 | rst : 0 | q : 1110 | qbar : 0001
# Time : 120 | clk : 0 | rst : 0 | q : 1110 | qbar : 0001
# Time : 125 | clk : 1 | rst : 0 | q : 1010 | qbar : 0101
# Time : 130 | clk : 0 | rst : 0 | q : 1010 | qbar : 0101
# Time : 135 | clk : 1 | rst : 0 | q : 1011 | qbar : 0100
# Time : 140 | clk : 0 | rst : 0 | q : 1011 | qbar : 0100
# Time : 145 | clk : 1 | rst : 0 | q : 1001 | qbar : 0110
# Time : 150 | clk : 0 | rst : 0 | q : 1001 | qbar : 0110
# Time : 155 | clk : 1 | rst : 0 | q : 1000 | qbar : 0111
# Time : 160 | clk : 0 | rst : 0 | q : 1000 | qbar : 0111
# Time : 165 | clk : 1 | rst : 0 | q : 0000 | qbar : 1111
# Time : 170 | clk : 0 | rst : 0 | q : 0000 | qbar : 1111
# Time : 175 | clk : 1 | rst : 0 | q : 0001 | qbar : 1110
# Time : 180 | clk : 0 | rst : 0 | q : 0001 | qbar : 1110
# Time : 185 | clk : 1 | rst : 0 | q : 0011 | qbar : 1100
# Time : 190 | clk : 0 | rst : 0 | q : 0011 | qbar : 1100
# Time : 195 | clk : 1 | rst : 0 | q : 0010 | qbar : 1101
# Time : 200 | clk : 0 | rst : 0 | q : 0010 | qbar : 1101
# Time : 205 | clk : 1 | rst : 0 | q : 0110 | qbar : 1001
# Time : 210 | clk : 0 | rst : 0 | q : 0110 | qbar : 1001
# Time : 215 | clk : 1 | rst : 0 | q : 0111 | qbar : 1000
# Time : 220 | clk : 0 | rst : 0 | q : 0111 | qbar : 1000
# Time : 225 | clk : 1 | rst : 0 | q : 0101 | qbar : 1010
# Time : 230 | clk : 0 | rst : 0 | q : 0101 | qbar : 1010
# Time : 235 | clk : 1 | rst : 0 | q : 0100 | qbar : 1011
# Time : 240 | clk : 0 | rst : 0 | q : 0100 | qbar : 1011
# Time : 245 | clk : 1 | rst : 0 | q : 1100 | qbar : 0011
# Time : 250 | clk : 0 | rst : 0 | q : 1100 | qbar : 0011
# Time : 255 | clk : 1 | rst : 0 | q : 1101 | qbar : 0010
# Time : 260 | clk : 0 | rst : 0 | q : 1101 | qbar : 0010
# Time : 265 | clk : 1 | rst : 0 | q : 1111 | qbar : 0000
# Time : 270 | clk : 0 | rst : 0 | q : 1111 | qbar : 0000
# Time : 275 | clk : 1 | rst : 0 | q : 1110 | qbar : 0001
# Time : 280 | clk : 0 | rst : 0 | q : 1110 | qbar : 0001
# Time : 285 | clk : 1 | rst : 0 | q : 1010 | qbar : 0101
# Time : 290 | clk : 0 | rst : 0 | q : 1010 | qbar : 0101
# Time : 295 | clk : 1 | rst : 0 | q : 1011 | qbar : 0100
# Time : 300 | clk : 0 | rst : 0 | q : 1011 | qbar : 0100
# Time : 305 | clk : 1 | rst : 0 | q : 1001 | qbar : 0110
# Time : 310 | clk : 0 | rst : 0 | q : 1001 | qbar : 0110
# Time : 315 | clk : 1 | rst : 0 | q : 1000 | qbar : 0111
# Time : 320 | clk : 0 | rst : 0 | q : 1000 | qbar : 0111
# Time : 325 | clk : 1 | rst : 0 | q : 0000 | qbar : 1111
# Time : 330 | clk : 0 | rst : 0 | q : 0000 | qbar : 1111
# Time : 335 | clk : 1 | rst : 0 | q : 0001 | qbar : 1110
# Time : 340 | clk : 0 | rst : 0 | q : 0001 | qbar : 1110
# Time : 345 | clk : 1 | rst : 0 | q : 0011 | qbar : 1100
# Time : 350 | clk : 0 | rst : 0 | q : 0011 | qbar : 1100
# Time : 355 | clk : 1 | rst : 0 | q : 0010 | qbar : 1101
# Time : 360 | clk : 0 | rst : 0 | q : 0010 | qbar : 1101
# Time : 365 | clk : 1 | rst : 0 | q : 0110 | qbar : 1001
# Time : 370 | clk : 0 | rst : 0 | q : 0110 | qbar : 1001
# Time : 375 | clk : 1 | rst : 0 | q : 0111 | qbar : 1000
# Time : 380 | clk : 0 | rst : 0 | q : 0111 | qbar : 1000
# Time : 385 | clk : 1 | rst : 0 | q : 0101 | qbar : 1010
# Time : 390 | clk : 0 | rst : 0 | q : 0101 | qbar : 1010
# Time : 395 | clk : 1 | rst : 0 | q : 0100 | qbar : 1011
# Time : 400 | clk : 0 | rst : 0 | q : 0100 | qbar : 1011
# Time : 405 | clk : 1 | rst : 0 | q : 1100 | qbar : 0011
# Time : 410 | clk : 0 | rst : 0 | q : 1100 | qbar : 0011
# Time : 415 | clk : 1 | rst : 0 | q : 1101 | qbar : 0010
# Time : 420 | clk : 0 | rst : 0 | q : 1101 | qbar : 0010
# Time : 425 | clk : 1 | rst : 0 | q : 1111 | qbar : 0000
# Time : 430 | clk : 0 | rst : 0 | q : 1111 | qbar : 0000
# Time : 435 | clk : 1 | rst : 0 | q : 1110 | qbar : 0001
# Time : 440 | clk : 0 | rst : 0 | q : 1110 | qbar : 0001
# Time : 445 | clk : 1 | rst : 0 | q : 1010 | qbar : 0101
# Time : 450 | clk : 0 | rst : 0 | q : 1010 | qbar : 0101
# Time : 455 | clk : 1 | rst : 0 | q : 1011 | qbar : 0100
# Time : 460 | clk : 0 | rst : 0 | q : 1011 | qbar : 0100
# Time : 465 | clk : 1 | rst : 0 | q : 1001 | qbar : 0110
# Time : 470 | clk : 0 | rst : 0 | q : 1001 | qbar : 0110
# Time : 475 | clk : 1 | rst : 0 | q : 1000 | qbar : 0111
# Time : 480 | clk : 0 | rst : 0 | q : 1000 | qbar : 0111
# Time : 485 | clk : 1 | rst : 0 | q : 0000 | qbar : 1111
# Time : 490 | clk : 0 | rst : 0 | q : 0000 | qbar : 1111
# Time : 495 | clk : 1 | rst : 0 | q : 0001 | qbar : 1110
# Time : 500 | clk : 0 | rst : 0 | q : 0001 | qbar : 1110
# Time : 505 | clk : 1 | rst : 0 | q : 0011 | qbar : 1100
# Time : 510 | clk : 0 | rst : 0 | q : 0011 | qbar : 1100
# Time : 515 | clk : 1 | rst : 0 | q : 0010 | qbar : 1101
# Time : 520 | clk : 0 | rst : 0 | q : 0010 | qbar : 1101
# Time : 525 | clk : 1 | rst : 0 | q : 0110 | qbar : 1001
# Time : 530 | clk : 0 | rst : 0 | q : 0110 | qbar : 1001
# Time : 535 | clk : 1 | rst : 0 | q : 0111 | qbar : 1000
# Time : 540 | clk : 0 | rst : 0 | q : 0111 | qbar : 1000
# Time : 545 | clk : 1 | rst : 0 | q : 0101 | qbar : 1010
# Time : 550 | clk : 0 | rst : 0 | q : 0101 | qbar : 1010
# Time : 555 | clk : 1 | rst : 0 | q : 0100 | qbar : 1011
# Time : 560 | clk : 0 | rst : 0 | q : 0100 | qbar : 1011
# Time : 565 | clk : 1 | rst : 0 | q : 1100 | qbar : 0011
# Time : 570 | clk : 0 | rst : 0 | q : 1100 | qbar : 0011
# Time : 575 | clk : 1 | rst : 0 | q : 1101 | qbar : 0010
# Time : 580 | clk : 0 | rst : 0 | q : 1101 | qbar : 0010
# Time : 585 | clk : 1 | rst : 0 | q : 1111 | qbar : 0000
# Time : 590 | clk : 0 | rst : 0 | q : 1111 | qbar : 0000
# Time : 595 | clk : 1 | rst : 0 | q : 1110 | qbar : 0001
# Time : 600 | clk : 0 | rst : 0 | q : 1110 | qbar : 0001
# Time : 605 | clk : 1 | rst : 0 | q : 1010 | qbar : 0101
# Time : 610 | clk : 0 | rst : 0 | q : 1010 | qbar : 0101
# Time : 615 | clk : 1 | rst : 0 | q : 1011 | qbar : 0100
# Time : 620 | clk : 0 | rst : 0 | q : 1011 | qbar : 0100
# Time : 625 | clk : 1 | rst : 0 | q : 1001 | qbar : 0110
# Time : 630 | clk : 0 | rst : 0 | q : 1001 | qbar : 0110
# Time : 635 | clk : 1 | rst : 0 | q : 1000 | qbar : 0111
# Time : 640 | clk : 0 | rst : 0 | q : 1000 | qbar : 0111
# Time : 645 | clk : 1 | rst : 0 | q : 0000 | qbar : 1111
# Time : 650 | clk : 0 | rst : 0 | q : 0000 | qbar : 1111
# Time : 655 | clk : 1 | rst : 0 | q : 0001 | qbar : 1110
# Time : 660 | clk : 0 | rst : 0 | q : 0001 | qbar : 1110
# Time : 665 | clk : 1 | rst : 0 | q : 0011 | qbar : 1100
# Time : 670 | clk : 0 | rst : 0 | q : 0011 | qbar : 1100
# Time : 675 | clk : 1 | rst : 0 | q : 0010 | qbar : 1101
# Time : 680 | clk : 0 | rst : 0 | q : 0010 | qbar : 1101
# Time : 685 | clk : 1 | rst : 0 | q : 0110 | qbar : 1001
# Time : 690 | clk : 0 | rst : 0 | q : 0110 | qbar : 1001
# Time : 695 | clk : 1 | rst : 0 | q : 0111 | qbar : 1000
# Time : 700 | clk : 0 | rst : 0 | q : 0111 | qbar : 1000
# Time : 705 | clk : 1 | rst : 0 | q : 0101 | qbar : 1010
# Time : 710 | clk : 0 | rst : 0 | q : 0101 | qbar : 1010
# Time : 715 | clk : 1 | rst : 0 | q : 0100 | qbar : 1011
# Time : 720 | clk : 0 | rst : 0 | q : 0100 | qbar : 1011
# Time : 725 | clk : 1 | rst : 0 | q : 1100 | qbar : 0011
# Time : 730 | clk : 0 | rst : 0 | q : 1100 | qbar : 0011
# Time : 735 | clk : 1 | rst : 0 | q : 1101 | qbar : 0010
# Time : 740 | clk : 0 | rst : 0 | q : 1101 | qbar : 0010
# Time : 745 | clk : 1 | rst : 0 | q : 1111 | qbar : 0000
# Time : 750 | clk : 0 | rst : 0 | q : 1111 | qbar : 0000
# Time : 755 | clk : 1 | rst : 0 | q : 1110 | qbar : 0001
# Time : 760 | clk : 0 | rst : 0 | q : 1110 | qbar : 0001
# Time : 765 | clk : 1 | rst : 0 | q : 1010 | qbar : 0101
# Time : 770 | clk : 0 | rst : 0 | q : 1010 | qbar : 0101
# Time : 775 | clk : 1 | rst : 0 | q : 1011 | qbar : 0100
# Time : 780 | clk : 0 | rst : 0 | q : 1011 | qbar : 0100
# Time : 785 | clk : 1 | rst : 0 | q : 1001 | qbar : 0110
# Time : 790 | clk : 0 | rst : 0 | q : 1001 | qbar : 0110
# Time : 795 | clk : 1 | rst : 0 | q : 1000 | qbar : 0111
# Time : 800 | clk : 0 | rst : 0 | q : 1000 | qbar : 0111
# Time : 805 | clk : 1 | rst : 0 | q : 0000 | qbar : 1111
# Time : 810 | clk : 0 | rst : 0 | q : 0000 | qbar : 1111
# Time : 815 | clk : 1 | rst : 0 | q : 0001 | qbar : 1110
# Time : 820 | clk : 0 | rst : 0 | q : 0001 | qbar : 1110
# Time : 825 | clk : 1 | rst : 0 | q : 0011 | qbar : 1100
# Time : 830 | clk : 0 | rst : 0 | q : 0011 | qbar : 1100
# Time : 835 | clk : 1 | rst : 0 | q : 0010 | qbar : 1101
# Time : 840 | clk : 0 | rst : 0 | q : 0010 | qbar : 1101
# Time : 845 | clk : 1 | rst : 0 | q : 0110 | qbar : 1001
# Time : 850 | clk : 0 | rst : 0 | q : 0110 | qbar : 1001
# Time : 855 | clk : 1 | rst : 0 | q : 0111 | qbar : 1000
# Time : 860 | clk : 0 | rst : 0 | q : 0111 | qbar : 1000
# Time : 865 | clk : 1 | rst : 0 | q : 0101 | qbar : 1010
# Time : 870 | clk : 0 | rst : 0 | q : 0101 | qbar : 1010
# Time : 875 | clk : 1 | rst : 0 | q : 0100 | qbar : 1011
# Time : 880 | clk : 0 | rst : 0 | q : 0100 | qbar : 1011
# Time : 885 | clk : 1 | rst : 0 | q : 1100 | qbar : 0011
# Time : 890 | clk : 0 | rst : 0 | q : 1100 | qbar : 0011
# Time : 895 | clk : 1 | rst : 0 | q : 1101 | qbar : 0010
# Time : 900 | clk : 0 | rst : 0 | q : 1101 | qbar : 0010
# Time : 905 | clk : 1 | rst : 0 | q : 1111 | qbar : 0000
# Time : 910 | clk : 0 | rst : 0 | q : 1111 | qbar : 0000
# Time : 915 | clk : 1 | rst : 0 | q : 1110 | qbar : 0001
# Time : 920 | clk : 0 | rst : 0 | q : 1110 | qbar : 0001
# Time : 925 | clk : 1 | rst : 0 | q : 1010 | qbar : 0101
# Time : 930 | clk : 0 | rst : 0 | q : 1010 | qbar : 0101
# Time : 935 | clk : 1 | rst : 0 | q : 1011 | qbar : 0100
# Time : 940 | clk : 0 | rst : 0 | q : 1011 | qbar : 0100
# Time : 945 | clk : 1 | rst : 0 | q : 1001 | qbar : 0110
# Time : 950 | clk : 0 | rst : 0 | q : 1001 | qbar : 0110
# Time : 955 | clk : 1 | rst : 0 | q : 1000 | qbar : 0111
# Time : 960 | clk : 0 | rst : 0 | q : 1000 | qbar : 0111
# Time : 965 | clk : 1 | rst : 0 | q : 0000 | qbar : 1111
# Time : 970 | clk : 0 | rst : 0 | q : 0000 | qbar : 1111
# Time : 975 | clk : 1 | rst : 0 | q : 0001 | qbar : 1110
# Time : 980 | clk : 0 | rst : 0 | q : 0001 | qbar : 1110
# Time : 985 | clk : 1 | rst : 0 | q : 0011 | qbar : 1100
# Time : 990 | clk : 0 | rst : 0 | q : 0011 | qbar : 1100
# Time : 995 | clk : 1 | rst : 0 | q : 0010 | qbar : 1101
# Time : 1000 | clk : 0 | rst : 0 | q : 0010 | qbar : 1101
# Time : 1005 | clk : 1 | rst : 0 | q : 0110 | qbar : 1001
# ** Note: $finish    : gcc4b_tb.v(16)
#    Time: 1010 ps  Iteration: 0  Instance: /gcc4b_tb
*/
