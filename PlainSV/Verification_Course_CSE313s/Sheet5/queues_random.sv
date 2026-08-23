/*Write a program to choose elements randomly from a queue.
No element should be repeated until all elements are chosen.
Queue may have elements repeated.*/

module top;
int q[$];
int q_unique;
int assoc[*];
int size;
int rand_num;
int flag;
initial begin
    flag=0;//we didn't finsih all items
    size=10;
    //initializing the array with random elements
    for(int i=0;i<size;i++)begin
        rand_num=$urandom_range(100,1);
        q.push_back(rand_num);//queue may have elements repeated.
        assoc[rand_num]=rand_num;
    end
    for(int i=0;i<size;i++)begin
        rand_num=$urandom_range(100,1);
        if(assoc.exists(rand_num))q_unique.push_back(rand_num);
    end



end









endmodule
