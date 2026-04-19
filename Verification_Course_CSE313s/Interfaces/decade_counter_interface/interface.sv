interface decade_ifc(input bit clk);
    logic [3:0] p;
    logic load,enable,master_reset;
    logic [3:0]q;

clocking cb @(posedge clk);
    default input #3ns output #2ns;
    input q;
    output load,enable , master_reset, p;
endclocking 

modport des (
input load,enable , master_reset, p,
output q
);
modport tb (
clocking cb
);
    
endinterface 
