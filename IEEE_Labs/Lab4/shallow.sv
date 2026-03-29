package data_class;
class Header;
int id;
function new(int id);
    this.id=id;
endfunction
function display();
$display("ID value is: %0d",id);
endfunction

endclass
class packet;

int addr;
int data;
Header h1;
  function new(int addr, int data, int id);
    h1=new(id);//default value
    this.addr=addr;
    this.data=data;
endfunction
function display();
$display("Value of addr is: %0d",addr);
$display("Vlaue of data is: %0d",data);
h1.display();
endfunction

endclass
    
endpackage

module sender;

import data_class::*;
packet p1;
packet p2;

initial begin
    p1=new(50,60,70);
    p2= new p1;//shallow copy
  	p1.h1.id=20;//changing this should be visible to p2
  	p1.addr=100;//unvisible to p2
  	p1.data=200;//unvisible to p2
    p1.display();
    p2.display();
end







endmodule