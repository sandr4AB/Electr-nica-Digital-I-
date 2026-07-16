`timescale 1ns / 1ps
`define SIMULATION

module control_contador_TB;

reg clk;
reg rst;
reg init;
reg R_LSB;
reg END;

wire LOAD;
wire SHIFT;
wire ADD_UNOS;
wire ADD_BITS;
wire DONE;

control_contador uut( .clk(clk), .rst(rst), .init(init), .R_LSB(R_LSB), .END(END), .LOAD(LOAD), .SHIFT(SHIFT),
    .ADD_UNOS(ADD_UNOS), .ADD_BITS(ADD_BITS), .DONE(DONE));

parameter PERIOD = 20;
parameter real DUTY_CYCLE = 0.5;
parameter OFFSET = 0;

initial begin

    #OFFSET;

    forever begin

        clk = 0;
        #(PERIOD-(PERIOD*DUTY_CYCLE));

        clk = 1;
        #(PERIOD*DUTY_CYCLE);

    end

end

initial begin

    rst = 1;
    init = 0;
    R_LSB = 0;
    END = 0;

    @(negedge clk);
    rst = 0;

    // START -> CHECK
    @(negedge clk);
    init = 1;

    // CHECK -> ADD_C_UNOS
    @(negedge clk);
    R_LSB = 1;

    // ADD_C_BITS -> CHECK
    @(negedge clk);
    END = 0;

    // CHECK -> ADD_C_BITS
    @(negedge clk);
    R_LSB = 0;

    // ADD_C_BITS -> FIN
    @(negedge clk);
    END = 1;

    #(100);

    $finish;

end

   initial begin: TEST_CASE
        $dumpfile("control_contador_TB.vcd");
        $dumpvars(-1, uut);
        #(10000) $finish;
    end

endmodule