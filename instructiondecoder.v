

module instructiondecoder(opcode, param1, param2, enable, bus_in, clock, reset);
output[3:0] opcode;
output[5:0] param1, param2;
input[15:0] bus_in;
input clock, reset, enable;

reg[15:0] instruction;
reg[3:0] opcode;
reg[5:0] param1, param2;

always @(posedge clock)
begin:behavior
  if (reset)
    instruction = 16'h0;
  else if (enable)
    instruction = bus_in;

  opcode = instruction[15:12];
  param1 = instruction [11:6];
  param2 = instruction[5:0];
end//behavior

endmodule
