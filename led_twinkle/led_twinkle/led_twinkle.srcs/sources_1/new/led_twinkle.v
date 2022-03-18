module led_twinkle (
    input        sys_clk  ,
    input        sys_rst_n,  //复位信号低电平有效

    output [1:0] led
);

reg [25:0] cnt ;

assign led=(cnt<26'd2500_0000)?2'b01:2'b10;

always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        cnt <= 26'd0;
    else if(cnt<26'd5000_0000)
        cnt<=cnt+1'b1;
    else
    cnt <= 26'd0;

end


endmodule