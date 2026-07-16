import uvm_pkg::*;
`include "uvm_macros.svh";
class dice_roller extends uvm_component;
`uvm_component_utils(dice_roller);
uvm_analysis_port #(int) roll_app;
rand int d1;
constraint c{
    d1>=0;
    d1<=6;
}
function new(string name, uvm_component parent);
    super.new(name, parent);
endfunction
function void build_phase(uvm_phase phase);
roll_app=new("roll_app",this);
endfunction

task run_phase(uvm_phase phase);

    repeate(10) begin
        d1.randomize();
        roll_app.write(d1);

    end
endtask



endclass