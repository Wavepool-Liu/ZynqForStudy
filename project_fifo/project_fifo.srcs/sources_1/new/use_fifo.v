`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/11 10:41:52
// Design Name: 
// Module Name: use_fifo
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies:
//1.首先是一个计数器cnt计数到64。
//2.然后在cnt取0-31时，开始写入数据，写入的数据都等于cnt。
//3.开始在cnt取32-63时，开始读出数据。
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module use_fifo(
//-----------clk&reset-------------
input	wire	clk,
input	wire 	rst,
output  reg   [5:0]din,//
output  reg     wr_en,
output  wire     [5:0]dout,
output  reg     rd_en,
output  wire   full,
output  wire   empty
    );

//counter
reg [5:0] cnt;

always@(posedge clk or negedge rst)begin
	if(!rst) 
		cnt <= 0;
	else if(cnt==6'd63)
		cnt <= 0;
	else
		cnt <= cnt + 1'b1;
end

// enable write
always@(posedge clk or negedge rst) begin
	if(!rst)
		wr_en <= 1'b0;
	else if(cnt>=0 && cnt<=6'd31)
		wr_en <= 1'b1;
	else
		wr_en <= 1'b0;
end

//enable read
always@(posedge clk or negedge rst) begin
	if(!rst) begin
		rd_en <= 1'b0;
	end
	else if(cnt>=6'd32 &&  cnt<=63) begin
		rd_en <= 1'b1;
	end
	else begin
		rd_en <= 1'b0;
	end
end

//write the data to the fifo
always@(posedge clk or negedge rst) begin
	if(!rst) begin
		din <= 6'b0;
	end
	else if(wr_en == 1'b1) begin
		din <= cnt;
	end
	else begin
		din <= din;
	end
end

//----------- Begin Cut here for INSTANTIATION Template ---//
fifo_generator_0 your_instance_name (
  .clk(clk),                  // input wire clk
  .rst(rst),                  // input wire rst
  .din(din),                  // input wire [5 : 0] din
  .wr_en(wr_en),              // input wire wr_en
  .rd_en(rd_en),              // input wire rd_en
  .dout(dout),                // output wire [5 : 0] dout
  .full(full),                // output wire full
  .empty(empty),              // output wire empty
  .wr_rst_busy(wr_rst_busy),  // output wire wr_rst_busy
  .rd_rst_busy(rd_rst_busy)  // output wire rd_rst_busy
);
endmodule

/*
use_fifo use_fifo(
    .clk(),
    .rst(),
    .din(),
    .wr_en(),
    .dout(),
    .rd_en(),
    .full(),
    .empty()
    );
*/
