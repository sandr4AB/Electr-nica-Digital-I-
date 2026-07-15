module acc (clk , A, add, reset, R);
 input clk;
 input [31:0] A;
 input add;
 input reset;
 output reg [31:0] R;
initial R = 0;
always @(posedge clk)
 if (reset)
 R = 32'h00000000;
 else
 begin
 if (add) R = R + A;
 else R = R;
 end
endmodule




