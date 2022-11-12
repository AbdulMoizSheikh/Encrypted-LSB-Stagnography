module select_wrapper(rst_wb, clk_wb, cover_wb,wb_cyc,wb_stb,wb_we,wb_ack,key1,key2,out_p,out_wb,data1,data2,flag1,flag2,flag4,clk_p,rst_p,cover_p,sel,clk_flag,flag5,flag6);
//inputs wishbone
input rst_wb;
input clk_wb;
input [7:0] cover_wb;
input wb_cyc,wb_stb,wb_we;

//AES inputs
input key1,key2;
input data1,data2;

//select lines
input sel;
//pad inputs
input clk_p,rst_p,cover_p;
//flags for outputs of encryption and steganography
output flag1,flag2;
//output
output reg [7:0] out_wb;     //wishbone output
output reg out_p;          //pad output
output reg clk_flag;    //clock frequency output
output reg wb_ack;      //output wishbone acknowledgement
output reg flag5,flag6;     //for visual representation

//kcover data logic when getting data from the pads is still pending will do once rest is done

//temperary registers for connecting to module.
reg clk,clk1;   //external clock and internal clocks
reg rst,flag3;
output reg flag4;     //flag 3 and 4 for completing the data transfer.
reg [7:0] kcover;
reg [127:0] data,key,res;     //actuall registers for storing
reg [6:0] count;    //counter for counting
reg [3:0] count1;     //for dividing the clock
wire [31:0] out;      
wire flg5,flg6;           //dummy output
//pads mess
reg [2:0] count33;
//for pads mess input
reg [3:0]cnt;    //for input of kcover data through pads
reg [2:0] count3;  //for output from pads. 
reg [7:0]tmp; //for temperory storage

//initializing the actuall module
aescipher uut (.key(key), .datain(data), .clk(clk) ,.dataout(res));
stegano_core uut2 (.payload(res), .kcover(kcover), .clk(clk), .out(out), .SD(flag2), .en(flag1));

//logic for selecting clock since clock selection is dependant always sensitivity list contain *
always @ (*)
begin
case(sel)
0:clk=clk_wb;
1:clk=clk_p;
endcase
end

//for seeing visually which clock is being used
always @ (posedge clk)
begin
clk_flag=clk;
end
///////
always@(res)
begin
flag1<=1'b1;
end

//for assigning internal clock i.e. divide by 8 if sel=1 and same when sel=0; for coherence of output when it is taken from one pad
always @ (clk)
begin
if (sel==0)
begin
clk1=clk;       //same as external
end
if(sel==1)
begin
count1=count1+1;
clk1=count1[3];       //clk1=clk/8
end
end

//logic for selecting reset since clock is selected this is dependant on clock
always @ (posedge clk)
begin
case(sel)
0:rst=rst_wb;
1:rst=rst_p;
endcase
end

//reading data from the wishbone if select is zero then wishbone is used
//if the wishbone cycle and stable is high we take the data from the master else we ignore and keep the previous data 
//if select is one data is taken from pads and we have to write its logic.  
always @ (posedge clk)
begin
case(sel)
//wishone
0:begin
if(wb_cyc && wb_stb && wb_we)
begin
kcover[7:0]=cover_wb[7:0];
wb_ack=wb_stb;
end
else
begin
kcover[7:0]=kcover[7:0];
wb_ack=wb_stb && wb_cyc;
end
end
//pads
1: begin
tmp[cnt]=cover_p;     //assuming input comes lsb first
cnt=cnt+1;
if(cnt>7)            //i.e. all 8 bits have been entered
begin
kcover[7:0]=tmp[7:0];      //substitute the input to module
cnt=4'b0000;               //reset the interm counter
end
end
endcase
end

//writing data to the wishbone if select is zero then wishbone is used
//if wishbone stable is high and cycle is high and write enable is low we write data to the wishbone else we keep previous state
//if select is one we put data to the pads. 
always @ (posedge clk)
begin
case(sel)
0:begin
if(wb_cyc && wb_stb && !wb_we)
begin
case (count33)
1:begin
out_wb[31:0]=res[31:0];
wb_ack<=wb_stb;
end
2:begin
out_wb[31:0]=res[63:32];
wb_ack<=wb_stb;
end
3:begin
out_wb[31:0]=res[95:64];
wb_ack<=wb_stb;
end
4:begin
out_wb[31:0]=res[127:96];
wb_ack<=wb_stb;
end
default:begin
out_wb[31:0]=res[31:0];
wb_ack<=wb_stb;
end
endcase
end
else
begin
out_wb[31:0]<=out_wb[31:0];
wb_ack=wb_stb && wb_cyc;
end
end

1:begin
out_p=out[count3];
count3=count3+1;
end
endcase
end


//counter increment values
always @(posedge clk)
begin
if(rst==1)
begin
count<=7'b0000000;
count1<=4'b0000; 
cnt<=4'b0000;
count3<=3'b000; 
flag4<=1'b0;
count3<=3'b000;
end
else 
count<=count+1;
count33<=count33+1;
end

//values added into the corresponding 128 bit registers from pads

always @ (posedge clk)
begin
if(count<=64) 
begin
key[count-1]<=key1;
key[count+63]<=key2;
end
else
key[127:0]<=key[127:0];
end

always @ (posedge clk)
begin
if(count<=64)
begin
data[count-1]<=data1;
data[count+63]<=data2;
end
else
data[127:0]<=data[127:0];
end



//implementing the flag for when data transfer into registers is complete ie. flag4
always @ (posedge clk)
begin
if(count>=65 && count<=67)
begin
flag4=1'b1;
end
else
flag4=1'b0;
end


//implementing the enable for the top module
always @ (posedge clk)
begin
if (flag4==1)
begin
flag3=1'b1;
end
else
flag3=flag3;
end


//implementing visual flags
always @ (posedge clk)
begin
if (rst)
begin
flag5=1'b0;
flag6=1'b0;
end
else
begin
flag5=!flg5;
flag6=!flg6;
end
end


endmodule
