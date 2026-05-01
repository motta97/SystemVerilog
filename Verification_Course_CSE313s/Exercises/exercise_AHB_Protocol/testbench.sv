module ahb_tb;
/*
we're having master and slave as IPs, we're testing them
here
*/
logic clk = 0;
ahb_ifc ifc(clk);
ahb_slave ahb_s (ifc.slave);
ahb_master ahb_m (ifc.master);
always #5 clk=~clk;

initial begin
    #100;
    $finish;
end

endmodule