class command_sequence_item extends uvm_sequence_item;
    `uvm_object_utils(command_sequence_item)
    rand bit en;
    rand bit rst_n;
    rand bit up_down;

    bit same = 0;
    constraint c{
        en dist {1:=90, 0:=10};
        rst_n dist {1:=90, 0:=10};
    };
    function new(string name="command_sequence_item");
        super.new(name);
        // temp = command_sequence_item::type_id::create("temp",this);
    endfunction
    function void do_copy(uvm_object rhs);
        command_sequence_item copy;
        if(rhs==null)
            `uvm_fatal("command_sequence_item","copying to a null item");
        if(!$cast(copy, rhs))
            `uvm_fatal("command_sequence_item", "incompatible types");
        
        super.do_copy(rhs);
        this.en = copy.en;
        this.rst_n = copy.rst_n;
        this.up_down = copy.up_down;
    endfunction
    function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    command_sequence_item temp;
        if(rhs==null)
            `uvm_fatal("command_sequence_item", "trying to compare a null pointer")    

        
        if(!$cast(temp,rhs))
            return same;
        
        
        same =  super.do_compare(rhs, comparer)&&
                (temp.en == this.en) &&
                (temp.up_down == this.up_down)&&
                (temp.rst_n == this.rst_n);
        
        return same;
    endfunction

    function string convert2string();
        string temp = $sformatf("En = %0d, rst_n = %0d, up_down = %0d",en,rst_n,up_down);
        return temp;
    endfunction



endclass