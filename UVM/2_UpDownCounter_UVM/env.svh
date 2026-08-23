class env extends uvm_env;
//agent, agent_conifg, scoreboard
`uvm_component_utils(env)
counter_agent agent_h;
scoreboard scoreboard_h;

function new(string name, uvm_component parent);
super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
    agent_h = counter_agent::type_id::create("agent_h",this);
    scoreboard_h = scoreboard::type_id::create("scoreboard_h",this);
endfunction

function void connect_phase(uvm_phase phase);
    agent_h.command_port.connect(scoreboard_h.cmd_fifo.analysis_export);
    agent_h.result_port.connect(scoreboard_h.result_fifo.analysis_export);
endfunction














endclass