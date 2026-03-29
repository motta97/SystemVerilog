module top;

int arr[20][30];
initial begin
    foreach(arr[i,j])begin
       arr[i][j]=i*j;
    end
    foreach(arr[i,j])begin
        $write("%2d",arr[i][j]);
    end
end

endmodule