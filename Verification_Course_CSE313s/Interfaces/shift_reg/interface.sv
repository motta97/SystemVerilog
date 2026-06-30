interface ifc(input bit clk);
    parameter size =8 ;
    logic rst, sr, sl,load;
    logic [size-1:0] d;
    logic [size-1:0] q;
    modport dut(
        input rst,sr,sl,d,load,
        output q
    );
    modport tb(
        input q,
        output rst,sr,sl,load
    );

endinterface