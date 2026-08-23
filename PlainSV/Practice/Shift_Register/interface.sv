interface ifc(
     input bit clk
);
      logic             clk,
      logic             rst_n,
      logic             load,      // parallel load
      logic             shift_en,  // shift enable
      logic             dir,       // 0=left, 1=right
      logic [WIDTH-1:0] data_in,   // parallel 
      logic [WIDTH-1:0] data_out   // parallel output

clocking cb @(posedge clk);
default input #1ns output #2ns;
endclocking
modport dut(
    clocking cb,
    input  rst_n, load, shift_en, dir, data_in,
    output data_out
);
modport tb(
    clocking cb,
    input data_out,
    output rst_n, load, shift_en, dir, data_in
);








endinterface