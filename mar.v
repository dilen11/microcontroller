

module mar(mar_out, mar_in, clock, reset, enable_out, enable_read);
output[15:0] mar_out;
input[15:0] mar_in;
input clock, reset, enable_out, enable_read;

reg[15:0] mar_val, mar_out;

always @(posedge clock)
begin:behavior
  if (reset)
    mar_val = 16'd0;
  else if (enable_read)
    mar_val = mar_in;

  if (enable_out)
    mar_out = mar_val;
  else
    mar_out = 16'hZZZZ;
end//behavior
endmodule
