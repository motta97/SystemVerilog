module test;
class exercise2;
rand bit[7:0]data;
rand bit[3:0]address;
constraint c{
    data==5;
    address dist{0:=10, [1:14]:/80, 15:=10};
}
endclass
exercise2 ex;
initial begin
    int count[16];
    ex=new();
    repeat(1000)begin
        if(ex.randomize)begin
            $display("Success, Values are: %0d,%0d",ex.data,ex.address);
            count[ex.address]++;
        end
        else $display("Randomization Failed");
    end
    //creating the histogram, to check for the percentages
    for(int i=0;i<16;i++)begin
        $write("Value %0d ",i);
        for(int j=0;j<count[i];j++)begin
            $write("#");
        end
        $write(" %0d %%", real'((count[i]*100)/1000));
        $display(" ");
    end
    //it doesn't show the percentages perfectly since to get the exact percentages we need to run for infinite number of iterations
    //as # interations increase as we get more accurate percentages
    // # KERNEL: Value 0 ####################################################################################################### 10 % 
    // # KERNEL: Value 1 ################################################# 4 % 
    // # KERNEL: Value 2 ################################################### 5 % 
    // # KERNEL: Value 3 ################################################### 5 % 
    // # KERNEL: Value 4 ############################################### 4 % 
    // # KERNEL: Value 5 ############################################ 4 % 
    // # KERNEL: Value 6 ################################################################ 6 % 
    // # KERNEL: Value 7 ##################################################### 5 % 
    // # KERNEL: Value 8 ################################################################ 6 % 
    // # KERNEL: Value 9 ########################################################### 5 % 
    // # KERNEL: Value 10 ###################################################################### 7 % 
    // # KERNEL: Value 11 ######################################################### 5 % 
    // # KERNEL: Value 12 ####################################################### 5 % 
    // # KERNEL: Value 13 ############################################### 4 % 
    // # KERNEL: Value 14 ################################################################ 6 % 
    // # KERNEL: Value 15 ########################################################################################################################## 12 % 
end
endmodule