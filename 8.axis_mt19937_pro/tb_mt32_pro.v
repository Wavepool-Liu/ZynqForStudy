`timescale 1ns / 1ps


module tb_mt32_pro(
    );
    
reg             clk                 ;
reg             rst               ;
reg             seed_start          ;
reg  [31:0]     seed_val            ;
reg             output_axis_tready  ;
wire [31:0]     output_axis_tdata   ;
wire            output_axis_tvalid  ;
wire            busy                ;
reg   [15:0]    cnt                 ;
reg  [31:0]     temp                ;
integer save_file;

initial begin
    clk <= 1'b0;
    rst <= 1'b1;
    cnt<= 0;
    temp <= 1'b0;
    output_axis_tready <= 1'b1;
    seed_start <= 1'b1;
    seed_val   <= 32'd19650218 & 32'hffffffff;
    #40 rst <=1'b0;
    seed_start <= 1'b0;

end

initial begin
    save_file = $fopen("E:/ZYNQ-Source/2.axis_mt19937/tdata.txt");    //打开所创建的文件；若找不到该文件，则会自动创建该文件。
    if(save_file == 0)begin 
        $display ("can not open the file!");    //如果创建文件失败，则会显示"can not open the file!"信息。
        $stop;
    end
end


always #10 clk <= ~clk;

always @(posedge clk) begin
    if(output_axis_tvalid)begin
        if(cnt < 16'd10000) begin
            temp <= output_axis_tdata;
            cnt <= (cnt +1'd1);
        end
        else if(cnt == 16'd10000)
            output_axis_tready <= 1'b0;
        else 
            cnt <= cnt;
        end
    else begin
        temp <= temp;
        cnt <= cnt;
    end    
end



always @(posedge clk) begin
//    $fdisplay(save_file,"%d",dout);
    if(output_axis_tvalid == 1'd1  && cnt < 16'd10000)  
        $fdisplay(save_file,"%d",output_axis_tdata);    //在使能信号为高时，每当时钟的上升沿到来时将数据写入到所创建的.txt文件中
    else if(cnt == 16'd10000) begin
        $fclose(save_file);
    end
    else
        rst <= rst;
end




axis_mt19937_pro axis_mt19937_pro_u(
    .clk                     (clk)               ,
    .rst                     (rst)               ,
    .output_axis_tdata       (output_axis_tdata) ,  
    .output_axis_tvalid      (output_axis_tvalid), 
    .output_axis_tready      (output_axis_tready), 
    .busy                    (busy)              ,
    .seed_val                (seed_val)          ,
    .seed_start              (seed_start)
);

    
endmodule
