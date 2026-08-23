class random_sequence extends uvm_sequence #(command_sequence_item);

`uvm_object_utils(random_sequence)



function new(string name = "random_sequence");
    super.new(name);
endfunction

task body();
    command_sequence_item cmd_item;
    //note that here we're not passing this, since 'this'
    //should be a uvm_component, and here 'this' is a uvm_object
    
    cmd_item = command_sequence_item::type_id::create("cmd_item");
    start_item(cmd_item);
        assert(cmd_item.randomize());
        cmd_item.rst_n=0;
    finish_item(cmd_item);

    repeat(100)begin
        cmd_item = command_sequence_item::type_id::create("cmd_item");
        start_item(cmd_item);
            assert(cmd_item.randomize());

        finish_item(cmd_item);

    end


endtask






endclass