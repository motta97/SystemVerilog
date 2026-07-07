class shift_reg_tx;
    int WIDTH;
    rand bit rst_n;
    rand bit load;
    rand bit shift_en;
    rand bit dir;
    rand bit [WIDTH-1:0]data_in;

    constraint c{
        rst_n dist{1:=90, 0:=10};
    }
    function new(int WIDTH);
        this.WIDTH=WIDTH;
    endfunction
    

endclass
class monitor(
    ifc ifc_monitor
);

shift_reg_







endclass