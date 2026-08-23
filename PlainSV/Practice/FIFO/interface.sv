interface ifc #(
    parameter DEPTH = 8,
    parameter WIDTH = 8
)(
     input bit clk
);

    logic             rst_n;
    logic             wr_en;
    logic             rd_en;
    logic [WIDTH-1:0] wr_data;
    logic [WIDTH-1:0] rd_data;
    logic             full;
    logic             empty;

modport tb(
    input clk, rd_data, full, empty,
    output rst_n, rd_en, wr_en, wr_data
);
modport dut(
    output rd_data, full, empty,
    input clk, rst_n, rd_en, wr_en, wr_data
);
assert property (
    @(posedge clk) !rst_n|=>(!full && empty)
)else
    $error("Full != 0 or Empty != 1 at reset");

//I don't know how to check on when full write is ignored, since I can't access
//the internal signal pointer
assert property(
    @(posedge clk) (rd_en && empty) |=>(rd_data==$past(rd_data))
)else 
    $error("Read enable is not ignored when the FIFO is empty");





endinterface