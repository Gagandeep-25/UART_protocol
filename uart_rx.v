// UART Receiver
module uart_rx (
    input  wire clk,
    input  wire rst,
    input  wire rx,
    input  wire tick,
    output reg  [7:0] rx_data,
    output reg  rx_done
);

    reg [3:0] bit_index = 0;
    reg [7:0] rx_shift = 0;
    reg       rx_busy = 0;
    reg [3:0] tick_count = 0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            rx_data <= 0;
            rx_done <= 0;
            rx_busy <= 0;
            bit_index <= 0;
            tick_count <= 0;
        end else begin
            rx_done <= 0;

            // detect start bit
            if (!rx_busy && !rx) begin
                rx_busy <= 1;
                tick_count <= 0;
                bit_index <= 0;
            end else if (rx_busy && tick) begin
                tick_count <= tick_count + 1;

                if (tick_count == 1) begin
                    // skip start bit
                end else if (tick_count >= 2 && tick_count <= 9) begin
                    rx_shift[bit_index] <= rx;
                    bit_index <= bit_index + 1;
                end else if (tick_count == 10) begin
                    rx_data <= rx_shift;
                    rx_done <= 1;
                    rx_busy <= 0;
                end
            end
        end
    end
endmodule
