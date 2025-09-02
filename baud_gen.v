// Baud Rate Generator
module baud_gen #(
    parameter CLK_FREQ = 125_000_000,   // FPGA clock (Hz)
    parameter BAUD_RATE = 115200        // UART baud rate
)(
    input  wire clk,
    input  wire rst,
    output reg  tick
);

    localparam TICK_COUNT = CLK_FREQ / BAUD_RATE;
    reg [$clog2(TICK_COUNT):0] counter = 0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            tick <= 0;
        end else begin
            if (counter == TICK_COUNT - 1) begin
                counter <= 0;
                tick <= 1;
            end else begin
                counter <= counter + 1;
                tick <= 0;
            end
        end
    end
endmodule
