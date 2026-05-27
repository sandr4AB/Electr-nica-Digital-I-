module rega (clk, in_A, shift, load, s_A);
      input clk;
      input [7:0] in_A;
      input shift;
      input load;
      output reg [15:0] s_A;

always @(posedge clk)
  begin
   if (load)
    s_A<=in_A;

   else begin
     if (shift)
//    s_A <= s_A << 1;
      s_A <= {s_A[14:0],1'b0};
     end
  end
endmodule


