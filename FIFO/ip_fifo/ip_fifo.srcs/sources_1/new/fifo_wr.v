`timescale 1ns / 1ps


module fifo_wr(
    input               clk,
    input               rst_n,

    input               almost_empty,
    input               almost_full,

    output reg          fifo_wr_en,
    output reg  [7:0]   fifo_wr_data
    );

reg          almost_empty_d0;
reg          almost_empty_syn;//syn代表上升沿
reg   [1:0]  state;    //状态机
reg   [3:0]  dly_cnt;
wire         syn;



//异步的时钟做同步的处理
assign  syn=~almost_empty_syn&almost_empty_d0;


always @(posedge clk or negedge rst_n) begin
//1.抓取almost_empty上升沿
    if(!rst_n)begin
        almost_empty_d0 <= 1'b0;
        almost_empty_syn <= 1'b0;
        
    end
    else begin
        almost_empty_d0 <= almost_empty;
        almost_empty_syn <= almost_empty_d0;
    end
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        fifo_wr_en <= 1'b0;
        fifo_wr_data <= 8'd0;
        state <= 2'b0;
        dly_cnt<=4'b0;  //复位做延时
    end
    else begin
        case (state)
            2'd0:begin //状态1，当发现syn有信号，跳到下一个状态进行延时
                if(syn) begin
                    state <=2'b1; 
                end
                else
                    state <= state；end
            2'd1:begin
                if(dly_cnt == 4'd10) begin
                    dly_cnt <= 4'b0;
                    state <= 2'd2;
                    fifo_wr_en <= 1'b1;
                end
                end
            end
            default: 
        endcase
end



endmodule
