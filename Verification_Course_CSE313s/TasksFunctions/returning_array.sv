module top;

//first method to return an array, use the name of the function
typedef int fixedarray[5];
fixedarray f5;
function fixedarray init(int start);
    foreach(f5[i])begin
        init[i]=i+start;//name of the function
    end
endfunction
//second method to return an array, pass it by reference
function  automatic void  init_ref(ref int arr[],int start);
foreach(arr[i])begin
    arr[i]=i+start;
end

endfunction


endmodule