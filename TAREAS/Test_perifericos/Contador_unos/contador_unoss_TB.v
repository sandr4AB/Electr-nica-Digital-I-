`timescale 1ns / 1ps
`define SIMULATION

module contador_unoss_TB;

    reg         clk;
    reg         rst;
    reg         inc;
   
    wire [7:0]  Q;
   
    contador_unoss uut( .clk(clk) , .rst(rst) , .inc(inc) , .Q(Q) );

    parameter PERIOD          = 20;
    parameter real DUTY_CYCLE = 0.5;
    parameter OFFSET          = 0;

    initial  begin  // Process for clk
        #OFFSET;
        forever
        begin
            clk = 0;
            #(PERIOD-(PERIOD*DUTY_CYCLE)) 
            clk = 1;
            #(PERIOD*DUTY_CYCLE);
        end
    end

    initial begin
        #0 inc   = 0;
           rst   = 1;

        @ (negedge clk);
             rst   = 0;

        repeat(23) begin
            @(negedge clk);
             inc = 1;

            @(negedge clk);
             inc = 0;
        end
    end

    initial begin: TEST_CASE
        $dumpfile("contador_unoss_TB.vcd");
        $dumpvars(-1, uut);
        #(10000) $finish;
    end

endmodule