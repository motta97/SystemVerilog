module shift_reg #(
    parameter WIDTH = 8
)(
    input  logic             clk,
    input  logic             rst_n,
    input  logic             load,      // parallel load
    input  logic             shift_en,  // shift enable
    input  logic             dir,       // 0=left, 1=right
    input  logic [WIDTH-1:0] data_in,   // parallel input
    output logic [WIDTH-1:0] data_out   // parallel output
);
// On reset, data_out clears to 0
// When load=1, data_out takes the value of data_in on the next clock edge (takes priority over shift)
// When shift_en=1 and load=0:

// dir=0 → shift left (MSB shifts out, 0 shifts into LSB)
// dir=1 → shift right (LSB shifts out, 0 shifts into MSB)


// When both load=0 and shift_en=0 → hold current value
always @(posedge clk) begin
    if(!rst_n)begin
        data_out<=0;
    end
    else if(load)begin
        data_out<=data_in;
    end
    else if(shift_en)begin
        if(dir)begin
            //right
            data_out<={0,data_out[WIDTH-1:1]};
        end
        else begin
            //left
            data_out<={data_out[WIDTH-2:0]:0};
        end
    end
    
end












endmodule