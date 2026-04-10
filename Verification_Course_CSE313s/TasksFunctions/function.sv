module top;

    function automatic  print_checksum(const ref bit [31:0] a[]);
    //it has to be automatic, because we're passing by ref
    //functions inside module are static by default
    bit[31:0] checksum=0;
    foreach(a[i])
        checksum^=a[i];
        $display("check sum of your input is: %0d",checksum);
    endfunction
    initial begin
        bit[31:0]w[]='{5,42,90};
        print_checksum(w);
    end

endmodule