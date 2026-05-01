/*
for the follwing interface, add the following to it

1- a clocking block that's sensitive to the negative edge of the clock and all I/O that are synchronous to the clock

2- a modport for the testbench called master and a modport fot the DUt called slave

3- use the clocking block in the I/O llist for the master modport
*/

interface my_if(input bit clk);

bit write;
bit [15:0] data_in;
bit [7:0] address;
logic [15:0] data_out;

clocking clb @(negedge clk);
default input #15ns;
output #25ns write, address;
output @(posedge clk) data_in;
input  data_out;
endclocking
modport master(
    clocking clb
);
modport slave (
input clk, write, address, data_in,
output data_out
);

endinterface