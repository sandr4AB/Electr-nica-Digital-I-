module comparador_LSB ( B, z);

        input   B;
        output  z;

        assign z = (B == 1'b1);
        
endmodule