

// 
// Module: tb
// 
// Notes:
// - Top level simulation testbench.
//

//`timescale 1ns/1ns
//`define WAVES_FILE "./work/waves-rx.vcd"

module tb();
    
reg        clk          ; // Top level system clock input.
reg rst;
reg neg_clk; 
reg neg_rst ; 
reg        resetn       ;
reg        uart_rxd     ; // UART Recieve pin.

reg        uart_rx_en   ; // Recieve enable
//wire [8:0] res;
wire       uart_rx_break; // Did we get a BREAK message?
wire       uart_rx_valid; // Valid data recieved and available.
wire [7:0] uart_rx_data ; // The recieved data.
wire [31:0] inst ; 
wire [31:0] inst_mem ; 

reg rst_pin ; 
wire write_done ; 


// Bit rate of the UART line we are testing.
localparam BIT_RATE = 9600;
localparam BIT_P    = (1000000000/BIT_RATE);


// Period and frequency of the system clock.
localparam CLK_HZ   = 50000000;
localparam CLK_P    = 1000000000/ CLK_HZ;

reg slow_clk = 0;


// Make the clock tick.
always begin #(CLK_P/2) clk  = ~clk; end   
always begin #(CLK_P/2) neg_clk  = ~neg_clk; end     
always begin #(CLK_P*2) slow_clk <= !slow_clk;end



task write_instruction;
    input [31:0] instruction;
    begin
            @(posedge clk);
            send_byte(instruction[7:0]);
            check_byte(instruction[7:0]);
            @(posedge clk);
            send_byte(instruction[15:8]);
            check_byte(instruction[15:8]);
            
            @(posedge clk);
            send_byte(instruction[23:16]);
            check_byte(instruction[23:16]);
            
            @(posedge clk);
            send_byte(instruction[31:24]);
            check_byte(instruction[31:24]);
    end
    endtask

task send_byte;
    input [7:0] to_send;
    integer i;
    begin


        #BIT_P;  uart_rxd = 1'b0;
        for(i=0; i < 8; i = i+1) begin
            #BIT_P;  uart_rxd = to_send[i];
        end
        #BIT_P;  uart_rxd = 1'b1;
        #1000;
    end
endtask


// Checks that the output of the UART is the value we expect.
integer passes = 0;
integer fails  = 0;
task check_byte;
    input [7:0] expected_value;
    begin
        if(uart_rx_data == expected_value) begin
            passes = passes + 1;
            $display("%d/%d/%d [PASS] Expected %b and got %b", 
                     passes,fails,passes+fails,
                     expected_value, uart_rx_data);
        end else begin
            fails  = fails  + 1;
            $display("%d/%d/%d [FAIL] Expected %b and got %b", 
                     passes,fails,passes+fails,
                     expected_value, uart_rx_data);
        end
    end
endtask


initial 
begin 
    $dumpfile("waveform.vcd");
    $dumpvars(0,tb);
end 

reg [3:1] Sensors; 
wire Motor1A,Motor1B,Motor2A,Motor2B; 
wire [2:0] pc ; 


