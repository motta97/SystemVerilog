interface counter_ifc(
    input clk
);
  logic         rst_n;
  logic          en;    
  logic          up_down; 
  logic  [7:0]  count;

    command_monitor command_monitor_h;
    result_monitor result_monitor_h;


    clocking cb @(posedge clk);
        default input #1ns output #1ns;
        input rst_n, en, up_down;
        output count;
    endclocking


    modport dut(
        clocking cb
    );

    task load_ifc(
        logic rst_n_s,
            en_s,
            up_down_s
    );
        `uvm_info("interface", "I got here at load_ifc",UVM_LOW)
        rst_n = rst_n_s;
        en = en_s;
        up_down = up_down_s;

        @(negedge clk);
        command_monitor_h.write_to_monitor(rst_n, en, up_down);
        result_monitor_h.write_to_monitor(count);
        `uvm_info("interface", "I got here at load_ifc",UVM_HIGH)

    endtask





endinterface