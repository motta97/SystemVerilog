`ifndef ALU_AGENT
`define ALU_AGENT
import uvm_pkg::*;
`include "uvm_macros.svh";
`include "tinyalu_agent_config.sv";
`include "base_tester.sv"
class tinyalu_agent extends uvm_agent;

`uvm_component_utils(tinyalu_agent);
tinyalu_agent_config agent_config_h;
base_tester tester_h;
driver driver_h;

command_monitor command_monitor_h;
result_monitor result_monitor_h;
uvm_analysis_port #(result_transaction) result_ap;
uvm_analysis_port #(command_transaction) cmd_ap;
uvm_tlm_fifo #(command_transaction) tlm_fifo_h;

//the interface is not being used here but passed anyway

function new(string name, uvm_component parent);
super.new(name, parent);
endfunction
function void build_phase(uvm_phase phase);

    if(!uvm_config_db #(tinyalu_agent_config)::get(this,"","config",agent_config_h))
        `uvm_fatal("ALU AGENT", "Failed to get the configuration object");
    is_active=agent_config_h.get_is_active();
    if(is_active==UVM_ACTIVE)begin
        tlm_fifo_h = new("tlm_fifo_h", this);
        tester_h = base_tester::type_id::create("tester_h", this);
        driver_h = driver::type_id::create("driver_h", this);
    end
    command_monitor_h = command_monitor::type_id::create("command_monitor_h", this);
    result_monitor_h = result_monitor::type_id::create("result_monitor_h", this);



    cmd_ap = new("cmd_ap", this);
    result_ap = new("result_ap", this);

endfunction:build_phase


function void connect_phase(uvm_phase phase);

if(get_is_active())begin
    tester_h.put_port_h.connect(tlm_fifo_h.put_export);
    driver_h.get_port_h.connect(tlm_fifo_h.get_export);
end

command_monitor_h.comm_port.connect(cmd_ap);//or simply: cmd_ap = command_monitor_h.comm_port  this makes it as a pointer
result_monitor_h.rp.connect(result_ap);//same goes here as int eh abobe line


endfunction











endclass
`endif