reg [7:0] to_send;
initial begin
    rst=1;
    rst_pin=1; 
    neg_rst = 1; 
    resetn  = 1'b0;
    clk     = 1'b0;
    neg_clk = 1; 
    neg_rst = ~clk ;
    uart_rxd = 1'b1;
    neg_clk = 1'b1; 
    Sensors = 3'b010;
    #4000
    
 Sensors = 3'b001;
    #4000
     Sensors = 3'b010;
    #4000
    Sensors = 3'b011;
    #4000  
  resetn = 1'b1;
    rst=0;
    neg_rst = 0; 
    rst_pin = 0 ; 

    Sensors = 3'b100;
    #4000
    Sensors = 3'b101;
    #4000
    Sensors = 3'b110;
    #4000
    Sensors = 3'b111;
    #4000 
  

    uart_rx_en = 1'b1;
   @(posedge slow_clk);write_instruction(32'h00000000); 
    @(posedge slow_clk);write_instruction(32'h00000000); 
    @(posedge slow_clk);write_instruction(32'hff010113); 
    @(posedge slow_clk);write_instruction(32'h00112623); 
    @(posedge slow_clk);write_instruction(32'h00812423); 
    @(posedge slow_clk);write_instruction(32'h01010413); 
    @(posedge slow_clk);write_instruction(32'h80818613); 
    @(posedge slow_clk);write_instruction(32'h000117b7); 
    @(posedge slow_clk);write_instruction(32'h33078593); 
    @(posedge slow_clk);write_instruction(32'h000117b7); 
    @(posedge slow_clk);write_instruction(32'h32c78513); 
    @(posedge slow_clk);write_instruction(32'h098000ef); 
    @(posedge slow_clk);write_instruction(32'h000117b7); 
    @(posedge slow_clk);write_instruction(32'h32c7a783); 
    @(posedge slow_clk);write_instruction(32'h0807c263); 
    @(posedge slow_clk);write_instruction(32'h000117b7); 
    @(posedge slow_clk);write_instruction(32'h32c7a703); 
    @(posedge slow_clk);write_instruction(32'h00100793); 
    @(posedge slow_clk);write_instruction(32'h06e7ca63); 
    @(posedge slow_clk);write_instruction(32'h000117b7); 
    @(posedge slow_clk);write_instruction(32'h3307a783); 
    @(posedge slow_clk);write_instruction(32'h0607c463); 
    @(posedge slow_clk);write_instruction(32'h000117b7); 
    @(posedge slow_clk);write_instruction(32'h3307a703); 
    @(posedge slow_clk);write_instruction(32'h00100793); 
    @(posedge slow_clk);write_instruction(32'h04e7cc63); 
    @(posedge slow_clk);write_instruction(32'h8081a783); 
    @(posedge slow_clk);write_instruction(32'h0407c863); 
    @(posedge slow_clk);write_instruction(32'h8081a703); 
    @(posedge slow_clk);write_instruction(32'h00100793); 
    @(posedge slow_clk);write_instruction(32'h04e7c263); 
    @(posedge slow_clk);write_instruction(32'h8081a783); 
    @(posedge slow_clk);write_instruction(32'h00079663); 
    @(posedge slow_clk);write_instruction(32'h104000ef); 
    @(posedge slow_clk);write_instruction(32'hf91ff06f); 
    @(posedge slow_clk);write_instruction(32'h000117b7); 
    @(posedge slow_clk);write_instruction(32'h3307a783); 
    @(posedge slow_clk);write_instruction(32'h00079663); 
    @(posedge slow_clk);write_instruction(32'h09c000ef); 
    @(posedge slow_clk);write_instruction(32'hf7dff06f); 
    @(posedge slow_clk);write_instruction(32'h000117b7); 
    @(posedge slow_clk);write_instruction(32'h32c7a783); 
    @(posedge slow_clk);write_instruction(32'h00079663); 
    @(posedge slow_clk);write_instruction(32'h130000ef); 
    @(posedge slow_clk);write_instruction(32'hf69ff06f); 
    @(posedge slow_clk);write_instruction(32'h178000ef); 
    @(posedge slow_clk);write_instruction(32'hf61ff06f); 
    @(posedge slow_clk);write_instruction(32'h00000013); 
    @(posedge slow_clk);write_instruction(32'hf59ff06f); 
    @(posedge slow_clk);write_instruction(32'hfe010113); 
    @(posedge slow_clk);write_instruction(32'h00812e23); 
    @(posedge slow_clk);write_instruction(32'h02010413); 
    @(posedge slow_clk);write_instruction(32'hfea42623); 
    @(posedge slow_clk);write_instruction(32'hfeb42423); 
    @(posedge slow_clk);write_instruction(32'hfec42223); 
    @(posedge slow_clk);write_instruction(32'hcc800f13); 
    @(posedge slow_clk);write_instruction(32'h00007633); 
    @(posedge slow_clk);write_instruction(32'h000076b3); 
    @(posedge slow_clk);write_instruction(32'h00007733); 
    @(posedge slow_clk);write_instruction(32'h001f7f13); 
    @(posedge slow_clk);write_instruction(32'h01e66633); 
    @(posedge slow_clk);write_instruction(32'h001f5f13); 
    @(posedge slow_clk);write_instruction(32'h001f7f13); 
    @(posedge slow_clk);write_instruction(32'h01e6e6b3); 
    @(posedge slow_clk);write_instruction(32'h001f5f13); 
    @(posedge slow_clk);write_instruction(32'h001f7f13); 
    @(posedge slow_clk);write_instruction(32'h01e76733); 
    @(posedge slow_clk);write_instruction(32'hfec42783); 
    @(posedge slow_clk);write_instruction(32'h00c7a023); 
    @(posedge slow_clk);write_instruction(32'hfe842783); 
    @(posedge slow_clk);write_instruction(32'h00d7a023); 
    @(posedge slow_clk);write_instruction(32'hfe442783); 
    @(posedge slow_clk);write_instruction(32'h00e7a023); 
    @(posedge slow_clk);write_instruction(32'h00000013); 
    @(posedge slow_clk);write_instruction(32'h01c12403); 
    @(posedge slow_clk);write_instruction(32'h02010113); 
    @(posedge slow_clk);write_instruction(32'h00008067); 
    @(posedge slow_clk);write_instruction(32'hff010113); 
    @(posedge slow_clk);write_instruction(32'h00112623); 
    @(posedge slow_clk);write_instruction(32'h00812423); 
    @(posedge slow_clk);write_instruction(32'h01010413); 
    @(posedge slow_clk);write_instruction(32'hcc800f13); 
    @(posedge slow_clk);write_instruction(32'h01e075b3); 
    @(posedge slow_clk);write_instruction(32'h0105e593); 
    @(posedge slow_clk);write_instruction(32'h00000613); 
    @(posedge slow_clk);write_instruction(32'h00000693); 
    @(posedge slow_clk);write_instruction(32'h200f6713); 
    @(posedge slow_clk);write_instruction(32'h80b1a623); 
    @(posedge slow_clk);write_instruction(32'h80c1a823); 
    @(posedge slow_clk);write_instruction(32'h80d1aa23); 
    @(posedge slow_clk);write_instruction(32'h80e1ac23); 
    @(posedge slow_clk);write_instruction(32'h57800513); 
    @(posedge slow_clk);write_instruction(32'h110000ef); 
    @(posedge slow_clk);write_instruction(32'h00000013); 
    @(posedge slow_clk);write_instruction(32'h00c12083); 
    @(posedge slow_clk);write_instruction(32'h00812403); 
    @(posedge slow_clk);write_instruction(32'h01010113); 
    @(posedge slow_clk);write_instruction(32'h00008067); 
    @(posedge slow_clk);write_instruction(32'hff010113); 
    @(posedge slow_clk);write_instruction(32'h00112623); 
    @(posedge slow_clk);write_instruction(32'h00812423); 
    @(posedge slow_clk);write_instruction(32'h01010413); 
    @(posedge slow_clk);write_instruction(32'hcc800f13); 
    @(posedge slow_clk);write_instruction(32'h01e075b3); 
    @(posedge slow_clk);write_instruction(32'h0105e593); 
    @(posedge slow_clk);write_instruction(32'h00000613); 
    @(posedge slow_clk);write_instruction(32'h100f6693); 
    @(posedge slow_clk);write_instruction(32'h00000713); 
    @(posedge slow_clk);write_instruction(32'h80b1a623); 
    @(posedge slow_clk);write_instruction(32'h80c1a823); 
    @(posedge slow_clk);write_instruction(32'h80d1aa23); 
    @(posedge slow_clk);write_instruction(32'h80e1ac23); 
    @(posedge slow_clk);write_instruction(32'h2bc00513); 
    @(posedge slow_clk);write_instruction(32'h0bc000ef); 
    @(posedge slow_clk);write_instruction(32'h00000013); 
    @(posedge slow_clk);write_instruction(32'h00c12083); 
    @(posedge slow_clk);write_instruction(32'h00812403); 
    @(posedge slow_clk);write_instruction(32'h01010113); 
    @(posedge slow_clk);write_instruction(32'h00008067); 
    @(posedge slow_clk);write_instruction(32'hff010113); 
    @(posedge slow_clk);write_instruction(32'h00112623); 
    @(posedge slow_clk);write_instruction(32'h00812423); 
    @(posedge slow_clk);write_instruction(32'h01010413); 
    @(posedge slow_clk);write_instruction(32'hcc800f13); 
    @(posedge slow_clk);write_instruction(32'h00000593); 
    @(posedge slow_clk);write_instruction(32'h020f6613); 
    @(posedge slow_clk);write_instruction(32'h00000693); 
    @(posedge slow_clk);write_instruction(32'h200f6713); 
    @(posedge slow_clk);write_instruction(32'h80b1a623); 
    @(posedge slow_clk);write_instruction(32'h80c1a823); 
    @(posedge slow_clk);write_instruction(32'h80d1aa23); 
    @(posedge slow_clk);write_instruction(32'h80e1ac23); 
    @(posedge slow_clk);write_instruction(32'h2bc00513); 
    @(posedge slow_clk);write_instruction(32'h06c000ef); 
    @(posedge slow_clk);write_instruction(32'h00000013); 
    @(posedge slow_clk);write_instruction(32'h00c12083); 
    @(posedge slow_clk);write_instruction(32'h00812403); 
    @(posedge slow_clk);write_instruction(32'h01010113); 
    @(posedge slow_clk);write_instruction(32'h00008067); 
    @(posedge slow_clk);write_instruction(32'hff010113); 
    @(posedge slow_clk);write_instruction(32'h00112623); 
    @(posedge slow_clk);write_instruction(32'h00812423); 
    @(posedge slow_clk);write_instruction(32'h01010413); 
    @(posedge slow_clk);write_instruction(32'hcc800f13); 
    @(posedge slow_clk);write_instruction(32'h01e075b3); 
    @(posedge slow_clk);write_instruction(32'h0105e593); 
    @(posedge slow_clk);write_instruction(32'h00000613); 
    @(posedge slow_clk);write_instruction(32'h100f6693); 
    @(posedge slow_clk);write_instruction(32'h00000713); 
    @(posedge slow_clk);write_instruction(32'h80b1a623); 
    @(posedge slow_clk);write_instruction(32'h80c1a823); 
    @(posedge slow_clk);write_instruction(32'h80d1aa23); 
    @(posedge slow_clk);write_instruction(32'h80e1ac23); 
    @(posedge slow_clk);write_instruction(32'h57800513); 
    @(posedge slow_clk);write_instruction(32'h018000ef); 
    @(posedge slow_clk);write_instruction(32'h00000013); 
    @(posedge slow_clk);write_instruction(32'h00c12083); 
    @(posedge slow_clk);write_instruction(32'h00812403); 
    @(posedge slow_clk);write_instruction(32'h01010113); 
    @(posedge slow_clk);write_instruction(32'h00008067); 
    @(posedge slow_clk);write_instruction(32'hfd010113); 
    @(posedge slow_clk);write_instruction(32'h02812623); 
    @(posedge slow_clk);write_instruction(32'h03010413); 
    @(posedge slow_clk);write_instruction(32'hfca42e23); 
    @(posedge slow_clk);write_instruction(32'hfe042623); 
    @(posedge slow_clk);write_instruction(32'h0100006f); 
    @(posedge slow_clk);write_instruction(32'hfec42783); 
    @(posedge slow_clk);write_instruction(32'h00178793); 
    @(posedge slow_clk);write_instruction(32'hfef42623); 
    @(posedge slow_clk);write_instruction(32'hfec42703); 
    @(posedge slow_clk);write_instruction(32'hfdc42783); 
    @(posedge slow_clk);write_instruction(32'hfef746e3); 
    @(posedge slow_clk);write_instruction(32'h00000013); 
    @(posedge slow_clk);write_instruction(32'h02c12403); 
    @(posedge slow_clk);write_instruction(32'h03010113); 
    @(posedge slow_clk);write_instruction(32'h00008067); 
    @(posedge slow_clk);write_instruction(32'hffffffff); 
    @(posedge slow_clk);write_instruction(32'hffffffff); 
     $display("Test Results:");
     $display("    PASSES: %d", passes);
     $display("    FAILS : %d", fails);
    #100000
    $display("Finish simulation at time %d", $time);
    $finish;
end

 wrapper dut (
.clk        (clk          ), // Top level system clock input.
.resetn       (resetn       ), // Asynchronous active low reset.
.uart_rxd     (uart_rxd     ), // UART Recieve pin.
.uart_rx_en   (uart_rx_en   ), // Recieve enable
.uart_rx_break(uart_rx_break), // Did we get a BREAK message?
.uart_rx_valid(uart_rx_valid), // Valid data recieved and available.
.uart_rx_data (uart_rx_data ), 
.Sensors(Sensors), 
.Motor1A(Motor1A), 
.Motor2A(Motor2A),
.Motor1B(Motor1B),
.Motor2B(Motor2B),
.write_done(write_done)
); 



endmodule
