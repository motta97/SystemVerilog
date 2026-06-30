module up_counter (
    ifc.dut ifc_dut

);
// Behavior:

// On reset (rst_n = 0), count goes to 0 synchronously
// When en = 1, counter increments by 1 every rising clock edge
// When en = 0, counter holds its value
// Counter wraps around from 15 → 0 naturally
always @(posedge ifc_dut.clk) begin
        if(!ifc_dut.rst_n)begin
            ifc_dut.count<=4'b0000;
        end
        else if(ifc_dut.en)begin
            ifc_dut.count<=ifc_dut.count+1;
        end
        //if not reset and not ifc_dut.enable, thifc_dut.en keep the currifc_dut.ent value
    end

endmodule