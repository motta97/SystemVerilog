module testbench;
logic A,B,S,clk,RST,DUT_OUT;
logic AG,BG,SG,clkG,RSTG,golden_ref_out;
gm g1(AG,BG,SG,clkG,RSTG,golden_ref_out);
Q2_tst DUT(A,B,S,clk,RST,DUT_OUT);
    int i;


initial begin
forever begin
#5 clk=~clk;
end

end


initial begin
RST=1'b1;
@(negedge clk);
if(golden_ref_out==DUT_OUT)begin
$display("Output matched!");
end
else begin

$display("Output mismatched! Expected %b, found %b",DUT_OUT,golden_ref_out );
$stop;
end
RST=1'b0;
@(negedge clk);

if(golden_ref_out==DUT_OUT)begin
$display("Output matched!");
end
else begin

$display("Output mismatched! Expected %b, found %b",DUT_OUT,golden_ref_out );
$stop;
end
for(int i=0; i<16; i++)begin
            {A, B, S, RST} = i;
            {AG, BG, SG, RSTG} = i;

@(negedge clk);
if(golden_ref_out==DUT_OUT)begin
$display("Output matched!");
end
else begin

$display("Output mismatched! Expected %b, found %b",DUT_OUT,golden_ref_out );
$stop;
end
end

$stop;
end



endmodule

