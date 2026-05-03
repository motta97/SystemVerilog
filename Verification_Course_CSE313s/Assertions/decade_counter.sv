module decade_counter(ifc x);

always @(posedge x.clk) begin
    if(x.master_reset)begin
        x.Q=4'b0000;
    end
    else if(x.load)begin
        x.Q=x.P+1;//this's the bug, hoping assertion can find it
    end
    else if(x.enable)begin
        x.Q=(x.Q+1)%10;//counting from 0 to 9 only
    end
end

endmodule