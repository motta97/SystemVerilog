module test;
int arr[]={5,4,220,1,-5,70,33,10,0,8};
initial begin
    $display("Values of the array are: ",arr);
    arr.sort();
    $display("Sorting....");
    $display("Values of the array are: ",arr);
    arr.shuffle();
    $display("Shuffeling....");
    $display("Values of the array are: ",arr);
    arr.rsort();
    $display("Reverse ordering....");
    $display("Values of the array are: ",arr);
    arr.reverse();
    $display("Reversing without order....");
    $display("Values of the array are: ",arr);
end
endmodule