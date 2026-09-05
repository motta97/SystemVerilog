class command_monitor extends uvm_monitor;
    `uvm_component_utils(command_monitor)
    virtual counter_ifc counter_ifc_h;
    command_sequence_item cmd;
    uvm_analysis_port #(command_sequence_item) command_port;
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        if(!uvm_config_db #(virtual counter_ifc)::get(null, "*", "ifc", counter_ifc_h))
            `uvm_fatal("command_monitor", "failed to get the interface")
        // counter_ifc_h.command_monitor_h=this;
        command_port = new("command_port", this);
    endfunction

    task run_phase(uvm_phase phase);

        forever begin 
            @(posedge counter_ifc_h.clk);
            #1;
            cmd = command_sequence_item::type_id::create("cmd");
            cmd.rst_n = counter_ifc_h.rst_n;
            cmd.en = counter_ifc_h.en;
            cmd.up_down = counter_ifc_h.up_down;
            command_port.write(cmd);
        end

    endtask

endclass