module testbench(myBus.TB bus);

initial begin
    bus.en=1'b1;
    bus.address=8'b0000_0000;
    #15;
    if(bus.data==8'b0000_0001)$display("Success");
    else $display("Failed :(");
    #15;
        bus.address=8'b0000_0001;
    #15;
    if(bus.data==8'b0000_0010)$display("Success");
    else $display("Failed :(");

    bus.en=1'b0;
    #15;
    if(bus.data===8'bzzzz_zzzz)$display("Success");
    else $display("Failed :(");
    $finish;
end
endmodule