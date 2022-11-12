module dummy(in,clk,out,flag1,flag2,wb_rst,wb_clk);
input [10:0] in;
input clk;
output reg flag1;
output reg flag2;
output [3:0] out;
input wb_rst,wb_clk;
// Wire
wire [10:0] x3;
wire X1,X2,X3,X4;
assign X1=in[0];    
assign X2=in[1];

not (x3[0],in[0]);
not (x3[1],in[1]);
not (x3[2],in[2]);
not (x3[3],in[3]);
not (x3[4],in[4]);
not (x3[5],in[5]);
not (x3[6],in[6]);
not (x3[7],in[7]);
not (x3[8],in[8]);
not (x3[9],in[9]);
not (x3[10],in[10]);
not (X3,wb_rst);
not (X4,wb_clk);
not (out[0],in[0]);
not (out[1],in[1]);
not (out[2],in[2]);
not (out[3],in[3]);


// 7 Output Pad Reserve by using below logic
always@(posedge clk)
begin
flag1<=X1;
flag2<=X2;
end
endmodule
