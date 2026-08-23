module shift_reg #(parameter size =8)(
     ifc.dut i
);

always @(posedge i.clk or posedge i.rst) begin
    if(i.rst)
        i.q<=0;
    else if(i.load)
        i.q<=i.d;
    else if(i.sr && ! i.sl)
        i.q<= {1'b0,i.q[size-1:1]};
    else if(i.sl && ! i.sr)
       i.q<= {i.q[size-2:0],1'b0};
    
end



endmodule