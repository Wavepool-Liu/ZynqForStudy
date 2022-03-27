module led_twinkle (
    input        sys_clk  ,
    input        sys_rst_n,  //复位信号低电平有效//哈哈哈哈

    output [1:0] led,
    output [25:0]cnt
);

reg [25:0] cnt_reg ;

assign led=(cnt<26'd25)?2'b01:2'b10;
assign cnt = cnt_reg;

always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        cnt_reg <= 26'd0;
    else if(cnt_reg<26'd50)
        cnt_reg<=cnt_reg+1'b1;
    else
    cnt_reg <= 26'd0;

end


endmodule