//  Write code for the below requirement 
// DUT has data bus of 64 bit which is driven on positive edge of clock. 
// TESTBENCH has data bus of 32 bit which can sample on both positive edge and 
// negative edge. 
// On positive edge, drive [0 to 31] bits of DUT to TESTBENCH bus and on negative 
// edge drive [32 to 63] bits of DUT to TESTBENCH bus. 
// All the above logic should be done inside the interface itself.

interface ifc(input bit clk);
bit [63:0] dut_bus;
bit [31:0] tb_bus;

modport dut(
    output dut_bus;
)
modport tb(
    input tb_bus;
)
assign tb_bus = clk? dut_bus[31:0]: dut_bus[63:32];

endinterface