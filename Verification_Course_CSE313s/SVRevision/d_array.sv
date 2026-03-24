module test;
int dt_arr[];
int dt_arr_copy[];
initial begin
  dt_arr=new[10];
    foreach(dt_arr[i])begin
        dt_arr[i]=$random();
    end
  $display($size(dt_arr));
    foreach(dt_arr[i])begin
        $display(dt_arr[i]);
    end
    dt_arr_copy=dt_arr;
    dt_arr=new[20](dt_arr);
end
endmodule