module test;
class abc;
static int sum;
function int calc(input int a, input int b);
this.sum=a+b;
return sum;
endfunction

endclass
abc obj1,obj2;

initial begin
    obj1=new();
    obj2=new();
    obj1.calc(20,30);
    obj2.calc(30,40);
    $display("Value of sum in object 1 is: %0d",obj1.sum);
    $display("Value of sum in object 2 is: %0d",obj2.sum);
end
endmodule