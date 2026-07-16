import alu_tb_pkg::*;
interface alu_ifc();
    logic [3:0]A;
    logic [3:0]B;
    logic[1:0] op;
    logic [4:0]res;

    command_monitor command_monitor_h ;
    result_monitor result_monitor_h;
    always @(A or B or op) begin
        if (command_monitor_h != null)
            command_monitor_h.write_to_monitor(A, B, op);
        if (result_monitor_h != null)
            result_monitor_h.write_to_monitor(res);
    end
modport tb(
    input res,
    output A,B,op
);
task load_ifc(logic [3:0]a,
    logic [3:0]b,
    logic [1:0]opp);
    A=a;
    B=b;
    op=opp;
endtask

    

endinterface //alu_ifc

