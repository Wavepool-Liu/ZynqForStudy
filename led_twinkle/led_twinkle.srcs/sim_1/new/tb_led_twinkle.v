`timescale 1ns / 1ps //ʱ��̶�1ns,����1ps


module tb_led_twinkle(

    );

//ģ������ϵļ��������������ź�һ����reg���壬��������ź�һ����wire����
reg         sys_clk;
reg         sys_rst_n;
wire [1:0]  led;
    

//ģ������ʱ���ź�
initial begin  //ִֻ��һ��
    sys_clk<=1'b0;
    sys_rst_n<=1'b0;
    #40   sys_rst_n<=1'b1;  //��ʱ40ns��λ�ź�����
end

always #10 sys_clk<=~sys_clk;  //ʱ������20ns��Ƶ��50Mhz


//����ģ��Ķ˿ڽ�������
led_twinkle led_twinkle_u(
    .sys_clk   (sys_clk),
    .sys_rst_n (sys_rst_n),  

    .led       (led)
);
  
    
endmodule
