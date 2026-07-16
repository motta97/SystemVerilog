`ifndef ENV_SV
`define ENV_SV
import uvm_pkg::*;
import alu_tb_pkg::*;
`include "uvm_macros.svh";
`include "base_tester.sv";
class env extends uvm_env;

`uvm_component_utils(env);

base_tester tester_h;
scoreboard scoreboard_h;
cover_alu cover_alu_h;

command_monitor command_monitor_h;
result_monitor result_monitor_h;

function new(string name, uvm_component parent);
super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
    tester_h = base_tester :: type_id::create("tester_h",this);
    scoreboard_h = scoreboard::type_id::create("scoreboard_h",this);
    cover_alu_h = cover_alu :: type_id::create("cover_alu_h",this);
    command_monitor_h = command_monitor::type_id::create("command_monitor_h",this);
    result_monitor_h = result_monitor::type_id::create("result_monitor_h", this);

endfunction
//added function
function void connect_phase(uvm_phase phase);
$display("connect phase worked!");
    result_monitor_h.rp.connect(scoreboard_h.analysis_export);
    command_monitor_h.comm_port.connect(scoreboard_h.cmd_f.analysis_export);
    command_monitor_h.comm_port.connect(cover_alu_h.analysis_export);

endfunction

endclass
`endif