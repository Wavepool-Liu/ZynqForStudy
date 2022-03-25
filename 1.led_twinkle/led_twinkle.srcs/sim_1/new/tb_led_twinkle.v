`timescale 1ns / 1ps //时间刻度1ns,精度1ps


module tb_led_twinkle(

    );

//模拟板子上的激励，对于输入信号一般用reg定义，对于输出信号一般用wire定义
reg         sys_clk;
reg         sys_rst_n;
wire [1:0]  led;
    

//模拟生成时钟信号
initial begin  //只执行一次
    sys_clk<=1'b0;
    sys_rst_n<=1'b0;
    #40   sys_rst_n<=1'b1;  //延时40ns后复位信号拉高
end

always #10 sys_clk<=~sys_clk;  //时钟周期20ns，频率50Mhz


//将子模块的端口进行例化
led_twinkle led_twinkle_u(
    .sys_clk   (sys_clk),
    .sys_rst_n (sys_rst_n),  

    .led       (led)
);
  
    
endmodule
