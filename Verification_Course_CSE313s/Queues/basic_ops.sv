module top;
int q[$]={1,2,3};//note that we don't use the array literal '
int q2[$]={4,5,6,7};
int j=1;


initial begin
    q.insert(1,j);//it should be {1,1,2,3};
    q2.delete(1);//it should be {4,6,7}

    //These operations are fast
    q.push_front(5);
    q.push_back(4);
    j=q.pop_front();
    j=q.pop_back();
    q.delete();
end













endmodule