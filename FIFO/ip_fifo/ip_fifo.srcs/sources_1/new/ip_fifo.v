`timescale 1ns / 1ps


//¶¥²ã


module ip_fifo(

    );



fifo_generator_0 fifo_generator_0_u (
  .wr_clk(wr_clk),                // input wire wr_clk
  .rd_clk(rd_clk),                // input wire rd_clk
  .din(din),                      // input wire [7 : 0] din
  .wr_en(wr_en),                  // input wire wr_en
  .rd_en(rd_en),                  // input wire rd_en
  .dout(dout),                    // output wire [7 : 0] dout
  .full(full),                    // output wire full
  .almost_full(almost_full),      // output wire almost_full
  .empty(empty),                  // output wire empty
  .almost_empty(almost_empty),    // output wire almost_empty
  .rd_data_count(rd_data_count),  // output wire [7 : 0] rd_data_count
  .wr_data_count(wr_data_count)  // output wire [7 : 0] wr_data_count
);


endmodule
