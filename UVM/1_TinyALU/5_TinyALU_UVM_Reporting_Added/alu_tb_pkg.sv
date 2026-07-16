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
                `uvm_fatal("Command monitor","Failed to get the interface from the command_monitor class");
            ifc.command_monitor_h=this;
            comm_port=new("comm_port", this);
            
        endfunction
        function void write_to_monitor(int A, B, int  op);
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
                `uvm_fatal("Result Monitor", "Failed to get the interface form the result monitor class");//added for UVM reporting
            ifc.result_monitor_h=this;
            rp = new("rp", this);
        endfunction

        function void write_to_monitor(int res);
            result=res;
            `uvm_info("Result Monitor","Got into Write to monitor function",UVM_HIGH);
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
        alu_tx atx;
        uvm_get_port #(alu_tx) get_port_h;
        virtual alu_ifc ifc;
        logic [1:0]op_converted;
        // mailbox #(alu_tx)mbx;

        function new (string name, uvm_component parent);
            super.new(name,parent);
            if(!uvm_config_db #(virtual interface alu_ifc)::get(null,"*","ifc",ifc))
                `uvm_fatal("Driver ","Failed to get IFC");
            // if(!uvm_config_db #(mailbox #(alu_tx))::get(null,"*","mbx",mbx))
            //     $fatal("Failed to get the mailbox");
        endfunction
        //added
        function void build_phase(uvm_phase phase);
            get_port_h = new("get_port_h", this);
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                get_port_h.get(atx);//added
                op_converted=atx.op;
                ifc.load_ifc(.a(atx.A), .b(atx.B), .opp(op_converted));
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
            coverpoint op{
                bins add={0};
                bins sub={1};
                bins mul={2};
            }
        endgroup

        function new (string name, uvm_component parent);
            super.new(name,parent);
            cov=new();
        endfunction
        function void write(command_t t);
            `uvm_info("Coverage","got into write", UVM_HIGH);
            this.A=t.A;
            this.B=t.B;
            this.op=t.op;
            cov.sample();
        endfunction


    endclass
    class scoreboard extends uvm_subscriber #(int);
        `uvm_component_utils(scoreboard);
        int predicted;
        string s;
        command_t cmd;
        uvm_tlm_analysis_fifo #(command_t) cmd_f;
        function void build_phase(uvm_phase phase);
            cmd_f = new("cmd_f", this);
        endfunction

        function new (string name, uvm_component parent);
            super.new(name,parent);
        endfunction
        function void write(int t);
             `uvm_info("Scoreboard ","got into write", UVM_HIGH);
            if(!cmd_f.try_get(cmd))
                `uvm_fatal("Scorebaord","failed to get the cmd from the scoreboard");
            case(cmd.op)
            add: predicted=cmd.A+cmd.B;
            sub: predicted=cmd.A-cmd.B;
            mul: predicted=cmd.A*cmd.B;
            endcase
            if(predicted!=t)begin
                s= $sformatf("Error at op = %s A= %d B= %d Expected= %d, Found %d",op_en'(cmd.op), cmd.A, cmd.B, predicted, t);
                `uvm_error("Scoreboard ",s);
            end
        endfunction
    endclass
endpackage
`endif