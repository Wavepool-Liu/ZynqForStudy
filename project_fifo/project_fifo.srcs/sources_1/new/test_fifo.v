`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/13 16:23:13
// Design Name: 
// Module Name: test_fifo
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


module test_fifo(
//-----------clk&reset-------------
input	wire	clk,
input	wire 	rst,

output  reg 	[5:0]din,
output  reg		wr_en,
output  wire    [5:0]dout,//?
output  reg 	rd_en,

output  wire     full,
output  wire     empty,

output  reg      [5:0]cnt
    );

//counter 
reg [5:0] cnt;
always @(posedge clk or posedge rst) begin
	if (!rst) begin
		cnt <= 0;
	end
	else if (cnt == 6'd63) begin
		cnt <= 6'd0;
	end
	else begin
		cnt <= cnt + 6'd1;
	end
end

//wr_en enable
always @(posedge clk or posedge rst) begin
	if (!rst) begin
		// reset
		wr_en <= 1'b0;
	end
	else if (cnt >= 6'd0 && cnt <= 6'd31) begin
		wr_en <= 1'b1;
	end
	else begin
		wr_en <= 1'b0;
	end
end
 
//rd_en enable
always @(posedge clk or posedge rst) begin
	if (!rst) begin
		// reset
		rd_en <= 1'b0;
	end
	else if (cnt >= 6'd32 && cnt <= 6'd63) begin
		rd_en <= 1'b1;
	end
	else begin
		rd_en <= 1'b0;
	end
end

always @(posedge clk or posedge rst) begin
	if (!rst) begin
		// reset
		din <= 6'b0;
	end
	else if (wr_en == 1'b1) begin
		din <= cnt;
	end
	else begin
	   din <= 6'b0;
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
test_fifo test_fifo(
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