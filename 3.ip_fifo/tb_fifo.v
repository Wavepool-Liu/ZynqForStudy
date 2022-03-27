`timescale 1ns / 1ps
module tb_fifo(
    );
reg sys_clk;
reg sys_rst_n;
wire [7:0] dout;

initial begin
    sys_clk <= 1'b0;
    sys_rst_n <= 1'b0;
    #40
    sys_rst_n <= 1'b1;
end   

always #10 sys_clk <=~sys_clk;
    
ip_fifo ip_fifo_u(
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n)

);
endmodule
