module test;
int arr[]='{1,2,8,3,4,5,6,7,8,9,9,10};
int tq[$];

initial begin
    
    tq=arr.find with (item>5);//return values
    $display("Values of tq are: ",tq);
    tq=arr.find_index with (item>5);//return indices
    $display("Values of tq are: ",tq);
    tq=arr.find_last with (item>7 );//return values
    $display("Values of tq are: ",tq);
    tq=arr.find_last_index with (item>7);
    $display("Values of tq are: ",tq);
    tq=arr.find_first with (item>7);
    $display("Values of tq are: ",tq);
    tq=arr.find_first_index with (item>7);
    $display("Values of tq are: ",tq);
    



end








endmodule