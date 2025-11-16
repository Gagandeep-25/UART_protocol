# UART Protocol Implementation

## Overview

This repository contains **Verilog implementations** of the UART (Universal Asynchronous Receiver/Transmitter) protocol. It includes both transmitter and receiver modules with complete functional verification.

## Features

- **Configurable Baud Rates:** Support for various serial communication speeds
- **Full-Duplex Communication:** Simultaneous transmit and receive
- **Standard UART Format:** Start bit, 8-bit data, stop bit, parity option
- **Error Detection:** Frame error detection
- **Synchronous Design:** Compatible with modern FPGA/ASIC flows
- **Testbenches:** Comprehensive verification suite

## UART Protocol Basics

- **Data Width:** 8 bits
- **Start Bit:** 1 bit (active low)
- **Stop Bit:** 1 bit (active high)
- **Parity:** Optional (even/odd)
- **Baud Rate:** Configurable (9600, 19200, 115200 bps, etc.)

## Implementation

### Transmitter
- Parallel-to-serial conversion
- Baud rate generator
- Start/stop bit insertion
- Status signals (busy, ready)

### Receiver
- Serial-to-parallel conversion
- Oversampling for clock recovery
- Frame error detection
- Data ready signal

## Modules

- `uart_tx`: Transmitter module
- `uart_rx`: Receiver module
- `uart_top`: Top-level module
- Testbenches for verification

## Getting Started

### Prerequisites
- Verilog simulator
- FPGA development board (optional)
- Understanding of UART protocol

### Simulation

```bash
vlog *.v
vsim work.uart_tb
run -all
```

## Verification

- Transmit/receive cycles
- Different baud rates
- Error conditions
- Edge cases

## Applications

- Serial communication
- Debug interfaces
- FPGA programming
- Embedded systems

## References

- UART Protocol Specifications
- Verilog HDL
- Microcontroller Datasheets

## License

MIT License

## Author

Gagandeep-25
