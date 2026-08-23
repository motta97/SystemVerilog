class command_monitor extends uvm_monitor;
    `uvm_component_utils(command_monitor)
    virtual counter_ifc counter_ifc_h;
    uvm_analysis_port #(command_sequence_item) command_port;
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        if(!uvm_config_db #(virtual counter_ifc)::get(null, "*", "ifc", counter_ifc_h))
            `uvm_fatal("command_monitor", "failed to get the interface")
        counter_ifc_h.command_monitor_h=this;
        command_port = new("command_port", this);
    endfunction

    function void write_to_monitor(bit rst_n, bit en, bit up_down);

        command_sequence_item cmd;
        cmd= command_sequence_item :: type_id::create("cmd");
        cmd.rst_n = rst_n;
        cmd.en = en;
        cmd.up_down = up_down;
        command_port.write(cmd);

    endfunction




endclass