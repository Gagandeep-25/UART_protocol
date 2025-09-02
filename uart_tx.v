// UART Transmitter
module uart_tx (
    input  wire clk,
    input  wire rst,
    input  wire tx_start,
    input  wire [7:0] tx_data,
    input  wire tick,
    output reg  tx,
    output reg  tx_busy
);

    reg [3:0] bit_index = 0;
    reg [9:0] tx_shift = 10'b1111111111;  // shift register (start + data + stop)

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tx <= 1'b1;          // idle state
            tx_busy <= 0;
            bit_index <= 0;
        end else begin
            if (tx_start && !tx_busy) begin
                // load frame: {stop, data, start}
                tx_shift <= {1'b1, tx_data, 1'b0};
                tx_busy <= 1;
                bit_index <= 0;
            end else if (tx_busy && tick) begin
                tx <= tx_shift[bit_index];
                bit_index <= bit_index + 1;
                if (bit_index == 9) begin
                    tx_busy <= 0;
                    tx <= 1;    // back to idle
                end
            end
        end
    end
endmodule
