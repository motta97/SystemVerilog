interface ifc(
    input bit clk
);
    logic [3:0] count;
    logic       en;
    logic       rst_n;


    modport tb(
        input count, clk,
        output en, rst_n
    );
    modport dut(
        input clk, en, rst_n,
        output count
    );
    assert property (
        @(posedge clk) disable iff !rst_n (en==1)|=> (count==$past(count)+1)
    ) else 
        $error("Counter being not incremented at en = 1 and rst_n = 1");
    
    assert property(
        @(posedge clk) !rst_n |=> count==0
    ) else
        $error("Counter not being zero at rst_n = 0");
    
    assert property(
        @(posedge clk) disable iff (!rst_n || en)
        (en==0) |=> (count==$past(count))
    )else
        $error("Counter being not holding past value at en = 0 and rst_n = 1");
    

endinterface