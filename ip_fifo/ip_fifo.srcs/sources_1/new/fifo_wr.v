`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/24 18:20:18
// Design Name: 
// Module Name: fifo_wr
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


module fifo_wr(
    input               clk         ,
    input               rst_n       ,
    
    input               almost_empty,
    input               almost_full ,

    output reg          fifo_wr_en  ,
    output reg  [7:0]   fifo_wr_data
    
    );
    
reg          almost_empty_d0;
reg          almost_empty_syn;//syn代表上升沿
reg   [1:0]  state;    //状态机
reg   [3:0]  dly_cnt;
wire         syn;

//读空时钟是异步的时钟做同步的处理
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
            2'd0:begin //状态1，当发现syn有上升沿信号，跳到下一个状态进行延时
                if(syn) begin
                    state <=2'b1; 
                end
                else
                    state <= state; end
            2'd1:begin //状态2：延时4个时钟，跳到下一个状态
                if(dly_cnt == 4'd10) begin
                    dly_cnt <= 4'b0;
                    state <= 2'd2;
                    fifo_wr_en <= 1'b1;
                end
                else
                    dly_cnt <= dly_cnt + 1'b1;
                end
            2'd2:begin
                if (almost_full) begin //因为它是写时钟，在同一个时钟下的，取上升沿不用做异步处理
                    fifo_wr_en <= 1'd0;
                    fifo_wr_data <= 8'd0;
                end
                else begin
                    fifo_wr_en <= 1'd1; //保持不关断
                    fifo_wr_data <= fifo_wr_data + 1'd1;
                end    
                end
                default: 
                    state <= 2'd0;
        endcase
    end
end



    
    
endmodule
