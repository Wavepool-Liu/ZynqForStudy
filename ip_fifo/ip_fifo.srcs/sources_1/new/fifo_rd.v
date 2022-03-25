`timescale 1ns / 1ps


module fifo_rd(
    input               clk,
    input               rst_n,

    input               almost_empty,
    input               almost_full,

    output reg          fifo_rd_en
//    input  [7:0]        fifo_rd_data //因为可以引用在线调试的软核读数据，所以可以不要了
);

reg          almost_full_d0;
reg          almost_full_syn;//syn代表上升沿
reg   [1:0]  state;    //状态机
reg   [3:0]  dly_cnt;
wire         syn;



//读空时钟是异步的时钟做同步的处理
assign  syn=~almost_full_syn&almost_full_d0;


always @(posedge clk or negedge rst_n) begin
//1.抓取almost_full上升沿
    if(!rst_n)begin
        almost_full_d0 <= 1'b0;
        almost_full_syn <= 1'b0;
        
    end
    else begin
        almost_full_d0 <= almost_full;
        almost_full_syn <= almost_full_d0;
    end
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        fifo_rd_en <= 1'b0;
//        fifo_rd_data <= 8'd0;
        state <= 2'b0;
        dly_cnt<=4'b0;  //复位做延时
    end
    else begin
        case (state)
            2'd0:begin //状态1，当发现syn有上升沿信号，跳到下一个状态进行延时
                if(syn) begin
                    state <=2'd1; 
                end
                else
                    state <= state;end
            2'd1:begin //状态2：延时10个时钟，跳到下一个状态
                if(dly_cnt == 4'd10) begin
                    dly_cnt <= 4'd0;
                    state <= 2'd2;
                end
                else
                    dly_cnt <= dly_cnt + 1'd1;
                end
            2'd2:begin
                if (almost_empty) begin //因为它是写时钟，在同一个时钟下的，取上升沿不用做异步处理
                    fifo_rd_en <= 1'd0; //将要读空了，关闭读使能
                    state <= 2'd0;
                end
                else
                    fifo_rd_en <= 1'd1; //保持不关断    
                end
                default: 
                    state <= 2'd0;
        endcase
    end
end

endmodule
