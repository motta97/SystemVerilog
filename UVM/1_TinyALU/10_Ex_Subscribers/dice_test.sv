import uvm_pkg::*;
`include "uvm_macros.svh";
class dice_test extends uvm_test;
    `uvm_component_utils(dice_test);
    dice_roller dice_roller_h;
    average average_h;



    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        dice_roller_h=new("dice_roller_h",this);
        average_h=new("average_h",this);
    endfunction

    function void connect_phase(uvm_phase phase);
        dice_roller_h.roll_app.connect(average_h.export_analysis);
    endfunction




endclass