module registro_corrimiento (clk, rst, load, shift, in, Q);
    
    input         clk;
    input         rst;
    input         load;
    input         shift;

    input      [7:0]   in;
    output reg [7:0]   Q;
   

    always @(posedge clk) begin
        if (rst)
            Q <= 8'b00000000;
        else if (load)
            Q <= in;
        else if (shift)
            Q <= Q >> 1;
        else
            Q <= Q;
        end

endmodule
