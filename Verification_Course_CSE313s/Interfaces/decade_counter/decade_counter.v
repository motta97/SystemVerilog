module decade_counter(
    input [3:0] p,
    input load,
    input enable,
    input clk,
    input master_reset,
    output reg [3:0]q
);
always@(master_reset)begin
    q<=4'b0000;
end

always @(posedge clk) begin
    if(!master_reset)begin
        if(load)begin
            q<=p;
        end
        else if(enable)begin
            q<=(q+1)%10;//decade counter
        end
    end
end

endmodule