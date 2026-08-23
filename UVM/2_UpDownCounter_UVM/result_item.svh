class result_item extends uvm_transaction;
`uvm_object_utils(result_item)
shortint result;

function new(string name ="result_item");
    super.new(name);
endfunction

function void do_copy(uvm_object rhs);

    result_item copy;
    if(rhs == null)
        `uvm_fatal("result_item", "trying to copy a null pointer");
    if(!$cast(copy, rhs))
        `uvm_fatal("result_item", "incompatible types");
    super.do_copy(rhs);
    this.result = copy.result;

endfunction

function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    bit same = 0;
    result_item temp;
    if(rhs == null)
        `uvm_fatal("result_item", "trying to compare a null pointer");
    if(!$cast(temp, rhs))
        return same;
    
    return super.do_compare(rhs, comparer) &&
            (this.result == temp.result);


endfunction

function string convert2string();
    string temp = $sformatf("Result: %0d", result);
    return temp;
endfunction





endclass