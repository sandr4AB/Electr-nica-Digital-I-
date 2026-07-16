module control_contador_unos(clk, rst, init, n_in, result, done);

    input clk;
    input rst;
    input init;
    input  [7:0] n_in;

    output [7:0] result;
    output done;

    wire LOAD;
    wire SHIFT;
    wire ADD_UNOS;
    wire ADD_BITS;

    wire R_LSB; //RESULTADO DESPUES DE DECIR SI ES 1 Ó 0
    wire END;

    wire [7:0] REG; //REGISTRO DE 1 Y 0
    wire [3:0] R_BITS; //CONTADOR DE LOS 8 BITS 

    registro_corrimiento R_shift(
        .clk(clk),
        .rst(rst),
        .load(LOAD),
        .shift(SHIFT),
        .in(n_in),
        .Q(REG));

    comparador_LSB comp_LSB(
        .B(REG[0]),
        .z(R_LSB));

    contador_bits C_BITS(
        .clk(clk),
        .rst(rst),
        .inc(ADD_BITS),
        .Q(R_BITS));

    contador_unoss C_UNOS(
        .clk(clk),
        .rst(rst),
        .inc(ADD_UNOS),
        .Q(R_UNOS));
    
    comparador_bits comp_BITS(
        .B(R_BITS),
        .z(END));

    control_contador C_CONTROL(
        .clk(clk),
        .rst(rst),
        .init(init),
        .cmp(R_LSB),
        .end_cnt(END),
        .load(LOAD),
        .shift(SHIFT),
        .add_unos(ADD_UNOS),
        .add_bits(ADD_BITS),
        .done(DONE));

endmodule