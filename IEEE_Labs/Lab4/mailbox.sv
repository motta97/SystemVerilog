module test;
//let's create first typeless with no bounds
mailbox mbx1,mbx2;
mailbox #(string) mbx3,mbx4;
initial begin
    mbx1=new;//typeless and unbounded
    mbx1.put("Hello");
    mbx1.put(55);
    mbx2=new(5);//typeless and bounded
    mbx2.put("Hello");
    mbx2.put(55);

    mbx3=new(5);//parameterized and bounded
    mbx3.put("Only strings are allowed, but my size is limited to 5");

    mbx4=new;//parametrized and unboudned
    mbx4.put("As mbx3, only strings but I can take unlimited messages")
end














endmodule