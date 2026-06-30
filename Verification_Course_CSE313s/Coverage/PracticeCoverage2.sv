module test;
class transaction;
rand bit [3:0] only_0_to_5;
endclass

transaction tr;
covergroup covport;
option.auto_bin_max=8;
coverpoint tr.only_0_to_5{
    ignore_bins high= {[6:15]};
}
endgroup
endmodule
// In
// the above code sample, eight bins are initially created using the auto_bin_max
// option: [0:1], [2:3], [4:5], [6:7], [8:9], [10:11], [12:13], [14:15],
// • However, then the 5 uppermost bins are eliminated by ignore_bins, and so at the
// end only three bins are created. This cover point can have coverage of 0%, 33%,
// 66%, or 100%.