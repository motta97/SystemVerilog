cover property @(posedge clk) req|->##2 gnt;
//we have two types of constructs for coverage
//cover property and covergroup

covergroup test_cg @(posedge clk);
coverpoint a{
    bins h = { 3[*4];}
}
endgroup