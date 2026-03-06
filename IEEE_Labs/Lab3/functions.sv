//a function can be outside or inside the module
//functions outside modules are static by default
//static functions can't have passed by ref arguments
//if you want it to be outside the module and a package , you make it automatic
//standard way is to use packages
package lab2;
    function int sum_value(int a, int b);
        return a+b;
    endfunction
    function  int modify(ref int a, ref int b);
        a+=10;
        b+=20;
      return 0;
    endfunction
endpackage


module test;
import lab2::*;
    int a,b,result;
    initial begin
        a=10;
        b=20;
    $display("a= %0d, b= %0d",a,b);
    $display("The sum of a and b is: %0d",sum_value(a,b));
    result = modify(a,b);
    $display("Values of a and b after modification: a=%0d, b=%0d",a,b);
    end
endmodule