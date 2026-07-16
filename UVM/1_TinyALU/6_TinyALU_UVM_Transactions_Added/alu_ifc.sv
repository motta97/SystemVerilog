import alu_tb_pkg::*;
interface alu_ifc();
    logic [3:0]A;
    logic [3:0]B;
    logic[1:0] op;
    byte res;

    command_transaction command_transaction_h;
    result_transaction result_transaction_h;
    command_monitor command_monitor_h ;
    result_monitor result_monitor_h;
    always @(A or B or op) begin
        #0;//this fixed everything

        command_transaction_h=new();
        result_transaction_h=new();
        command_transaction_h.A=A;
        command_transaction_h.B=B;
        command_transaction_h.op=op_en'(op);
        result_transaction_h.result=res;
        //without it, the scoreboard were shifiting results by 1
        //it had the result of the previous transaction into the current transaction
        if (command_monitor_h != null)
            command_monitor_h.write_to_monitor(command_transaction_h);
        if (result_monitor_h != null)
            result_monitor_h.write_to_monitor(result_transaction_h);
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

