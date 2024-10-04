`include "usr.v"

module usr_tb;

    reg clk, clear;                // Clock and Clear signals
    reg [1:0] s;                   // Mode select signals
    reg sisr, sisl;                // Serial inputs for shift-right and shift-left
    reg [3:0] pin;                 // Parallel inputs
    wire [3:0] q;                  // Output

    // Instantiate the DUT (Device Under Test)
    usr dut (
        .clk(clk),
        .clear(clear),
        .s(s),
        .sisr(sisr),
        .sisl(sisl),
        .pin(pin),
        .q(q)
    );

   initial begin
        clear =0;
        clk=0;
        sisl =0;
        s=2'b00;
        sisl=0;
        sisr=1;
        $monitor("Time : %0t clk : %b clear : %b s : %b sisr : %b sisl : %b pin : %b q : %b",$time,clk,clear,s,sisr,sisl,pin,q);
        #1000 $finish;
    end
	
    initial #50 clear = 1;
    always #20 clk =~clk;
    always #50 pin=$random;
    always #500 sisr = ~sisr;
    always #500 sisl = ~sisl;
    always #100 s[0]=~s[0];
    always #200 s[1]=~s[1];

    
endmodule
