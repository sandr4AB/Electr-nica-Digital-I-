module comp (B, C);
input [7:0] B;
output reg C;

always @(*)
//  temp = (B==0) ? 1'b0 : 1'b1; 
  if (B==0)
     C <= 1;
  else
     C <= 0;   
    
endmodule

//BUSCAR COMPARADOR EN EL GITHUB

/*
module comp(B, C);
input [7:0]B;
output C;
reg temp;
initial temp = 0;
assign C = temp;
always@(*)
//temp = (B==0) ? 1'b1 : 1'b0;
if (B==0)
     C <= 1;
  else
     C <= 0; 
endmodule
*/





