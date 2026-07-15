`timescale 1ns / 1ps
`define SIMULATION

module acc_TB;

    reg        clk;
    reg [7:0]  A;
    reg        reset;
    reg        add;

    acc uut( .clk(clk), .A(A), .reset(reset), .add(add) );

    parameter PERIOD          = 20;
    parameter real DUTY_CYCLE = 0.5;
    parameter OFFSET          = 0;

    initial  begin  // Process for clk
        #OFFSET;
        forever
        begin
            clk = 1'b0;
            #(PERIOD-(PERIOD*DUTY_CYCLE)) clk = 1'b1;
            #(PERIOD*DUTY_CYCLE);
        end
    end

    initial begin
        #0 A = 250; reset = 0; add = 0;
        @ (negedge clk);
        reset  = 1;
        @ (negedge clk);
        reset  = 0;

        repeat(23) begin
            @(negedge clk);
            add = 1;
            @(negedge clk);
            add = 0;
        end
    end

    initial begin: TEST_CASE
        $dumpfile("acc_TB.vcd");
        $dumpvars(-1, uut);
        #(10000) $finish;
    end

endmodule