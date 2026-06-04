interface ifc_ahp(input bit HCLK);
logic [20:0] HADDR;
logic HWRITE;
typedef enum logic [1:0] {IDLE=0,NONSEQ=2}trans;
trans HTRANS;

logic [7:0] HWDATA, HRDATA;
modport master(
input HCLK,HRDATA,
output HADDR,HWRITE,HTRANS,HWDATA
);
modport slave(
    input HADDR, CLK, HWRITE, HTRANS, HWDATA,
    output HRDATA
);
assert property (
    @(negedge HCLK)
    (HTRANS==IDLE)||(HTRANS==NONSEQ);
)
else $error("ERROR");




endinterface