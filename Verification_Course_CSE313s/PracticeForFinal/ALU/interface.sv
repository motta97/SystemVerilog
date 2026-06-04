interface ifc_alu(input bit clk);
    bit signed [3:0] A, B;
    bit signed [4:0] C;
    logic reset;
    logic [1:0]opcode;



    clocking cb_tb @(posedge clk);
    default input #3 output #2;
        input C;
        output A,B,reset,opcode;
    endclocking
    modport tb(
       clocking cb_tb
    );
    modport dut(
        input clk, A, B,reset,opcode,
        output C
    );
    assert property(
        @(posedge clk)
        reset|->C==5'b0000_0

    )else $error("FATAL RESET IS NOT WORKING");

    covergroup cov@(posedge clk);
    option.per_instance=1;
    coverpoint A;
    coverpoint B;
    coverpoint opcode;
    endgroup
    initial begin
        cov c=new();
    end

endinterface