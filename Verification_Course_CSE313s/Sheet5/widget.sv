class widget;
int id;
bit to_remove;
endclass
module top;
widget q[$];
initial begin
    widget w;
int num = $urandom_range(20,40);
for(int i=0;i<num;i++)begin
    w = new;
    w.id=i;
    w.to_remove=$urandom_range(1,0);
    q.push_back(w);
    $display("widge id: %2d, to_remove: %b",q[$].id,q[$].to_remove);

end
//added code
//note that we can't use foreach here or for loop going forward not backward
//that's because when you delete an element, all elements with indices greater are shifted down by 1
//if you're going backward, no shifting is required.
  for(int i =q.size()-1;i>=0;i--)begin
  if(q[i].to_remove==1'b1)begin 
    q.delete(i);
  end
end
foreach(q[i])begin
    if(q[i].to_remove==1'b1)$display("Found an element with to_remove =1");
end
    
end








endmodule