module top;
    int arr[512];
    bit [8:0]index;
    int address;
    initial begin
        arr[511]=5;
        address=512;
        my_task(arr,address);
    end

    task automatic my_task(ref int arr[512],int address);
        print_int(arr[--address]);
    endtask

    function print_int(int element);
        $display("time of the simulation is: %0t",$time);
        $display("Value of the element is:%0d",element);
    endfunction


endmodule