`ifndef ALU_TB_PKG_SV
`define ALU_TB_PKG_SV
package alu_tb_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    typedef enum logic [1:0] {add, sub, mul} op_en;

    typedef struct {
        logic [3:0] A;
        logic [3:0] B;
        op_en op;
    } command_t;

    class command_monitor extends uvm_component;
        `uvm_component_utils(command_monitor);
        uvm_analysis_port #(command_t) comm_port;
        command_t cmd;
        
        virtual  alu_ifc ifc;
        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction
        function void build_phase(uvm_phase phase);

            if(!uvm_config_db #(virtual interface alu_ifc)::get(null,"*","ifc",ifc))
                $fatal("Failed to get the interface from the command_monitor class");
            ifc.command_monitor_h=this;
            comm_port=new("comm_port", this);
            
        endfunction
        function void write_to_monitor(logic [3:0]A, B, logic [1:0] op);
            cmd.A=A;
            cmd.B=B;
            cmd.op=op_en'(op);
            comm_port.write(cmd);
        endfunction

    endclass
    class result_monitor extends uvm_component;

        `uvm_component_utils(result_monitor);
        int result;
        virtual alu_ifc ifc;
        uvm_analysis_port #(int) rp;
        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction
        function void build_phase(uvm_phase phase);

        if(!uvm_config_db #(virtual interface alu_ifc)::get(null, "*", "ifc", ifc))
            $fatal("Failed to get the interface form the result monitor class");
        ifc.result_monitor_h=this;
        rp = new("rp", this);
        endfunction

        function void write_to_monitor(logic [4:0]res);
            result=res;
            rp.write(result);
        endfunction 
    endclass


    class alu_tx;
        rand bit [3:0] A;
        rand bit [3:0] B;
        rand op_en op;
        constraint c{
            op!=2'b11;
        }
    endclass
    class driver extends uvm_component;
        `uvm_component_utils(driver);
        logic [1:0]op_converted;
        alu_tx atx;
        mailbox #(alu_tx)mbx;
        virtual alu_ifc ifc;
        function new (string name, uvm_component parent);
            super.new(name,parent);
            if(!uvm_config_db #(virtual interface alu_ifc)::get(null,"*","ifc",ifc))
                $fatal("Failed to get IFC");
            if(!uvm_config_db #(mailbox #(alu_tx))::get(null,"*","mbx",mbx))
                $fatal("Failed to get the mailbox");
        endfunction
        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                $display("Driver is running...");
                mbx.get(atx);
                op_converted=atx.op;
                ifc.load_ifc(.a(atx.A), .b(atx.B), .opp(op_converted));
                #0;
            end

        endtask

    endclass





    class cover_alu extends uvm_subscriber #(command_t);
        `uvm_component_utils(cover_alu);
        logic [3:0]A;
        logic [3:0]B;
        logic [1:0]op;

        covergroup cov;
            coverpoint A;
            coverpoint B;
            coverpoint op;
        endgroup

        function new (string name, uvm_component parent);
            super.new(name,parent);
            cov=new();
        endfunction
        function void write(command_t t);
            $display("got into write in coverage");
            this.A=t.A;
            this.B=t.B;
            this.op=t.op;
            cov.sample();
        endfunction

        // task run_phase(uvm_phase phase);
        //     super.run_phase(phase);

        //     forever begin
        //         @(ifc.A or ifc.B or ifc.op or ifc.res);
        //         #0;
        //         cov.sample();
        //     end

        // endtask





    endclass
    class scoreboard extends uvm_subscriber #(int);
        `uvm_component_utils(scoreboard);
        int predicted;
        
        command_t cmd;
        uvm_tlm_analysis_fifo #(command_t) cmd_f;
        function void build_phase(uvm_phase phase);
            cmd_f = new("cmd_f", this);
        endfunction

        function new (string name, uvm_component parent);
            super.new(name,parent);
        endfunction
        function void write(int t);
             $display("got into write in scoreboard");
            if(!cmd_f.try_get(cmd))
                $fatal("failed to get the cmd from the scoreboard");
            case(cmd.op)
            add: predicted=cmd.A+cmd.B;
            sub: predicted=cmd.A-cmd.B;
            mul: predicted=cmd.A*cmd.B;
            endcase
            if(predicted!=t)
                $error("Error at op = %s A= %d B= %d Expected= %d, Found %s",op_en'(cmd.op), cmd.A, cmd.B, predicted, t);

        endfunction
        // task run_phase(uvm_phase phase);
        //     super.run_phase(phase);

        // forever begin
        //         @(ifc.A or ifc.B or ifc.op or ifc.res);
        //         #0;
        //         case(ifc.op)
        //             add:begin
        //                 expected = ifc.A+ifc.B;

        //             end
        //             sub:begin
        //                 expected = ifc.A-ifc.B;

        //             end
        //             mul:begin
        //                 expected = ifc.A*ifc.B;
        //             end
        //         default:
        //             $error("Not valid OPCODE");
        //         endcase
        //         $display("Checking...");
        //         if(expected!=ifc.res && ifc.op!=2'b11)begin
        //         $error("Mismatch: op=%b A=%0d B=%0d Expected=%0d Got=%0d",
        //            ifc.op, ifc.A, ifc.B, expected, ifc.res);
        //         end
        //     end

        // endtask

    endclass
endpackage
`endif