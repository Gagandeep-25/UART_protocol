## PYNQ UART Constraints

# Clock (125 MHz)
set_property PACKAGE_PIN E3 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

# Reset Button
set_property PACKAGE_PIN C2 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]

# UART RX (from USB-UART bridge)
set_property PACKAGE_PIN J17 [get_ports uart_rx_pin]
set_property IOSTANDARD LVCMOS33 [get_ports uart_rx_pin]

# UART TX (to USB-UART bridge)
set_property PACKAGE_PIN J18 [get_ports uart_tx_pin]
set_property IOSTANDARD LVCMOS33 [get_ports uart_tx_pin]
