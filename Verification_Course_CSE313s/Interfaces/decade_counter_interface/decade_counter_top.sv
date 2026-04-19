module top_ifc;
logic clk;
decade_ifc ifc(clk);


decade_counter dut(ifc.des);
testbench t1(ifc.tb);

initial begin
    $dumpfile("counter.vcd");
    $dumpvars;
end
endmodule