`ifndef ALU_TB_PKG_SV
`define ALU_TB_PKG_SV
package alu_tb_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    typedef enum logic [1:0] {add, sub, mul, rst} op_en;




    class sequence_item extends uvm_sequence_item;//this was command transaction that extends the uvm_transaction
        `uvm_object_utils(sequence_item)
        rand bit [3:0] A;
        rand bit [3:0] B;
        shortint result;
        rand op_en op;
        function new(string name="sequence_item");
            super.new(name);
        endfunction

        //do_copy(), do_compare(), convert2string
        function void do_copy(uvm_object rhs);
            sequence_item command_transaction_h;
            if(rhs==null)
                `uvm_fatal("Command Transaction","Tried to copy from a null object")
            if(!$cast(command_transaction_h,rhs))
                `uvm_fatal("Command Transaction", "Tried to copy from the wrong type");
            super.do_copy(rhs);
            this.A=command_transaction_h.A;
            this.B=command_transaction_h.B;
            this.op=command_transaction_h.op;
            this.result = command_transaction_h.result;

        endfunction

        function bit do_compare(uvm_object rhs, uvm_comparer comparer);
            bit same;
            sequence_item command_transaction_h;
            if(rhs==null)
                `uvm_fatal("Command Transaction", "Tried to compare to a null pointer");
            if(!$cast(command_transaction_h, rhs))
                same=0;
            else
                same= super.do_compare(rhs, comparer)&&
                    this.A==command_transaction_h.A &&
                    this.B==command_transaction_h.B &&
                    this.op==command_transaction_h.op;
            return same;


        endfunction
        function string convert2string();
            string s;
            s=$sformatf("A: %0d, B: %0d, op: %0d", A, B, op);
            return s;
        endfunction


    endclass
    
    typedef uvm_sequencer #(sequence_item) sequencer;
    sequencer sequencer_h;
    
    class result_transaction extends uvm_transaction;
        int result;
        function new(string name="result_transaction");
            super.new(name);
        endfunction

        function void do_copy(uvm_object rhs);
            result_transaction result_transaction_h;
            if(rhs==null)
                `uvm_fatal("Result Transaction", "Tried to copy from a null pointer");
            if(!$cast(result_transaction_h,rhs))
                `uvm_fatal("Result Transaction","Tried to copy the wrong type");
            super.do_copy(rhs);
            this.result=result_transaction_h.result;
        endfunction
        function bit do_compare(uvm_object rhs, uvm_comparer comparer);
                result_transaction result_transaction_h;
                bit same;
                if(rhs==null)begin
                    same=0;
                    return same;
                end
                if(!$cast(result_transaction_h,rhs))
                    `uvm_fatal("Result Transaction","Tried to compare the wrong type");
                
                same = super.do_compare(rhs,comparer)
                      && this.result==result_transaction_h.result;
                
                return same;
        endfunction
        function string convert2string();
            string s;
            s= $sformatf("Result is: %0d",this.result);
            return s;
        endfunction


    endclass
    class result_monitor extends uvm_component;

        `uvm_component_utils(result_monitor);
        int result;
        virtual alu_ifc ifc;
        uvm_analysis_port #(result_transaction) rp;
        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction
        function void build_phase(uvm_phase phase);

            //  if(!uvm_config_db #(virtual interface alu_ifc)::get(null, "*", "ifc", ifc))
            //      `uvm_fatal("Result Monitor", "Failed to get the interface form the result monitor class");//added for UVM reporting
            //  ifc.result_monitor_h=this;
            rp = new("rp", this);
        endfunction

        function void write_to_monitor(result_transaction result_transaction_h);
            `uvm_info("Result Monitor","Got into Write to monitor function",UVM_HIGH);
            rp.write(result_transaction_h);
        endfunction 
    endclass
    class command_monitor extends uvm_component;
        `uvm_component_utils(command_monitor);
        uvm_analysis_port #(sequence_item) comm_port;

        sequence_item cmd;
        result_transaction result_transaction_h;
        result_monitor result_monitor_h;
        virtual  alu_ifc ifc;
        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction
        function void build_phase(uvm_phase phase);

            if(!uvm_config_db #(virtual interface alu_ifc)::get(null,"*","ifc",ifc))
                `uvm_fatal("Command monitor","Failed to get the interface from the command_monitor class");
            ifc.command_monitor_h=this;
            comm_port=new("comm_port", this);
            cmd=new();
            result_transaction_h = new();
            result_monitor_h = result_monitor::type_id::create("result_monitor_h", this);
        endfunction
        function void write_to_monitor(sequence_item command_transaction_h);
            result_transaction_h.result=command_transaction_h.result;
            comm_port.write(command_transaction_h);
            `uvm_info("Command Monitor","Got into Write to monitor function",UVM_HIGH);
            result_monitor_h.write_to_monitor(result_transaction_h);
        endfunction

    endclass


    class driver extends uvm_driver#(sequence_item);
        `uvm_component_utils(driver);
        virtual alu_ifc ifc;
        logic [1:0]op_converted;

        function new (string name, uvm_component parent);
            super.new(name,parent);
            if(!uvm_config_db #(virtual interface alu_ifc)::get(null,"*","ifc",ifc))
                `uvm_fatal("Driver ","Failed to get IFC");
        endfunction

        task run_phase(uvm_phase phase);
            // super.run_phase(phase);
            sequence_item cmd;
            forever begin
                shortint result;
                seq_item_port.get_next_item(cmd);
                $display("I GOT HERE IN THE DRIVER");
                ifc.load_ifc(cmd.A, cmd.B, cmd.op);
                seq_item_port.item_done();
            end

        endtask

    endclass



    class cover_alu extends uvm_subscriber #(sequence_item);
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
        function void write(sequence_item t);
            `uvm_info("Coverage","got into write", UVM_HIGH);
            this.A=t.A;
            this.B=t.B;
            this.op=t.op;
            cov.sample();
        endfunction


    endclass
    class scoreboard extends uvm_subscriber #(result_transaction);
        `uvm_component_utils(scoreboard);
        
        result_transaction predicted_result_transaction;
        string s;
        sequence_item cmd;
        uvm_tlm_analysis_fifo #(sequence_item) cmd_f;
        function void build_phase(uvm_phase phase);
            cmd_f = new("cmd_f", this);
            cmd=new();
            predicted_result_transaction=new();
            `uvm_info("SCOREBOARD", "I GOT HERE",UVM_HIGH)
        endfunction

        function new (string name, uvm_component parent);
            super.new(name,parent);
        endfunction
        function void write(result_transaction t);
             `uvm_info("Scoreboard ","got into write", UVM_HIGH);
            if(!cmd_f.try_get(cmd))
                `uvm_fatal("Scorebaord","failed to get the cmd from the scoreboard");
            case(cmd.op)
            add: predicted_result_transaction.result=cmd.A+cmd.B;
            sub: predicted_result_transaction.result=cmd.A-cmd.B;
            mul: predicted_result_transaction.result=cmd.A*cmd.B;
            endcase

            if(!predicted_result_transaction.compare(t))begin
                s= $sformatf("Error at op = %s A= %d B= %d Expected= %d, Found %d",op_en'(cmd.op), cmd.A, cmd.B, predicted_result_transaction.result, t.result);
                `uvm_error("Scoreboard ",s);
            end
        endfunction
    endclass
endpackage
`endif
