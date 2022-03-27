`timescale 1ns / 1ps


module tb_save_txt(
    );

reg             clk  ;
reg             rst_n;
wire    [31:0]  dout ;   
integer save_file;

initial begin
    clk <= 1'b0;
    rst_n <= 1'b0;
    #40 rst_n <= 1'b1;
end


initial begin
    save_file = $fopen("E:/ZYNQ-Source/7.save_text/test.txt");    //�����������ļ������Ҳ������ļ�������Զ��������ļ���
    if(save_file == 0)begin 
        $display ("can not open the file!");    //��������ļ�ʧ�ܣ������ʾ"can not open the file!"��Ϣ��
        $stop;
    end
end

always #10 clk <= ~clk;

always @(posedge clk) begin
//    $fdisplay(save_file,"%d",dout);
    if(dout != 32'd0 && dout < 32'd100)  
        $fdisplay(save_file,"%d",dout);    //��ʹ���ź�Ϊ��ʱ��ÿ��ʱ�ӵ������ص���ʱ������д�뵽��������.txt�ļ���
    else if(dout == 32'd100) begin
        $fclose(save_file);
    end
    else
        rst_n <= rst_n;
end


save_txt save_txt_u(
    .clk  (clk),
    .rst_n(rst_n),
    .dout (dout)
);



endmodule
