`timescale 1ns/1ps
module tb;
    logic line;
    logic clk;
    logic reset;
    logic found;
    seq_detector DUT(line,clk,reset,found);
    
    bit queue_input [$];
    bit queue_golden_model[$];
    int counter;
    initial begin
        clk=1'b0;
         forever begin
            #5 clk=~clk;
        end
    end
    initial begin
       
        queue_input={0,0,1,1,0,0,0,1,1,0};
        queue_golden_model={0,0,0,1,0,0,0,0,1,0};
        reset=1'b0;
        counter=0;
        for(int i=0;i<10;i++)begin
        line=queue_input.pop_front();
        #10;
        if(found==queue_golden_model.pop_front())begin
            $display("Matching!");
        end
        else begin
            $display("Not Matching:(");
            counter++;
        end
        end
        $display("Testing finished with %0d errors",counter);
    $stop;
    end
    

endmodule