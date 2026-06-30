package transaction_pkg;
    class tb_transaction;
        int WIDTH = 8;
        rand bit rst_n;
        rand bit wr_en;
        rand bit rd_en;
        rand bit [WIDTH-1:0]wr_data;
        constraint c{
            rst_n dist{1:=90, 0:=10};
        };
      function new(int WIDTH);
            this.WIDTH=WIDTH;
        endfunction
    endclass
    
    class monitor_transaction;
        int WIDTH = 8;
        int DEPTH = 8;
        logic             rst_n;
        logic             wr_en;
        logic             rd_en;
        logic [WIDTH-1:0] wr_data;
        logic [WIDTH-1:0] rd_data;
        logic             full;
        logic             empty;

        function new(int WIDTH, int DEPTH);
            this.WIDTH=WIDTH;
            this.DEPTH=DEPTH;
        endfunction

    endclass

    class monitor;
        int WIDTH = 8;
        int DEPTH = 8;

        ifc ifc_monitor;
        mailbox #(monitor_transaction)mon2sp;
        monitor_transaction tr;

        function new(ifc ifc_monitor, mailbox #(monitor_transaction) mon2sp
        , int WIDTH, int DEPTH
        );
            this.WIDTH=WIDTH;
            this.DEPTH=DEPTH;
            this.ifc_monitor=ifc_monitor;
            this.mon2sp=mon2sp;
        endfunction

        task run();
            forever begin
                @(posedge ifc_monitor.clk);
                if(ifc_monitor.rd_en || ifc_monitor.wr_en || !ifc_monitor.rst_n)begin
                    tr = new(WIDTH,DEPTH);
                    tr.rst_n=ifc_monitor.rst_n;
                    tr.rd_en=ifc_monitor.rd_en;
                    tr.wr_en=ifc_monitor.wr_en;
                    tr.wr_data=ifc_monitor.wr_data;
                    tr.rd_data=ifc_monitor.rd_data;
                    tr.full=ifc_monitor.full;
                    tr.empty=ifc_monitor.empty;

                    mon2sp.put(tr);
                end
            end





        endtask



    endclass
    class scoreboard;
        mailbox #(monitor_transaction) m2sb;
        int WIDTH = 8;
        int DEPTH = 8;
        monitor_transaction tr;
        logic [DEPTH-1:0] queue[$];
        function new(int WIDTH, int DEPTH, mailbox #(monitor_transaction) m2sb);
            this.WIDTH=WIDTH;
            this.DEPTH=DEPTH;
            this.m2sb=m2sb;
        endfunction

        task run();
        forever begin
            tr = m2sb.get();
            if(tr.rst_n== 1)begin
                if (tr.wr_en && tr.rd_en) begin
                    if (!tr.empty)                     
                        if(queue.size!=0)begin
                            if(queue.pop_front()!=tr.rd_data)
                                $error("SCOREBOARD ERROR");
                        end

                    if (!tr.full)  queue.push_back(tr.wr_data);
                end
                if(tr.rd_en && !tr.empty)begin
                    if(queue.size!=0)begin
                        if(queue.pop_front()!=tr.rd_data)
                            $error("SCOREBOARD ERROR");
                    end
                end
                if(tr.wr_en && !tr.full)begin
                    queue.push_back(tr.wr_data);
                end
            
            end
            else
                queue.delete();
        end
       







        endtask


    endclass










    
endpackage