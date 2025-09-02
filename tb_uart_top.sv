`timescale 1ns/1ps

module tb_uart_top;
  
  logic clk,rst;
  logic uart_rx_pin,uart_tx_pin;
  
  uart_top dut (
    .clk(clk),
    .rst(rst),
    .uart_rx_pin(uart_rx_pin),
    .uart_tx_pin(uart_tx_pin)
  );
  
  always #4 clk = ~clk; //8ns period


  class uart_transaction;
    rand byte data;


    constraint valid_range {
      data inside {[8'h01:8'hFE]};  
    }
  endclass
  

  task send_byte(input byte data);
    int i;
    
    uart_rx_pin = 0; //start
    
    for(i=0;i<8;i++) begin
      uart_rx_pin = data[i];
      #(8680);
    end
    
    uart_rx_pin =1; //stop
    #(8680);
  endtask
  

  task automatic capture_byte(output byte data);
    int i;
    
    @(negedge uart_tx_pin); // wait for start bit
    #(8680/2);  //sample mid bit
    
    for(i=0;i<8;i++) begin
      #(8680);
      data[i] = uart_tx_pin;
    end
    
    #(8680); //ignore stop bit
  endtask
  

  initial begin
    clk = 0;
    uart_rx_pin = 1; //idle
    rst =1;
    
    repeat(5) @(posedge clk);
    rst = 0;
    
    uart_transaction tr = new();
    byte sent , received;

    // Run multiple randomized tests
    repeat(10) begin
      if (!tr.randomize())
        $fatal("Randomization failed!");
      
      sent = tr.data;
      
      fork
        send_byte(sent);
        capture_byte(received);
      join
      
      if (sent !== received)
        $error("Test failed: Sent %0h, Received %0h", sent, received);
      else
        $display("PASS: Sent %0h, Received %0h", sent, received);

      #1000;
    end

    $finish;
  end
 
endmodule  
