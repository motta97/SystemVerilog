module top;
int d[][];
initial begin
    d=new[7];
    foreach(d[i])begin
        d[i]=new[i+1];
    end
    foreach(d[i,j])begin
        d[i][j]=i*10+j;
    end
    foreach(d[i])begin
        $display(d[i]);
    end
end











endmodule