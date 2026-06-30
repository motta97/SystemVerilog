module test;

    integer x[512];
    bit[8:0] address;
    x[511]=0;
    my_task(x,address);


    task my_task(ref integer arr[512], bit[8:0]address);
    print_int(arr[--address]);
    endtask
    void function print_int(integer x )
    $display("Array element is: %0d, time is: %0t",x,$time);
    endfunction









endmodule