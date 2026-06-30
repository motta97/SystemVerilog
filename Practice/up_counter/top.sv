module top;
logic clk;
ifc ic_top(clk);
tb tb_top(ic_top.tb);
up_counter dut(ic_top.dut);

initial begin
    clk=1'b0;
    forever begin
        #5 clk = ~clk;
    end
end




endmodule