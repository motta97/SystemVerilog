package data
class Header();
    int id;
    function new(int id);
        this.id=id;
    endfunction
    function Header copy;
        Header temp;
        temp=new(this.id);
        return temp;

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
    function packet copy;
        packet temp;
        temp=new(this.addr,this.data,this.id);
        temp.h1=this.h1.copy();
        return temp;
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
    p2=p1.copy();
    p1.h1.id=20;//changing this should NOT be visible to p2
  	p1.addr=100;//unvisible to p2
  	p1.data=200;//unvisible to p2
    p1.display();
    p2.display();

end

endmodule