//CPU testbench for final project

`timescale 10 ns / 1 ns

module testbench_cpu;

reg clock, reset, mfc;
wire cpu_mem_enable, cpu_mem_rw;
wire[15:0] address_in, data_in;
reg[15:0] address, data_out;// curr_data,
reg[15:0] mem[65535:0]; //65535 == FFFF(hex)
// reg memData[15:0];
reg [15:0] i;

// CPU cpu(data_in,
//   data_out, clock, reset, mfc, address, cpu_mem_read, enable);
CPU cpu(address_in, data_in, data_out, cpu_mem_enable, cpu_mem_rw, clock, reset, mfc);

always
begin
  #2 clock = ~clock;
end

initial
begin
  //Initialize memory to 0
  for(i = 0; i<65535; i=i+1)
  begin
    mem[i] = 16'b0;
  end

  mem[0] = 16'b1010_000000_011011; //MOVI R0, #1b
  mem[1] = 16'b0010_000000_011110; //ADDI R0, #1E
  mem[2] = 16'b0000_000000_000000; //MOV R0, R0
  mem[3] = 16'b0011_000000_000000; //SUBI R0, R0
  mem[4] = 16'b0010_000000_000000; //XOR R0, #P0
  mem[5] = 16'b0101_000000_000000; //INV R0
  mem[6] = 16'b1100_000001_000000; //STORE R0, (R0)
  mem[7] = 16'b1011_000000_000011; //LOAD (R0), R3
  mem[65515] = 16'hffeb;
  //Initialize signals
  clock = 1'b0;
  data_out = 16'd0;
  reset = 1'b1;
  mfc = 1'b0;
  #2
  // data_in = 16'bz;
  @(negedge clock) reset = 1'b0;
end

always @ (cpu_mem_enable)
begin
  if (cpu_mem_enable)
  begin
    if (cpu_mem_rw == 1'b0) //read
    begin
      data_out <= mem[address_in];
      #6 mfc <= 1'b1;
    end
    else
    begin
      mem[address_in] <= data_in;
      #6 mfc <= 1'b1;
    end
  end
  else
  begin
    mfc <= 1'b0;
  end
end

endmodule

