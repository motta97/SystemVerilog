class transaction;
rand bit [3:0] p;
rand bit [2:0] k;
endclass

module test;
    transaction tr;
    bit clk;
    int running;
    covergroup covport;
    option.per_instance=1;
    cp1: coverpoint ( 5'(tr.p) + 5'(tr.k) + 5'b00000){
        bins items[]={[0:22]};//since max value is 15+7 =22
    }
    endgroup

initial begin
    while(running)
        #5 clk=~clk;
end
    

    

   
    initial begin
        covport c=new();
        tr = new();

        //declarations must preceeds statements
        clk=1'b0;
        running=1;
        repeat(2000)begin
            
            assert(tr.randomize);
            c.sample();
            @(posedge clk);
        end
        running =0;
    end
endmodule


