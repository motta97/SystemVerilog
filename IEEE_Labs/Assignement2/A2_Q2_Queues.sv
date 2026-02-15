module queue;
    int temp;
    int queue[$];
    initial begin
        repeat(20)begin
        queue.push_back($urandom);
        end
        while (queue.size()!=0) begin
            temp = queue.pop_front();
            $display("Queue value is: %d",temp);
        end
    end
endmodule