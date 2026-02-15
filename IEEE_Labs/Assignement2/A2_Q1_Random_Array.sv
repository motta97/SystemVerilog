module Array;
  int arr[10];
    int max;
    int min;
    real avg;
    int sum;

    initial begin
        foreach(arr[i])begin
          arr[i]=$urandom_range(100, 0);
        end

        max = arr[0];
        min = arr[0];
        sum=0;

        foreach(arr[i])begin
            if(arr[i]>max)max=arr[i];
            if(arr[i]<min)min=arr[i];
            sum+=arr[i];
        end

        avg=sum/100;

        $display("Max is: %d",max);
        $display("Min is: %d",min);
        $display("Avg is: %f",avg);
    end
endmodule