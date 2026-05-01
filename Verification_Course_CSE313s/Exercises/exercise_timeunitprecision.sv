/*
what is displayed by the following code
# KERNEL: 1                 5000
# KERNEL: 2                 5000
# KERNEL: 1                10500
# KERNEL: 2                11000
# KERNEL: 1                15500
# KERNEL: 2                16000
# KERNEL: 1                21000
# KERNEL: 2                21000
*/
module top;
timeunit 1ns;
timeprecision 1ps;
parameter real t_real = 5.5;
parameter time t_time = 5.5ns;
initial begin
    #t_time $display("1 %t",$realtime);
    #t_real $display("1 %t",$realtime);
    #t_time $display("1 %t",$realtime);
    #t_real $display("1 %t",$realtime);
end
initial begin
    #t_time $display("2 %t",$time);
    #t_real $display("2 %t",$time);
    #t_time $display("2 %t",$time);
    #t_real $display("2 %t",$time);
end










endmodule