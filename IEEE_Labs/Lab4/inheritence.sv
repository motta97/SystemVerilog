class parent;
int var1, var2;

endclass
class child extends parent;
int var2,var3;
endclass
module test;
parent p1;
child c1;
initial begin
    p1=new;
    c1=new;
    $display("Values of var1,var2 from parent class are:",p1.var1,p1.var2);
    $display("Values of var1,var2 from child class are:",c1.var1,c1.var2);//this should work fine
    $display("Values of var3,var4 from parent class are:",p1.var3,p1.var4);//this should not
    $display("Value of var3, var4 from child class are:",c1.var2,c2,var3);

end

endmodule