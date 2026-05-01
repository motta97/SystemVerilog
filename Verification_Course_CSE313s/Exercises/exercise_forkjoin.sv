module top;

int new_address1,new_address2;
bit clk;
initial begin
    new_address1=0;
    new_address2=0;
    clk=0;
    fork
    my_task2(21,new_address1);
    my_task2(20,new_address2);
    join 
        $display("new_address1= %0d",new_address1);
        
        $display("new_address2= %0d",new_address2);

    #100 $finish;
end
initial begin
    forever begin
        #50
        clk=~clk;
    end
end
task automatic my_task2(input int address, output int new_address);

@(clk);
new_address=address;



endtask
//if my_task2 is static, the output would be 20 for both, since last call modifies
//new_address 1
//if atutomatic, it would produce differernt values











endmodule