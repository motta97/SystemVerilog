import uvm_pkg::*;
`include "uvm_macros.svh"
import alu_tb::*;
class random_test extends uvm_test;
    `uvm_component_utils(random_test)
    virtual alu_ifc ifc;
    cover_alu cov;
    driver dr;
    scoreboard sb;
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        cov=new("cov",this);
        dr=new("dr",this);
        sb=new("sb",this);
    endfunction

    // task run_phase(uvm_phase phase);


    //     phase.raise_objection(this);


    //     fork
    //         cov.run();

    //         sb.run();
    //     join_none
    //         dr.run();
    //         phase.drop_objection(this);

    //     endtask


endclass
