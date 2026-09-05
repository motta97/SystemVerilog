module counter (
  input         clk,
  input         rst_n,
  input          en,      // count enable
  input          up_down, // 1 = up, 0 = down
  output reg [7:0]  count
);


always @(posedge clk) begin
    if(!rst_n)begin
        count<=0;
    end
    else if(en)begin
        if(up_down)
            count<=count+1;
        else if(!up_down)
            count<=count-1;
    end
    else
        count<=count;
    $strobe("VALUES ARE: rst_n = %0d, up_down = %0d, en = %0d, count = %0d at time: %0f",rst_n, en, up_down, count, $time);
end






endmodule