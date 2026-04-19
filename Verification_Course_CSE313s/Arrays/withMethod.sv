 module arrays();
int count, total, d[] = '{9,1,8,3,4,4}; initial begin
count = d. sum with (int' (item > 7)); Sdisplay (count);
total = d. sum with ((item > 7) = item); Sdisplay(total);
count = d. sum with (int' (item < 8)); $display(count);
total = d. sum with (item < 8 ? item: 0); Sdisplay (total);
 
count= d. sum with (int'(item ==4))
$display(count);
end
endmodule