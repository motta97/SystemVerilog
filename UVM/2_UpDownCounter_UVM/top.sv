
import uvm_pkg::*;
`include "uvm_macros.svh"
import counter_env_pkg::*;
`include "counter_ifc.sv"
`include "counter.v"

module top;

    bit clk;
    counter_ifc ifc(.clk(clk));
    counter dut(.clk(clk),.rst_n(ifc.rst_n), .en(ifc.en), .up_down(ifc.up_down), .count(ifc.count) );
    
    initial begin
        clk = 0;
        fork
            forever begin
                #5 clk =~clk;
            end
        join_none
        
        uvm_config_db #(virtual interface counter_ifc)::set(null, "*", "ifc", ifc);
        run_test();
    end



endmodule