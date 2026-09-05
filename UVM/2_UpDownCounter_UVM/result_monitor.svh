class result_monitor extends uvm_monitor;
    `uvm_component_utils(result_monitor)
    virtual counter_ifc counter_ifc_h;
    uvm_analysis_port #(result_item) result_port;
    result_item result_tx;
    result_item res;
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        if(!uvm_config_db #(virtual counter_ifc)::get(null,"*","ifc",counter_ifc_h))
            `uvm_fatal("result_monitor", "failed to get the interface")


        result_tx = result_item ::type_id::create("result_tx", this);
        result_port = new("result_port", this);
        // counter_ifc_h.result_monitor_h = this;
    endfunction

    task run_phase(uvm_phase phase);

        forever begin 
            @(posedge counter_ifc_h.clk);
            #1;
            res = result_item::type_id::create("res");
            res.result=counter_ifc_h.count;
            result_port.write(res);
        end
    endtask









endclass