module control_contador ( clk, rst, init, R_LSB, END, LOAD, SHIFT, ADD_UNOS, ADD_BITS, DONE );

   input    clk;
   input    rst;
   input    init;
   input    END;
   input    R_LSB;

   output reg  LOAD;
   output reg  SHIFT;
   output reg  ADD_BITS;
   output reg  ADD_UNOS;
   output reg  DONE;

   parameter START        = 3'b000;
   parameter CHECK        = 3'b001;
   parameter ADD_C_UNOS   = 3'b010;
   parameter ADD_C_BITS   = 3'b011;
   parameter FIN          = 3'b100;
 
   reg [2:0] state;

 initial begin
   state = START;

   DONE       = 0;
   LOAD       = 0;
   SHIFT      = 0;
   ADD_UNOS = 0;
   ADD_BITS = 0;
  end

 always @(posedge clk) begin
   if (rst) begin
      state <= START;
   end
   
   else begin

 case(state)
  START:begin
    if(init)
     state <= CHECK;
    else
     state <= START;
  end

  CHECK:begin
    if(R_LSB)
     state <= ADD_C_UNOS;
    else
     state <= ADD_C_BITS;
    end

  ADD_C_UNOS:begin
     state <= ADD_C_BITS;
    end

  ADD_C_BITS:begin
    if(END)
     state <= FIN;
    else
     state <= CHECK;
  end

  FIN: begin
    state <= START;
  end

  default:
     state <= START;
 endcase
 
 end

 end


 always @(state) begin
     DONE     = 0;
     LOAD     = 0;
     SHIFT    = 0;
     ADD_UNOS = 0;
     ADD_BITS = 0;

  case(state)

   START:begin
     LOAD     = 1;
    end

   CHECK:begin
    
    end
   
   ADD_C_UNOS:begin
     ADD_UNOS  = 1;
    end
 
   ADD_C_BITS:begin
     SHIFT     = 1;
     ADD_BITS  = 1;
    end
  
   FIN:begin
     DONE      = 1;
   end

   default: begin
     DONE       = 0;
     LOAD       = 0;
     SHIFT      = 0;
     ADD_UNOS = 0;
     ADD_BITS = 0;
    end

  endcase

  end

endmodule
