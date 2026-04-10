module top;
task   automatic load_array(int len, ref int arr[]);
    if(len<=0)begin
        $display("Bad length");
        return;
    end
    for(int i =0;i<len;i++)begin
        arr[i]=i*i;
    end

endtask

initial begin
    int arr[];
    arr=new[5];/*note that it has to be dynamic array, because the argument in load_array is
    defined as dynamic*/
    load_array(-1,arr);//should print bad length
    load_array(5,arr);
    $display(arr);
end










endmodule