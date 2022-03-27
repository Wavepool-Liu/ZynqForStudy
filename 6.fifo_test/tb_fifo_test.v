`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/03 21:46:30
// Design Name: 
// Module Name: fifo1_tst
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_fifo_test();
reg clk;
reg srst;
reg [4:0] din;
reg wr_en;
reg rd_en;
wire [4:0] dout;
wire full;
wire empty;

integer      i ;
//reg [4:0]    counter2 ;

initial begin
    clk=1;
    srst=1;
    wr_en=0;
    rd_en=0;
    #10 srst=0;
    #100 wr_en=1;
//    counter2 = 5'b0;
    for (i=0; i<=18; i=i+1) begin
        #10 ;
        din = i;
    end
    wr_en=0;
    rd_en=1;
    for (i=0; i<=18; i=i+1) begin
        #10 ;
    end
    rd_en=0;
end


//din=1;
//#10 din=2;
//#10 din=3;
//#10 din=4;
//#10 wr_en=0;
//#10 rd_en=1;

////din=0;
//#100 rd_en=0;
//#10 wr_en=1;
// din=5;
//#10 din=6;
//#10 wr_en=0;
////din=0;

//#100 rd_en=1;

always #5 clk=~clk;



    
fifo_generator_0 uut (
  .clk(clk),      // input wire clk
  .srst(srst),    // input wire srst
  .din(din),      // input wire [17 : 0] din
  .wr_en(wr_en),  // input wire wr_en
  .rd_en(rd_en),  // input wire rd_en
  .dout(dout),    // output wire [17 : 0] dout
  .full(full),    // output wire full
  .empty(empty)  // output wire empty
);
endmodule

