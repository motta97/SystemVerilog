module sync_fifo #(
    parameter DEPTH = 8,
    parameter WIDTH = 8
)(
    ifc.dut ifc_dut
);
    // Behavior:

    // On reset, FIFO is cleared and both ifc_dut.full=0, ifc_dut.empty=1
    // When ifc_dut.wr_en=1 and not ifc_dut.full, data is written and stored
    // When ifc_dut.rd_en=1 and not ifc_dut.empty, data is read out
    // If ifc_dut.wr_en=1 while ifc_dut.full → write is ignored (no overflow)
    // If ifc_dut.rd_en=1 while ifc_dut.empty → read is ignored (no underflow)
    // Simultaneous ifc_dut.wr_en and ifc_dut.rd_en while neither ifc_dut.full nor ifc_dut.empty → both happen (data written and read in same cycle)
    // ifc_dut.full and ifc_dut.empty flags must always be accurate

    logic [$clog2(DEPTH):0]count;
    reg [$clog2(DEPTH)-1:0]rd_pointer; 
    reg [$clog2(DEPTH)-1:0]wr_pointer;//pointer to the next free location
    reg [DEPTH-1:0][WIDTH-1:0]reg_file;
    always @(posedge ifc_dut.clk) begin
        if(!ifc_dut.rst_n)begin
            rd_pointer<=0;
            wr_pointer<=0;
            count<=0;//number of full items

        end
        else if(ifc_dut.rd_en && ifc_dut.wr_en)begin
            //read operation
            if(!ifc_dut.empty)begin
                ifc_dut.rd_data<=reg_file[rd_pointer];
                rd_pointer<=(rd_pointer+1)%DEPTH;
            end
            //write operation
            if(!ifc_dut.full)begin
            reg_file[wr_pointer]<=ifc_dut.wr_data;
            wr_pointer<=(wr_pointer+1)%(DEPTH); 
            end
            case ({!ifc_dut.empty,!ifc_dut.full})
                2'b10:
                    count<=count-1;
                2'b01:
                    count<=count+1;
                default: count<=count;
            endcase
        end
        else if(ifc_dut.rd_en)begin
            if(!ifc_dut.empty)begin
                count<=count-1;
                ifc_dut.rd_data<=reg_file[rd_pointer];
                rd_pointer<=(rd_pointer+1)%DEPTH;
            end
        end
        else if(ifc_dut.wr_en)begin
            if(!ifc_dut.full)begin
            count<=count+1;
            reg_file[wr_pointer]<=ifc_dut.wr_data;
            wr_pointer<=(wr_pointer+1)%(DEPTH); 
            end
        end
    end
    assign ifc_dut.empty=(count==0);
    assign ifc_dut.full=(count==DEPTH);

endmodule