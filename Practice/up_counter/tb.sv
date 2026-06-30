import tx_pkg::*;
module tb(
    ifc.tb ifc_tb
);
transaction tx;
initial begin
    tx=new();
    ifc_tb.rst_n=0;
    ifc_tb.en=0;
    repeat(2) @(negedge ifc_tb.clk);  // hold reset for 2 cycles
    repeat(500)begin

        assert(tx.randomize());
        @(negedge ifc_tb.clk);
        ifc_tb.en=tx.en;
        ifc_tb.rst_n=tx.rst_n;
    end
    $finish;
end

endmodule