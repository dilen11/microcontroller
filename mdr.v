
//MDR unit for final project

module mdr(mdr_bus_out, mdr_mem_out, mdr_bus_in, mdr_mem_in,
  clock, reset, enable_bus_out, enable_mem_out, enable_bus_read, enable_mem_read);

output[15:0] mdr_bus_out, mdr_mem_out;
input[15:0] mdr_bus_in, mdr_mem_in;
input clock, reset, enable_bus_out, enable_mem_out, enable_bus_read, enable_mem_read;

reg[15:0] mdr_val, mdr_bus_out, mdr_mem_out;

always @(posedge clock)
begin:behavior
  if (reset)
    mdr_val = 16'd0;
  else if (enable_bus_read)
    mdr_val = mdr_bus_in;
  else if (enable_mem_read)
    mdr_val = mdr_mem_in;

  if (enable_mem_out)
  begin
    mdr_bus_out = 16'hZZZZ;
    mdr_mem_out = mdr_val;
  end
  else if (enable_bus_out)
  begin
    mdr_bus_out = mdr_val;
    mdr_mem_out = 16'hZZZZ;
  end
  else
  begin
    mdr_mem_out = 16'hZZZZ;
    mdr_bus_out = 16'hZZZZ;
  end
end//behavior
endmodule
