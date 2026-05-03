interface ifc(input bit clk);
//load,enable,master_reset, Q, P
logic load,enable,master_reset;
logic [3:0] Q;
logic [3:0] P;
modport dut(
    input clk,P,load,enable,master_reset,
    output Q
);
clocking clb @(posedge clk);
    default input #3ns output #2ns;
    input Q;
    output P, load,enable,master_reset;
endclocking
modport testbench(
    clocking clb
);

property load_equal;
    @(posedge clk) load |-> (Q==P);
endproperty

assert property (load_equal)
    $display("Success!");
else
    $fatal("Q not equal to P when load was high");

endinterface