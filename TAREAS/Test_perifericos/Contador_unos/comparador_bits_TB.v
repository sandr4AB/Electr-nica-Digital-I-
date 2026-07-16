`timescale 1ns / 1ps
`define SIMULATION

module comparador_bits_TB;

      reg  B;
      wire z;

    comparador_bits uut( .B(B), .z(z));
    
    initial begin

        B = 1'b0;
        #20;

        B = 1'b1;
        #20;

        $finish;

        end

    initial begin: TEST_CASE
        $dumpfile("comparador_bits_TB.vcd");
        $dumpvars(-1, uut);
        #(10000) $finish;
    end

endmodule