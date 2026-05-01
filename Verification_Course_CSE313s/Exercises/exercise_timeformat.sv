/*
create a code to specify that the time should be printed in ps, display 2 digits
to the right of the decimal point, and use as few characters
as possible.
*/
`timescale 1us/1ps;
module top;
initial begin
  $timeformat(-12,2," picoseconds",0);
#10;
$display("current simulation time is: %t",$time);

end


endmodule