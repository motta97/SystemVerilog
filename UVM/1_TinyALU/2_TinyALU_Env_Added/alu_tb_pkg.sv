`include "alu_ifc.sv"
`pragma once
package alu_tb;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    class alu_tx;
        rand bit [3:0] A;
        rand bit [3:0] B;
        rand bit [1:0] op;
        constraint c{
            op!=2'b11;
        }
    endclass
    class driver extends uvm_component;
        `uvm_component_utils(driver);
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
                mbx.get(atx);
                ifc.load_ifc(.a(atx.A), .b(atx.B), .opp(atx.op));
            end

        endtask

    endclass



    class cover_alu extends uvm_component;
        `uvm_component_utils(cover_alu);
        virtual alu_ifc ifc;

        covergroup cov;
            coverpoint ifc.A;
            coverpoint ifc.B;
            coverpoint ifc.op;
        endgroup

        function new (string name, uvm_component parent);
            super.new(name,parent);
            if(!uvm_config_db #(virtual interface alu_ifc)::get(null,"*","ifc",ifc))
            $fatal("Failed to get IFC");
            cov=new();

        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);

            forever begin
                @(ifc.A or ifc.B or ifc.op or ifc.res);
                #0;
                cov.sample();
            end

        endtask





    endclass
    class scoreboard extends uvm_component;
        `uvm_component_utils(scoreboard);
        int expected;
        virtual alu_ifc ifc;
        localparam add =2'b00 ;
        localparam sub =2'b01 ;
        localparam mul =2'b10 ;

        function new (string name, uvm_component parent);
            super.new(name,parent);
            if(!uvm_config_db #(virtual interface alu_ifc)::get(null,"*","ifc",ifc))
            $fatal("Failed to get IFC");

        endfunction
        task run_phase(uvm_phase phase);
            super.run_phase(phase);

        forever begin
                @(ifc.A or ifc.B or ifc.op or ifc.res);
                #0;
                case(ifc.op)
                    add:begin
                        expected = ifc.A+ifc.B;

                    end
                    sub:begin
                        expected = ifc.A-ifc.B;

                    end
                    mul:begin
                        expected = ifc.A*ifc.B;
                    end
                default:
                    $error("Not valid OPCODE");
                endcase
                $display("Checking...");
                if(expected!=ifc.res && ifc.op!=2'b11)begin
                $error("Mismatch: op=%b A=%0d B=%0d Expected=%0d Got=%0d",
                   ifc.op, ifc.A, ifc.B, expected, ifc.res);
                end
            end

        endtask

    endclass
endpackage