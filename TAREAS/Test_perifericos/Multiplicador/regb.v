module regb (clk, in_B, shift, load, s_B);
    input clk;
    input [7:0] in_B;
    input shift;
    input load;
    output reg [7:0] s_B;

always @(posedge clk)
  begin
    if(load)
      s_B <= in_B;

    else begin
        if (shift)
 //         s_B <= s_B >> 1 ;
          s_B <= {1'b0, s_B[7:1]};
    end
  end
endmodule

