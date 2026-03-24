package data
class Header();
int id;
function new(int id);
    this.id=id;
endfunction
function display();
$display("ID value is: %0d",id);
endfunction

endclass
class packet();

int addr;
int data;
Header h1;
function new(int addr, int data, int id);
    this.addr=addr;
    this.data=data;
    this.h1.id=id;
endfunction
function display();
$display("Value of addr is: %0d",addr);
$display("Vlaue of data is: %0d",data);
h1.display();
endfunction

endclass
    
endpackage

module sender();

import data::*;
packet p1;
packet p2;

initial begin
    p1=new(50,60,70);
    p2= new p1;//shallow copy
    p1.display();
    p2.display();
end







endmodule