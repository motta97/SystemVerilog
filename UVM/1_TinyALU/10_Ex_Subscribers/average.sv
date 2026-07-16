import uvm_pkg::*;
`include "uvm_macros.svh";
class average extends uvm_subscriber #(int);
`uvm_component_utils(average);
int total_count;
int count;
function new(string name, uvm_component parent);
    super.new(name, parent);
    total_count=0;
    count=0;
endfunction
function write(int t);
    total_count=total_count+t;
    count++;
endfunction
task report_phase(uvm_phase phase);

if(count>0)
    $display("Average is: "real'(total_count)/count);
else
    $display("Count is or less than zero");

endtask
endclass