module multi (clk,reset,init, A, B, R, done);
input clk;
input reset;
input init;
input [7:0] A;
input [7:0] B;
output [15:0] R;
output done;

wire w_sh;
wire w_ld;
wire w_addC;
wire w_C;

wire [15:0] w_A;
wire [7:0] w_B;

regb regb0 (.clk(clk),.in_B(B),.shift(w_sh),.load(w_ld),.s_B(w_B));
rega rega0 (.clk(clk),.in_A(A),.shift(w_sh),.load(w_ld),.s_A(w_A));
comp comp0 (.B(w_B),.C (w_C));
acc acc0 (.clk(clk),.A(w_A),.add(w_addC),.rst(reset),.R(R));

control_multi control0(.clk(clk),.reset(reset),.lsb_B(w_B[0]),.init(init),.C(w_C),
.done(done),.sh(w_sh),.load(w_ld),.add(w_addC));
endmodule 
