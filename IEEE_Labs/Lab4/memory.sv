module memory(
    input clk,
    myBus.DUT MB
);
logic [255:0]arr[15:0];//packed to allow the assignement in line 8
initial begin
    foreach(arr[i])begin
        arr[i]=16'(i+1);
    end
end
always @(posedge clk) begin
        if(MB.en)begin
            MB.data<=arr[MB.address];
        end
        else MB.data<=8'bzzzz_zzzz;
end
endmodule
