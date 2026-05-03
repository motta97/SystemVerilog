module tb(ifc y);

initial begin
    //assuming clk period is 10 ns
    //note that we use y.clb to refere to the clocking blocl
    //since the modport uses that clocking block
    //otherwise it would give an error
    //note also that we used non-blocking assignments, because signals within the clocking block
    //are synchronous, otherwise it would give error during elaboration
    #5;
    y.clb.master_reset<=1'b1;
    #10;
    y.clb.load<=1'b1;
    y.clb.master_reset<=1'b0;
    y.clb.P<=4'b1100;
    #10;
end


endmodule