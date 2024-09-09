module cla(
  input [3:0] a,b,
  input c_in,
  output [3:0]s,
  output c_out);
  
  wire [3:0]cg,cp; // cg-->carry generation cp-->carry propogate
  wire [2:0]c;
// carry generation and propogatin 
  assign cg[3]=a[3]&b[3];
  assign cp[3]=a[3]^b[3];
  assign cg[2]=a[2]&b[2];
  assign cp[2]=a[2]^b[2];
  assign cg[1]=a[1]&b[1];
  assign cp[1]=a[1]^b[1];
  assign cg[0]=a[0]&b[0];
  assign cp[0]=a[0]^b[0];
// carry calculation 
  assign c[0]=(cg[0]|(cp[0]&c_in));
  assign c[1]=(cg[1]|(cp[1]&c[0]));
  assign c[2]=(cg[2]|(cp[2]&c[1]));
  assign c_out=(cg[3]|(cp[3]&c[2]));
// sum calculatio
  assign s[3]=cp[3]^c[2];
  assign s[2]=cp[2]^c[1];
  assign s[1]=cp[1]^c[0];
  assign s[0]=cp[0]^c_in;
endmodule

// output :
/*
# Time = 0 | a = 1001 | b = 0010 | c_in = 0 | s = 1011 | c_out = 0
# Time = 10 | a = 0100 | b = 0000 | c_in = 1 | s = 0101 | c_out = 0
# Time = 20 | a = 0000 | b = 0100 | c_in = 1 | s = 0101 | c_out = 0
# Time = 30 | a = 0011 | b = 0001 | c_in = 1 | s = 0101 | c_out = 0
# Time = 40 | a = 1000 | b = 0110 | c_in = 1 | s = 1111 | c_out = 0
# Time = 50 | a = 1100 | b = 0110 | c_in = 1 | s = 0011 | c_out = 1
# Time = 60 | a = 0011 | b = 0010 | c_in = 1 | s = 0110 | c_out = 0
# Time = 70 | a = 0000 | b = 1001 | c_in = 0 | s = 1001 | c_out = 0
# Time = 80 | a = 1000 | b = 0000 | c_in = 1 | s = 1001 | c_out = 0
# Time = 90 | a = 1000 | b = 0110 | c_in = 1 | s = 1111 | c_out = 0
# Time = 100 | a = 1011 | b = 1011 | c_in = 0 | s = 0110 | c_out = 1
# Time = 110 | a = 1001 | b = 1110 | c_in = 1 | s = 1000 | c_out = 1
# Time = 120 | a = 1111 | b = 0110 | c_in = 1 | s = 0110 | c_out = 1
# Time = 130 | a = 1100 | b = 0110 | c_in = 0 | s = 0010 | c_out = 1
# Time = 140 | a = 1111 | b = 1100 | c_in = 1 | s = 1100 | c_out = 1
# Time = 150 | a = 0110 | b = 0011 | c_in = 0 | s = 1001 | c_out = 0
# Time = 160 | a = 0110 | b = 0010 | c_in = 1 | s = 1001 | c_out = 0
# Time = 170 | a = 0101 | b = 0101 | c_in = 0 | s = 1010 | c_out = 0
# Time = 180 | a = 1111 | b = 0010 | c_in = 1 | s = 0010 | c_out = 1
# Time = 190 | a = 0011 | b = 1011 | c_in = 1 | s = 1111 | c_out = 0
# ** Note: $finish    : cla_tb.v(35)
#    Time: 400 ps  Iteration: 0  Instance: /cla_tb
*/
