`ifndef ENV_SV
`define ENV_SV
import uvm_pkg::*;
import alu_tb_pkg::*;
`include "uvm_macros.svh";

class env extends uvm_env;

`uvm_component_utils(env);


sequencer sequencer_h;//added in sequencer version, if we would add an agent, it would be inside it


//base_tester tester_h;removed in sequence version
scoreboard scoreboard_h;
cover_alu cover_alu_h;
driver driver_h;
command_monitor command_monitor_h;
result_monitor result_monitor_h;

//uvm_tlm_fifo #(command_transaction) tlm_fifo_h;removed in sequencer version





function new(string name, uvm_component parent);
super.new(name, parent);
endfunction



function void build_phase(uvm_phase phase);
    sequencer_h = new("sequencer_h",this);

    command_monitor_h = command_monitor::type_id::create("command_monitor_h", this);
    result_monitor_h  = result_monitor::type_id::create("result_monitor_h", this);
    driver_h = driver :: type_id::create("driver_h", this);
    // tester_h = base_tester :: type_id::create("tester_h",this);
    scoreboard_h = scoreboard::type_id::create("scoreboard_h",this);
    cover_alu_h = cover_alu :: type_id::create("cover_alu_h",this);

endfunction
function void connect_phase(uvm_phase phase);
    result_monitor_h.rp.connect(scoreboard_h.analysis_export);
    command_monitor_h.comm_port.connect(scoreboard_h.cmd_f.analysis_export);
    command_monitor_h.comm_port.connect(cover_alu_h.analysis_export);
    driver_h.seq_item_port.connect(sequencer_h.seq_item_export);
    // driver_h.get_port_h.connect(tlm_fifo_h.get_export);removed in sequencer version
    // tester_h.put_port_h.connect(tlm_fifo_h.put_export);removed in sequencer version
endfunction
//added function
function void end_of_elaboration_phase(uvm_phase phase);

//scoreboard_h.set_report_verbosity_level_hier(UVM_FULL);
//scoreboard_h.set_report_severity_action_hier(UVM_ERROR, UVM_NO_ACTION);
endfunction


endclass
`endif