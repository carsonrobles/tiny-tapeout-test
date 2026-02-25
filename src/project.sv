/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  wire       data_valid;
  wire [7:0] data;

  uart #(
    .CLKS_PER_BIT ( 16 ) // TODO
  ) u_uart (
    .clk_i           ( clk   ),
    .rst_ni          ( rst_n ),
  
    .en_i            ( 1'b1  ),
  
    .rx_data_valid_o ( data_valid ),
    .rx_data_o       ( data       ),
  
    .tx_data_ready_o ( /* nc */   ),
    .tx_data_valid_i ( data_valid ),
    .tx_data_i       ( data       ),
  
    .rx_i            ( ui_in[0]   ),
    .tx_o            ( uo_out[0]  )
  );

  logic [14:0] cnt;

  always_ff @(posedge clk) begin
    if (~rst_n)
      cnt <= '0;
    else if (ena)
      cnt <= cnt + 1;
  end

  assign uio_oe = '1;
  assign {uio_out, uo_out[7:1]} = cnt;

  wire _unused = &{1'b0, ui_in[7:1]};

endmodule
