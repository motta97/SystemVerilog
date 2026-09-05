interface counter_ifc(
    input clk
);
  logic         rst_n;
  logic          en;    
  logic          up_down; 
  logic  [7:0]  count;

  

    task load_ifc(
        logic rst_n_s,
            en_s,
            up_down_s
    );

        @(negedge clk);
        rst_n <= rst_n_s;
        en <= en_s;
        up_down <= up_down_s;


    endtask





endinterface