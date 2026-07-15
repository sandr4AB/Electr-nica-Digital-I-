`timescale 1ns / 1ps
`define SIMULATION

module regb_TB;

    reg        clk;
    reg [7:0] in_B;
    reg        load;
    reg        shift;

    regb uut( .clk(clk), .in_B(in_B), .load(load), .shift(shift) );

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
        #0 in_B = 250; load = 0; shift = 0;
        @ (negedge clk);
        load  = 1;
        @ (negedge clk);
        load  = 0;

        repeat(23) begin
            @(negedge clk);
            shift= 1;
            @(negedge clk);
            shift = 0;
        end
    end

    initial begin: TEST_CASE
        $dumpfile("regb_TB.vcd");
        $dumpvars(-1, uut);
        #(10000) $finish;
    end

endmodule