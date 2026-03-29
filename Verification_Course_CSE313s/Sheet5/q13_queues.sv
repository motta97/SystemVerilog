/*Write a program to choose elements randomly from a queue.
No element should be repeated until all elements are chosen.
Queue may have elements repeated.*/
module top;
int c[$],b[$],a[$]='{1,2,4,2,2,2,4,5,2,5,6,3,4,2,10};
int i;
initial begin
    b=a.unique();
    $display(b);
    while(b.size()>=1)begin
        i = $urandom_range(b.size()-1,0);
        c.push_front(b[i]);
        b.delete(i);
    end
    $display(c);
end
endmodule