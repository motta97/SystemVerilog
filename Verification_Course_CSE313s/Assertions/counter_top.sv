module top;
bit clk;
always #5 clk=~clk;
ifc top_ifc(clk);
tb tb1(top_ifc.testbench);
decade_counter dc(top_ifc.dut);
initial begin
    #100;
    $finish;
end


endmodule