property p;
@(posedge clk)
a |=>##[0:$] b
endproperty

assert property(p)