module top;
    logic [3:0] p;
    logic load, enable, clk, master_reset;
    logic [3:0]q;

decade_counter dut( p,
     load,enable,
     clk,master_reset,q);
testbench t1( p,
     load,enable,
     clk,master_reset,q);

initial begin
    $dumpfile("counter.vcd");
    $dumpvars;
end
endmodule