module decade_counter(
decade_ifc ifc
);
always@(ifc.master_reset)begin
    ifc.q<=4'b0000;
end

always @(posedge ifc.clk) begin
    if(!ifc.master_reset)begin
        if(ifc.load)begin
            ifc.q<=ifc.p;
        end
        else if(ifc.enable)begin
            ifc.q<=(ifc.q+1)%10;//decade counter
        end
    end
end

endmodule