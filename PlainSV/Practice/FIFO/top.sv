import transaction_pkg::*;
module top;

    bit clk;
    mailbox #(monitor_transaction)mon2sb;
    ifc #(.WIDTH(8),.DEPTH(8)) ifc_top (clk);
    sync_fifo  #(.WIDTH(8), .DEPTH(8)) dut(ifc_top.dut);
    testbench  #(.WIDTH(8), .DEPTH(8)) tb(ifc_top.tb);
    monitor mon;
    scoreboard sb;
    initial begin
        mon =new(ifc_top,mon2sb, 8, 8);
        sb=new(8, 8, mon2sb);
        fork 
            mon.run();
            sb.run();
        join_none
        clk=1'b0;
        forever begin
            clk=~clk;
        end
    end


endmodule