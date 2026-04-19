module top;
int dyn[],dyn2[];
initial begin
    dyn=new[5];
    foreach(dyn[i])
        dyn[i]=i;
    dyn2=dyn;
    dyn2[0]=5;
    $display(dyn[0],,dyn2[0]);//they're separate
    dyn2=new[20](dyn);//copy the old values into the first 5 elements
    dyn2=new[20];//deallocate old values
    dyn2.delete();//delete the element


end






endmodule