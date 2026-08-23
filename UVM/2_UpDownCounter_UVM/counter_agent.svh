class counter_agent extends uvm_agent;

    `uvm_component_utils(counter_agent)
    counter_agent_config config_h;
    driver driver_h;
    //base_test test_h;
    sequencer sequencer_h;

    uvm_analysis_port #(command_sequence_item) command_port;
    uvm_analysis_port #(result_item) result_port;
    command_monitor command_monitor_h;
    result_monitor result_monitor_h;


    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(counter_agent_config)::get(this,"","agent_config",config_h))
            `uvm_fatal("counter_agent","failed to get the agent")

        is_active = config_h.get_is_active();
        if(get_is_active()==UVM_ACTIVE)begin

            driver_h = driver ::type_id::create("driver_h",this);
            //test_h = base_test::type_id::create("test_h", this);
            sequencer_h = new("sequencer_h", this);

        end
        command_monitor_h = command_monitor::type_id::create("command_monitor_h",this);
        result_monitor_h = result_monitor::type_id::create("result_monitor_h", this);
        command_port = new("command_port", this);
        result_port = new("result_port", this);

    endfunction
    
    function void connect_phase(uvm_phase phase);
        if(get_is_active()==UVM_ACTIVE)begin
            driver_h.seq_item_port.connect(sequencer_h.seq_item_export);
        end


        command_monitor_h.command_port.connect(command_port);
        result_monitor_h.result_port.connect(result_port);




    endfunction










endclass