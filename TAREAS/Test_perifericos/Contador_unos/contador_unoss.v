module contador_unoss ( clk, rst, inc, Q );

    input       clk;
    input       rst;
    input       inc;

    output reg  Q;

  always @(posedge clk) begin

        if(rst)
            Q <= 4'd0;

        else if(inc)
            Q <= Q + 1'b1;

        else
            Q <= Q;
    
     end

endmodule