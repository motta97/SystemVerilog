module test;
int q[$]={1,2,3,4};
initial begin
  $display("All values inside the q are: ",q);
    //insert
    q.insert(1,9); //put it between the 1 and the 2
  $display("All values inside the q are: ",q);
  q.delete(2);//delete element at index 2
  $display("All values inside the q are: ",q);
    q.push_front(10);//same as q.insert(0,10)
    $display("All values inside the q are: ",q);
    q.pop_front();
    $display("All values inside the q are: ",q);
    q.pop_back();
    $display("All values inside the q are: ",q);
    q.push_back(20);
  $display("All values inside the q are: ",q);
    q.delete();
  $display("All values inside the q are: ",q);
    q={50,60,70,80};
    $display("All values inside the q are: ",q);
    q={q[0],40,q[1:$]};//equivalent to q.insert(1,40)
    $display("All values inside the q are: ",q);
    q= q[0:$-1]//equivalent to q.pop_back()
    $display("All values inside the q are: ",q);
    q=q[1:$]//equivalent to q.pop_front()
    $display("All values inside the q are: ",q);

  
end

endmodule