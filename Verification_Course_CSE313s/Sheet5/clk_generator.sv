module top;

logic clk;
initial begin
    clk=0;
    forever begin
        #5 clk=~clk;
    end
end







endmodule