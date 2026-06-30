import transaction_pkg::*;
module testbench #(
    parameter DEPTH = 8,
    parameter WIDTH = 8
)(
    ifc.tb ifc_tb
);
tb_transaction tx;

initial begin
    tx=new(WIDTH);

    repeat(500)begin
        @(negedge ifc_tb.clk);
        assert(tx.randomize());
        ifc_tb.rst_n<=tx.rst_n;
        ifc_tb.rd_en<=tx.rd_en;
        ifc_tb.wr_en<=tx.wr_en;
        ifc_tb.wr_data<=tx.wr_data;
    end
end








endmodule