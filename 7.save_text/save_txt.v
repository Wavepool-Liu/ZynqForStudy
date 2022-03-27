`timescale 1ns / 1ps


module save_txt(
    input clk,
    input rst_n,
    output [31:0] dout
    );
reg [31:0] dout_reg;

assign dout = dout_reg;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        dout_reg <= 32'b0;
    end
    else if (dout_reg == 32'hffffffff)
        dout_reg <= 32'd0;
    else begin
        dout_reg <= (dout_reg+1'b1) & 32'hffffffff;
    end
    
end
    

endmodule
