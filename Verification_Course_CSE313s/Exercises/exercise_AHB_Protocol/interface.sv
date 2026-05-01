interface ahb_ifc(input bit clk);
logic [20:0] haddr;
logic hwrite;
logic [7:0]  hwdata;
logic [7:0]  hrdata;
enum {IDLE=0,NONSEQ=2}htrans;
modport master(
    input clk, hrdata,
    output haddr, hwrite, htrans, hwdata
);
modport slave(
    output hrdata,
    input haddr, hwrite, htrans, hwdata,clk
);
property p_trans_check;
@(negedge clk) (htrans==IDLE ||htrans==NONSEQ);
endproperty
assert property (p_trans_check)
else   $error("transaction is not NONSEQ or IDLE at the negative edge");
endinterface