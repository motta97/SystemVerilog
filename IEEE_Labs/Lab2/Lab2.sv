module tb;
int test[string];
initial begin
test["ECE"]=85;
test["CSE"]=92;
test["MEC"]=78;
foreach(test[i])begin
test[i]+=5;
end
end

delete test["MEC"];

foreach(test[i])begin
$display("student %s has score of %d",i,test[i]);
end

$display("size of the array is: %d",test.num());
endmodule
