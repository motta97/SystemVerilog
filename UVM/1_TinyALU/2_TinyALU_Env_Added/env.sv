`ifndef ENV_SV
`define ENV_SV
import uvm_pkg::*;
import alu_tb::*;
`include "base_tester.sv";
`include "uvm_macros.svh";
class env extends uvm_env;
    `uvm_component_utils(env);
    base_tester tester_h;
    driver driver_h;
    scoreboard scoreboard_h;
    cover_alu cover_alu_h;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        tester_h=base_tester::type_id::create("tester_h",this);
        driver_h=driver::type_id::create("driver_h",this);
        scoreboard_h=scoreboard::type_id::create("scoreboard_h",this);
        cover_alu_h=cover_alu::type_id::create("cover_alu_h",this);
    endfunction: build_phase

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new



endclass:env
`endif