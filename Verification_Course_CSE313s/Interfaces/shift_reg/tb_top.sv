module top;
    logic clk;
    ifc i(clk);
    shift_reg sr(i.dut);
    test t(i.tb);
    initial begin
        clk=0;
    end
    always 
    #5 clk=~clk;    

endmodule