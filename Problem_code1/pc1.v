/*

Problem statement :

A certain combinational circuit gives the output 1 if input variables have more 1's than 0's. The output is 0 otherwise. Design the combinational circuit by finding the circuit's truth table,Boolean equation and a logic diagram and implement verilog code ?
 
*/

module pc1(input a,b,c,d,
		   output y
		  );

	   wire [5:0]g;

//	   assign y = ((c&d)&(a|b))|((a&b)&(c|d));

	   and(g[0],c,d);
	   or(g[1],a,b);
	   and(g[2],a,b);
	   or(g[3],c,d);
	   and(g[4],g[1],g[0]);
	   and(g[5],g[3],g[2]);
	   or(y,g[5],g[4]);

endmodule

// output :

/*
# a : 1, b : 0, c : 0, d : 0, y : 0
# a : 0, b : 1, c : 1, d : 0, y : 0
# a : 0, b : 1, c : 1, d : 0, y : 0
# a : 0, b : 0, c : 1, d : 0, y : 0
# a : 0, b : 1, c : 1, d : 1, y : 1
# a : 1, b : 0, c : 1, d : 0, y : 0
# a : 1, b : 1, c : 1, d : 1, y : 1
# a : 0, b : 1, c : 0, d : 1, y : 0
# a : 1, b : 1, c : 1, d : 0, y : 1
# a : 1, b : 0, c : 1, d : 1, y : 1
# a : 0, b : 0, c : 1, d : 1, y : 0
# a : 0, b : 1, c : 0, d : 1, y : 0
# a : 0, b : 1, c : 0, d : 1, y : 0
# a : 1, b : 1, c : 0, d : 1, y : 1
# a : 1, b : 0, c : 0, d : 0, y : 0
# a : 0, b : 1, c : 1, d : 0, y : 0
# a : 1, b : 0, c : 0, d : 1, y : 0
# a : 0, b : 0, c : 0, d : 0, y : 0
# a : 0, b : 1, c : 0, d : 0, y : 0
# a : 0, b : 0, c : 0, d : 0, y : 0
# ** Note: $finish    : pc1_tb.v(17)
#    Time: 75 ps  Iteration: 0  Instance: /pc1_tb
*/
