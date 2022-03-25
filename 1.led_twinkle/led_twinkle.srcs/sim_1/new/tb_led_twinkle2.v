`timescale 1ns / 1ps


module tb_led_twinkle2(

    );


reg sys_clk;
reg sys_rst_n;
wire [1:0] led;

initial begin
    sys_clk <= 1'b0;
    sys_rst_n <= 1'b0;
    #40 sys_rst_n <=1'b1; 
end

always #10 sys_clk <= ~sys_clk;


//Àý»¯Ä£¿é
led_twinkle led_twinkle_u(
.sys_clk  (sys_clk),
.sys_rst_n(sys_rst_n),
.led (led)
);

endmodule
      