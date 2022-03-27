`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/11 10:42:21
// Design Name: 
// Module Name: fifo_tb
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


module fifo_tb();

reg      clk;
reg      rst;
wire  [5:0] din;
wire   wr_en;
wire   [5:0] dout;
wire     rd_en;
wire     full;
wire     empty;
wire  [5:0]cnt;

test_fifo test_fifo(
    .clk(clk),
    .rst(rst),
    .din(din),
    .wr_en(wr_en),
    .dout(dout),
    .rd_en(rd_en),
    .full(full),
    .empty(empty),
    .cnt(cnt)
    );

initial begin
	clk = 0;
	rst = 0;
	#200
	rst = 1;
end

always begin
	#5 clk=~clk;
end
endmodule
