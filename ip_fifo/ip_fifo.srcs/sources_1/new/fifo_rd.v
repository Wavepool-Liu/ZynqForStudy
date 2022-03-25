`timescale 1ns / 1ps


module fifo_rd(
    input               clk,
    input               rst_n,

    input               almost_empty,
    input               almost_full,

    output reg          fifo_rd_en
//    input  [7:0]        fifo_rd_data //��Ϊ�����������ߵ��Ե���˶����ݣ����Կ��Բ�Ҫ��
);

reg          almost_full_d0;
reg          almost_full_syn;//syn����������
reg   [1:0]  state;    //״̬��
reg   [3:0]  dly_cnt;
wire         syn;



//����ʱ�����첽��ʱ����ͬ���Ĵ���
assign  syn=~almost_full_syn&almost_full_d0;


always @(posedge clk or negedge rst_n) begin
//1.ץȡalmost_full������
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
        dly_cnt<=4'b0;  //��λ����ʱ
    end
    else begin
        case (state)
            2'd0:begin //״̬1��������syn���������źţ�������һ��״̬������ʱ
                if(syn) begin
                    state <=2'd1; 
                end
                else
                    state <= state;end
            2'd1:begin //״̬2����ʱ10��ʱ�ӣ�������һ��״̬
                if(dly_cnt == 4'd10) begin
                    dly_cnt <= 4'd0;
                    state <= 2'd2;
                end
                else
                    dly_cnt <= dly_cnt + 1'd1;
                end
            2'd2:begin
                if (almost_empty) begin //��Ϊ����дʱ�ӣ���ͬһ��ʱ���µģ�ȡ�����ز������첽����
                    fifo_rd_en <= 1'd0; //��Ҫ�����ˣ��رն�ʹ��
                    state <= 2'd0;
                end
                else
                    fifo_rd_en <= 1'd1; //���ֲ��ض�    
                end
                default: 
                    state <= 2'd0;
        endcase
    end
end

endmodule
