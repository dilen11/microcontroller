
module pcounter(d_out, clock, reset, enable_out, enable_increment);
  output[15:0] d_out;
  input clock;
  input reset;
  input enable_out;
  input enable_increment;

  reg[15:0] value, d_out;

  always @(posedge clock)
  begin:behavior
    if (reset)
      value = 16'd0;
    else if (enable_increment)
      value = value + 1;

    if (enable_out)
      d_out = value;
    else
      d_out = 16'hZZZZ;
  end//behavior

endmodule
