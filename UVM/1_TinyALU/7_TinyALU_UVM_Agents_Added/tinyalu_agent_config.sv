`ifndef ALU_AGENT_CONFIG
`define ALU_AGENT_CONFIG
import uvm_pkg::*;
`include "uvm_macros.svh";
class tinyalu_agent_config;

    virtual interface alu_ifc ifc;
    protected uvm_active_passive_enum is_active;

    function new(virtual alu_ifc ifc, uvm_active_passive_enum is_active);
        this.ifc=ifc;
        this.is_active=is_active;
    endfunction

    function uvm_active_passive_enum get_is_active();
        return is_active;
    endfunction








endclass
`endif