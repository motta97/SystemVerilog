module sstrct;
    typedef struct {
        bit [7:0] src;
        bit [7:0] dst;
        bit [15:0] length;
        bit [31:0] data;
    }packet;
    int sum_ln;
    int sum_src_dst;
    packet [100]arr;
    initial begin

        foreach(arr[i])begin
            arr[i].src=$urandom();
            arr[i].dst=$urandom();
            arr[i].length=$urandom();
            arr[i].data=$urandom();
        end

        foreach(arr[i])begin
            $display("Values of packet at index %d: src: %b dst: %b length: %b data: %b", i, arr[i].src, arr[i].dst,
            arr[i].length, arr[i].data);
        end
        foreach(arr[i])begin
            if(arr[i].length>1000)sum_ln+=1;
            if(arr[i].src==arr[i].dst)sum_src_dst+=1;
        end
        $display("We have %d packet(s) having length > 1000",sum_ln);
        $display("We have %d packet(s) having src = dst",sum_src_dst);

    end
endmodule