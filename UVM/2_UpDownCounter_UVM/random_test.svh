class random_test extends uvm_test;
    `uvm_component_utils(random_test);
    env env_h;
    sequencer sequencer_h;

    counter_agent_config agent_config_h;
    random_sequence cmd_sequence;

    function new(string name, uvm_component parent);
        super.new(name, parent);

    endfunction


    function void build_phase(uvm_phase phase);
        env_h = env::type_id::create("env_h",this);

        agent_config_h = new(UVM_ACTIVE);
        uvm_config_db #(counter_agent_config)::set(this, "env_h.agent_h", "agent_config", agent_config_h);
    endfunction
    function void end_of_elaboration_phase(uvm_phase phase);
        sequencer_h = env_h.agent_h.sequencer_h;
    endfunction

    task run_phase(uvm_phase phase);

        phase.raise_objection(this);
            `uvm_info("Random test", "I got here", UVM_HIGH);
            cmd_sequence = new("cmd_sequence");
            
            cmd_sequence.start(sequencer_h);
        phase.drop_objection(this);
  
    
    endtask




endclass