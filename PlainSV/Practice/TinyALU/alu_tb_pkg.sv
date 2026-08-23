`include "alu_ifc.sv"
package alu_tb;
    class alu_tx;
        rand bit [3:0] A;
        rand bit [3:0] B;
        rand bit [1:0] op;
        constraint c{
            op!=2'b11;
        }
    endclass
    class driver;
        alu_tx atx;
        virtual alu_ifc ifc;
        function new (virtual alu_ifc ifc);
            this.ifc = ifc;

        endfunction
        task run();
            atx=new();
            repeat(100)begin
                atx.randomize();
                ifc.load_ifc(atx.A, atx.B, atx.op);
                $display("running...");
                #1;
            end


        endtask

    endclass



    class cover_alu;
        virtual alu_ifc ifc;

        covergroup cov;
            coverpoint ifc.A;
            coverpoint ifc.B;
            coverpoint ifc.op;
        endgroup

        function new(virtual alu_ifc ifc);
            this.ifc=ifc;
            cov=new();
        endfunction

        task run();

            
            forever begin
                @(ifc.A or ifc.B or ifc.op or ifc.res);
                #0;
                cov.sample();
            end
        endtask





    endclass
    class scoreboard;
        int expected;
        virtual alu_ifc ifc;
        localparam add =2'b00 ;
        localparam sub =2'b01 ;
        localparam mul =2'b10 ;

        function new(virtual alu_ifc ifc);
        this.ifc=ifc;
        endfunction
        task run();
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