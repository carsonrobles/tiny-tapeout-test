`default_nettype none

module project (
    input  wire  clk_i,
    input  wire  rst_ni,

    input  wire  en_i,

    input  wire  uart_rx_i,
    output wire  uart_tx_o,
);

  wire uart_rx;

  sync u_uart_rx_sync (
    .clk_i   ( clk_i     ),
    .async_i ( uart_rx_i ),
    .sync_o  ( uart_rx   )
  );

  wire       data_valid;
  wire [7:0] data;

  uart #(
    // 66MHz / 9600baud = 6875
    .CLKS_PER_BIT ( 6875 )
  ) u_uart (
    .clk_i           ( clk_i      ),
    .rst_ni          ( rst_ni     ),
  
    .en_i            ( en_i       ),
  
    .rx_data_valid_o ( data_valid ),
    .rx_data_o       ( data       ),
  
    .tx_data_ready_o ( /* nc */   ),
    .tx_data_valid_i ( data_valid ),
    .tx_data_i       ( data       ),
  
    .rx_i            ( uart_rx    ),
    .tx_o            ( uart_tx_o  )
  );

endmodule
