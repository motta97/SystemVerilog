module testbench(
    output logic [3:0] p,
    output logic load,enable,clk,master_reset,
    input logic [3:0]q
);
always #5 clk=~clk;
initial begin
    clk<=0;
    p<=4'b0000;
    master_reset=1'b0;
    load<=1'b0;
    enable=1'b1;
    #10 enable =1'b0;
    #10 load = 1'b1;
    #20 master_reset=1'b1;
    #20 master_reset=1'b0;
    #50;
    $finish;
end
endmodule