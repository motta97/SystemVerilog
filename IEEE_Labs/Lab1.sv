`timescale 1ns/1ps
module lab;
  bit flag;
  logic sig;
  byte sb;
  bit [7:0]ub;
  reg r;
  logic l;
  int count;
  time t;
  initial begin
    $display("the value of flag is: %d",flag);
    $display("the value of sig is: %d",sig);
    $display("the value of sb is: %d",sb);
    $display("the value of ub is: %d",ub);
    $display("the value of r is: %d",r);
    $display("the value of l is: %d",l);
    $display("the value of count is: %d",count);
    $display("the value of t is: %d",t);
     sb=-5;
     ub = -5;
     $display("the value of sb is: %d",sb);
    $display("the value of ub is: %d",ub);
    l=1;
    r = 1;
    #10
    $display("the value of count is: %d",count);
    $display("the value of time is: %d",t);
    $finish;
    
    
    
    
  end
  
  
  
endmodule