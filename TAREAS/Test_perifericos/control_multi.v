module control_multi( clk , reset , lsb_B , init , C , done , sh , load , add );
 input clk;
 input reset;
 input lsb_B;
 input init;
 input C;
 output reg done;
 output reg sh;
 output reg load;
 output reg add;
 parameter START = 3'b000;
 parameter CHECK = 3'b001;
 parameter SHIFT = 3'b010;
 parameter ADD = 3'b011;
 parameter END = 3'b100;

 reg [2:0] state;

 initial begin
 done = 0;
 sh = 0;
 load = 0;
 add = 0;
 state = 0;
 end
 reg [3:0] count;
 always @(posedge clk) begin
 if (reset) begin
 state = START;
 end else begin
 case(state)
 START:begin
 count=0;
 if(init)
 state = CHECK;
 else
 state = START;
 end
 CHECK:
 if(lsb_B)
 state = ADD;
 else
 state = SHIFT;

 SHIFT:
 if(C)
 state = END;
 else
 state = CHECK;

 ADD:
 state = SHIFT;
 END:begin
 count = count + 1;
 state = (count>9) ? START : END ;
 end
 default: state = START;

 endcase
 end
 end
  always @(state) begin
 case(state)
 START:begin
 done = 0;
 sh = 0;
 load = 1;
 add = 0;
 end
 CHECK:begin
 done = 0;
 sh = 0;
 load = 0;
 add = 0;
 end
 SHIFT:begin
 done = 0;
 sh = 1;
 load = 0;
 add = 0;
 end
 ADD:begin
 done = 0;
 sh = 0;
 load = 0;
 add = 1;
 end
 END:begin
 done = 1;
 sh = 0;
 load = 0;
 add = 0;
 end
 default:begin
 done = 0;
 sh = 0;
 load = 0;
 add = 0;
 end
 endcase
 end
 endmodule

