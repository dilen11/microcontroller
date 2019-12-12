
module registers(reg0_out, reg0_in, reg0_enable_read, reg0_enable_out,
                  reg1_out, reg1_in, reg1_enable_read, reg1_enable_out,
                  reg2_out, reg2_in, reg2_enable_read, reg2_enable_out,
                  reg3_out, reg3_in, reg3_enable_read, reg3_enable_out,
                  clock, reset);
output[15:0] reg0_out, reg1_out, reg2_out, reg3_out;
input[15:0] reg0_in, reg1_in, reg2_in, reg3_in;
input reg0_enable_read, reg1_enable_read, reg2_enable_read, reg3_enable_read;
input reg0_enable_out, reg1_enable_out, reg2_enable_out, reg3_enable_out;
input clock, reset;

reg[15:0] reg0_val, reg1_val, reg2_val, reg3_val;
reg[15:0] reg0_out, reg1_out, reg2_out, reg3_out;

always @(posedge clock)
begin:behavior
  if (reset)
  begin
    reg0_val = 16'd0;
    reg1_val = 16'd0;
    reg2_val = 16'd0;
    reg3_val = 16'd0;
  end
  else
  begin
    if (reg0_enable_read)
      reg0_val = reg0_in;
    if (reg1_enable_read)
      reg1_val = reg1_in;
    if (reg2_enable_read)
      reg2_val = reg2_in;
    if (reg3_enable_read)
      reg3_val = reg3_in;
  end

  reg0_out = (reg0_enable_out) ? reg0_val : 16'hZZZZ;
  reg1_out = (reg1_enable_out) ? reg1_val : 16'hZZZZ;
  reg2_out = (reg2_enable_out) ? reg2_val : 16'hZZZZ;
  reg3_out = (reg3_enable_out) ? reg3_val : 16'hZZZZ;
end//behavior
endmodule
