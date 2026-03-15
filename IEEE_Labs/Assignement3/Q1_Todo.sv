module fork_queue_advanced_lab; 
 
  int data_q[$];          // queue 
  int result[4];          // store doubled values 
  int prefix_sum[4];      // store prefix sums 
  int monitor[4];         // extra processing 
 int sum;
 int value;
  initial begin 
 
    // TODO 1: 
    // Initialize data_q with the following values: 
    // {5,10,15,20,25} 
    data_q={5,10,15,20,25} ;
 
    for (int i = 0; i < 4; i++ ) begin 

            // TODO 2: 
            // Create a fork...join block that contains THREE parallel processes 
 automatic  int idx=i; 
            sum=0;
            fork
                    begin
                    // ------------------------------------------- 
                    // Process 1: 
                    // -------------------------------------------
                                // TODO 3: 
            // Declare automatic int idx and initialize it with i 
                   
                        // TODO 4: 
                        // Wait #(idx * 3) 
                        #(idx*3);
                        // TODO 5: 
                        // Pop one value from the FRONT of data_q 
                        // Store it in a local variable called value 
                        value = data_q.pop_front();
                        // TODO 6: 
                        // Store (value * 2) in result array of index i 
                        result[i]=value*2;

                    end

                    begin
                        // ------------------------------------------- 
                        // Process 2: 
                        // ------------------------------------------- 
                        
                
                        // TODO 7: 
                        // Wait #(idx * 3 + 1) 
                        #(idx*3+1);
                        // TODO 8: 
                        // Compute the prefix sum of result array 
                        // from index 0 up to idx 
                        // Store it in prefix_sum[idx] 

                        //Prefix sum means the cumulative sum of elements from the beginning of an array up to a certain index.
                        for(int j=i;j>=0;j--)begin
                            sum+=result[j];
                        end
                        prefix_sum[idx]=sum;
                    end
                    begin
                // ------------------------------------------- 
                // Process 3: 
                // ------------------------------------------- 
                
                // TODO 9: 
                // Wait #(idx * 3 + 2) 
                #(idx*3+2);
                // TODO 10: 
                // Store in monitor[idx] : 
                    // prefix_sum[idx]  
                    monitor[idx]=prefix_sum[idx];
                $display("T=%0t | idx=%0d | result=%0d | prefix=%0d | monitor=%0d", 
                            $realtime, idx, result[idx], prefix_sum[idx], monitor[idx]); 
                    end
            join
                begin
                // TODO 13: 
                // After the loop finishes: 
                //   - Display "All iterations completed" 
                //   - Display remaining queue size 
                //   - Display result array 
                //   - Display prefix_sum array 
                //   - Display monitor array 
            $display("All iterations completed!");
            $display("Remaining queue size is: %0d", data_q.size());
            foreach(result[i])begin
                $display("%0d",result[i]);
            end
             foreach(prefix_sum[i])begin
                $display("%0d",prefix_sum[i]);
            end
             foreach(monitor[i])begin
                $display("%0d",monitor[i]);
            end
                end
    end 
 
  end 
 
endmodule