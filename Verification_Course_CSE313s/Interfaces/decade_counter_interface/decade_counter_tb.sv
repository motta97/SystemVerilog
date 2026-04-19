module testbench(
decade_ifc ifc
);
always #5 ifc.clk=~ifc.clk;
initial begin
    ifc.clk<=0;
    ifc.p<=4'b0000;
    ifc.master_reset=1'b0;
    ifc.load<=1'b0;
    ifc.enable=1'b1;
    #10 ifc.enable =1'b0;
    #10 ifc.load = 1'b1;
    #20 ifc.master_reset=1'b1;
    #20 ifc.master_reset=1'b0;
    #50;
    $finish;
end
endmodule