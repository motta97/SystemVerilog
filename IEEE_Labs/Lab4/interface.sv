interface myBus(input clk);
    logic[7:0]  address;
    logic[15:0]  data;
    logic       en;
    modport DUT(input address,en, output data);
    modport TB(output address, en, input data);
endinterface 
