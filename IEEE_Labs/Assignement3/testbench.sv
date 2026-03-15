`define WIDTH 6
`timescale 1ns/1ps
module tb_ALU;
logic  [`WIDTH-1:0]A;
logic  [`WIDTH-1:0]B;
wire [`WIDTH-1:0]result,result_GM;
wire carry,carry_GM;
wire zero,zero_GM;
enum logic[3:0]{ADD,SUB,AND,OR,XOR,SHIFT_LEFT,SHIFT_RIGHT,MUL} OP;
int counter;

alu      #(`WIDTH) dut    (A,B,OP,result,carry,zero);
alu_gm   #(`WIDTH) golden (A,B,OP,result_GM,carry_GM,zero_GM);
//plan
//for each op we would test it on corner cases
//we would compare the two models
initial begin
    counter=0;
    $display("Testing ADD");
    OP=ADD;
    test;

    $display("Testing SUB");
    OP=SUB;
    test;

    $display("Testing AND");
    OP=AND;
    test;
    
    $display("Testing OR");
    OP=OR;
    test;
    
    $display("Testing XOR");
    OP=XOR;
    test;
    
    $display("Testing Shift_Left");
    OP=SHIFT_LEFT;
    test;
    
    $display("Testing Shift_Right");
    OP=SHIFT_RIGHT;
    test;
    
    $display("Testing MUL");
    OP=MUL;
    test;
    $display("Simulation finished with %0d errors",counter);
    $finish;
end






task test;
int  counter;
counter=0;
    #1
    A=0;
    B=0;
    check;
    #1
    A=-31;
    B= 31;
    check;
    #1
    A=31;
    B=-31;
    check;
    #1
    A=-31;
    B=-31;
    check;
    #1
    A=0;
    B=31;
    check;
    #1
    A=31;
    B=0;
    check;
    #1
    A=15;
    B=20;
    check;
    #1;
endtask
task check;
    if(result!==result_GM)begin
        $error("Expected for result: %0d, Got: %0d Values of A and B are:%0d, %0d ",result_GM, result,A,B);
        counter++;
    end
     if(zero!=zero_GM)begin
        $error("Expected for zero: %0d, Got: %0d Values of A and B are: %0d, %0d",zero_GM,zero, A,B);
        counter++;
    end
     if(carry!==carry_GM)begin
        $error("Expected for carry: %0d, Got: %0d Values of A and B are: %0d, %0d",carry_GM, carry,A,B);
        counter++;
    end
endtask

endmodule

