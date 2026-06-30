module top;
    reg clk;
    ifc_alu ifc_interface(clk);
    test tb(ifc_interface.tb);
    alu dut(ifc_interface.dut);
    initial begin
        clk=0;
        forever begin
            #5 clk=~clk;
        end
    end



endmodule