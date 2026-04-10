module top;
task pass_name(
    int a=5,
     b=6,
     c=7
);

$display("%0d",a*b+c);
endtask
initial begin
    int x=5, y=7,z;
    pass_name(.b(x),.c(y));
end


endmodule