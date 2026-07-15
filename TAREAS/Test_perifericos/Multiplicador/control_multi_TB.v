`timescale 1ns / 1ps
`define SIMULATION
module control_multi_TB;
 reg clk;
 reg reset;
 reg start;
 reg C;
 reg [7:0]in_A;
 reg [7:0]in_B;
 wire [15:0] R;
 reg lsb_B;
 wire done;
 control_multi uut (.clk(clk), .reset(reset), .init(start), .lsb_B(lsb_B), .C(C)); 
 parameter PERIOD = 20;
 parameter real DUTY_CYCLE = 0.5;
 parameter OFFSET = 0;
 reg [20:0] i;
event reset_trigger;
event reset_done_trigger;
initial begin
 forever begin
 @ (reset_trigger);
@ (negedge clk);
reset = 1;
@ (negedge clk);
reset = 0;
-> reset_done_trigger;
end
end
 initial begin // Initialize Inputs
 clk = 0; reset = 1; start = 0; lsb_B = 0; C = 0;
 end
 initial begin // Process for clk
 #OFFSET;
 forever
 begin
 clk = 1'b0;
 #(PERIOD-(PERIOD*DUTY_CYCLE)) clk = 1'b1;
 #(PERIOD*DUTY_CYCLE);
 end
 end
 initial begin // Reset the system, Start the image capture process
 #10 -> reset_trigger;
 @ (reset_done_trigger);
 @ (posedge clk);
 start = 0;
 @ (posedge clk);
 start = 1;
 for(i=0; i<2; i=i+1) begin
 @ (posedge clk);
 end
lsb_B = 1;

 for(i=0; i<2; i=i+1) begin
 @ (posedge clk);
 end
 lsb_B = 0;


 for(i=0; i<17; i=i+1) begin
 @ (posedge clk);
 end

C = 1;
 end
 initial begin: TEST_CASE
 $dumpfile("control_multi_TB.vcd");
 $dumpvars(-1, uut);
 #((PERIOD*DUTY_CYCLE)*120) $finish;
 end
endmodule