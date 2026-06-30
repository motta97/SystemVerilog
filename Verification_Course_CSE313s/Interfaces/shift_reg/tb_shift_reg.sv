program test #(parameter size = 8) (ifc.tb x);
initial begin
    x.rst=0;
    x.sr=0;
    x.sl=0;
    x.d=125;
    x.load=0;
    #3 x.load=1;
    #5 x.load =0;
end
initial begin
    #62 x.rst=1;
    #3 x.rst = 0;

end
initial begin
    #14 x.sr=1;
    #23 x.sr =0;
    #3 x.sl =1;
    #12 x.sl =0;
end

endprogram