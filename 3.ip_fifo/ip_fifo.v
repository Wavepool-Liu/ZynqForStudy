`timescale 1ns / 1ps

module ip_fifo(
    input sys_clk,
    input sys_rst_n,
    output [7:0] dout
    );
    
wire        almost_empty;
wire        almost_full;
wire        fifo_wr_en;
wire  [7:0] fifo_wr_data;
wire        fifo_rd_en;
// wire  [7:0] fifo_rd_data;
wire  full;
wire  empty;
wire  [7:0] rd_data_count;
wire  [7:0] wr_data_count;
    
    
    

//Àý»¯Ä£¿é
fifo_wr fifo_wr_u(
 .clk          (sys_clk),           
 .rst_n        (sys_rst_n),               
 .almost_empty (almost_empty),  
 .almost_full  (almost_full),   
 .fifo_wr_en   (fifo_wr_en),    
 .fifo_wr_data (fifo_wr_data)  
);

fifo_rd fifo_rd_u(
.clk            (sys_clk),
.rst_n          (sys_rst_n),
.almost_empty   (almost_empty),
.almost_full    (almost_full),
.fifo_rd_en     (fifo_rd_en)
// .fifo_rd_data   (fifo_rd_data)
);





fifo_generator_0 fifo_generator_0_u (
  .wr_clk(sys_clk),                // input wire wr_clk
  .rd_clk(sys_clk),                // input wire rd_clk
  .din(fifo_wr_data),                      // input wire [7 : 0] din
  .wr_en(fifo_wr_en),                  // input wire wr_en
  .rd_en(fifo_rd_en),                  // input wire rd_en
  .dout(dout),                    // output wire [7 : 0] dout
  .full(full),                    // output wire full
  .almost_full(almost_full),      // output wire almost_full
  .empty(empty),                  // output wire empty
  .almost_empty(almost_empty),    // output wire almost_empty
  .rd_data_count(rd_data_count),  // output wire [7 : 0] rd_data_count
  .wr_data_count(wr_data_count)  // output wire [7 : 0] wr_data_count
);

endmodule