`timescale 1ns / 1ps
`define SIMULATION

module comp_TB;

 reg [10:0] B;
 reg [10:0] C;


    comp uut( .B(B), .C(C) );

    initial  begin
        #0 in1 = 20; in2 = 30;

        # 40 in1 = 30; in2 = 30;
        # 40 in1 = 50; in2 = 30;
        # 40 in1 = 20; in2 = 20;
        # 40 in1 = 29; in2 = 30;
    end

    initial begin: TEST_CASE
        $dumpfile("comp_TB.vcd");
        $dumpvars(-1, uut);
        #(100000) $finish;
    end

endmodule
