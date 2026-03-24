module test;

string assoc_arr[int];//key of type int, string is what's inside
int i, myfile;
string s;

initial begin
    myfile=$fopen("switch.txt","r");

    while(!$feof(myfile))begin
        $fscanf(myfile,"%d %s",i,s);
        assoc_arr[i]=s;
    end
  if(assoc_arr.exists(7))
    $display("SUIIIIIII");
    else $display("MESSSI MESSI MEESI");
    $fclose("myfile");
    foreach(assoc_arr[i])begin
      $display("arr[%0d] = %s",i,assoc_arr[i]);
    end
    
end
endmodule