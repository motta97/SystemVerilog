
module top_module;
reg clk;
myBus b(clk);
memory m(.clk(clk),.MB(b.DUT));
testbench t(.bus(b.TB));
initial begin
    clk=1'b0;
    forever begin
       #5 clk=~clk;
    end
end
endmodule