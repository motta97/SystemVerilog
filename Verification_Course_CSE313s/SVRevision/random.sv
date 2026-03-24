module test;
  int assoc_arr[int];
int mykey;
initial begin
    for(int i =0;i<50;i++)begin
        assoc_arr[$urandom_range(100,1)]=i;
    end
  if(assoc_arr.exists(2))begin
        $display("Key 2 Exists!");
    end
    else begin
        $display("Key 2 Doesn't exist :(");
    end
  if(assoc_arr.exists(45))begin
        $display("Key 45 Exists!");
    end
    else begin
        $display("Key 45 Doesn't exist :(");
    end
    assoc_arr.first(mykey);
  $display("value at first index %0d is %0d",mykey, assoc_arr[mykey]);
end
endmodule