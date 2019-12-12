
`timescale 10ns / 10ns

module alu (alu_out, data_in, enable_param_1, enable_param_2, enable_out, opcode, clock, reset);
  output[15:0] alu_out;
  input[15:0] data_in;
  input enable_param_1;
  input enable_param_2;
  input enable_out;
  input[2:0] opcode;
  input clock;
  input reset;

  reg[15:0] alu_out;
  reg[15:0] param_1;
  reg[15:0] param_2;

  always @(posedge clock)
    begin
      if (reset)
      begin
        param_1 = 16'd0;
        param_2 = 16'd0;
        alu_out = 16'dz;
      end
      else
      begin
        //Load inputs into input registers:
        if (enable_param_1)
          param_1 = data_in;
        if (enable_param_2)
          param_2 = data_in;

        if (enable_out)
        begin
          case (opcode)
          3'b000: //Add
            alu_out = param_1 + param_2;
          3'b001: //Sub
            alu_out = param_1 - param_2;
          3'b010: //Not
            alu_out = ~param_1;
          3'b011: //And
            alu_out = param_1 & param_2;
          3'b100: //Or
            alu_out = param_1 | param_2;
          3'b101: //Xor
            alu_out = param_1 ^ param_2;
          3'b110: //Xnor
            alu_out = param_1 ~^ param_2;
          default: alu_out = 16'dZ;
          endcase
        end
        else
          alu_out = 16'dZ;
      end
    end
endmodule
