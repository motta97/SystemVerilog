import alu_tb::*;
class testbench;

    virtual alu_ifc ifc;
    driver dr;
    cover_alu cov;
    scoreboard sb;

    function new(virtual alu_ifc ifc);
        this.ifc=ifc;
    endfunction

    task run();
    $display("Entered TB run");
        dr=new(ifc);
        cov=new(ifc);
        sb=new(ifc);
        fork
            dr.run();
            cov.run();
            sb.run();
        join_none
    endtask

endclass