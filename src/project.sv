`default_nettype none

module project (
    input  wire  clk_i,
    input  wire  rst_ni,

    input  wire  en_i,

    input  wire  uart_rx_i,
    output wire  uart_tx_o,
);

  wire       data_valid;
  wire [7:0] data;

  uart #(
    .CLKS_PER_BIT ( 16 ) // TODO
  ) u_uart (
    .clk_i           ( clk_i      ),
    .rst_ni          ( rst_ni     ),
  
    .en_i            ( en_i       ),
  
    .rx_data_valid_o ( data_valid ),
    .rx_data_o       ( data       ),
  
    .tx_data_ready_o ( /* nc */   ),
    .tx_data_valid_i ( data_valid ),
    .tx_data_i       ( data       ),
  
    .rx_i            ( uart_rx_i  ),
    .tx_o            ( uart_tx_o  )
  );

endmodule
