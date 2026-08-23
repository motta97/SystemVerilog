class scoreboard extends uvm_component;
    `uvm_component_utils(scoreboard)


    shortint prev_count= 0;
    result_item predicted_result;
    uvm_tlm_analysis_fifo #(result_item) result_fifo;
    uvm_tlm_analysis_fifo #(command_sequence_item) cmd_fifo;
    result_item actual_result;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        result_fifo= new("result_fifo",this);
        cmd_fifo = new("cmd_fifo", this);
        predicted_result = result_item::type_id::create("predicted_result");
    endfunction
    task  run_phase(uvm_phase phase);

        command_sequence_item cmd;
        result_item actual_result;
        forever begin
            cmd_fifo.get(cmd);
            result_fifo.get(actual_result);
        
        if(!cmd.rst_n)
            predicted_result.result=0;
        else if(cmd.en)begin
            if(cmd.up_down)
                predicted_result.result = (prev_count+1)%256;
            else
                predicted_result.result = (prev_count-1+256)%256;
        end 
        if(!predicted_result.compare(actual_result))begin
            string error = $sformatf("rst_n = %0d, en = %0d, up_down = %0d, prev_value = %0d, current_value = %0d, expected_value = %0d",
                                    cmd.rst_n, cmd.en, cmd.up_down, prev_count, actual_result.result, predicted_result.result);

            `uvm_error("scoreboard",error )
        end
        else begin
            string pass = $sformatf("rst_n = %0d, en = %0d, up_down = %0d, prev_value = %0d, current_value = %0d, expected_value = %0d",
                                    cmd.rst_n, cmd.en, cmd.up_down, prev_count, actual_result.result, predicted_result.result);
            `uvm_info("scoreboard", pass, UVM_LOW)
        end
        prev_count = predicted_result.result;
        end

    endtask

    // function void write(command_sequence_item t);

    //     if(!result_fifo.get(actual_result))
    //         `uvm_fatal("scoreboard", "failed to get an item from the fifo")


    //     if(!t.rst_n)
    //         predicted_result.result=0;
    //     else if(t.en)begin
    //         if(t.up_down)
    //             predicted_result.result = (prev_count+1)%256;
    //         else
    //             predicted_result.result = (prev_count-1)%256;
    //     end
    //     predicted_result.result = prev_count;

    //     if(!predicted_result.compare(actual_result))begin
    //         string error = $sformatf("rst_n = %0d, en = %0d, up_down = %0d, prev_value = %0d, current_value = %0d, expected_value = %0d",
    //                                 t.rst_n, t.en, t.up_down, prev_count, actual_result.result, predicted_result.result);

    //         `uvm_error("scoreboard",error )
    //     end
    //     prev_count = predicted_result.result;

    // endfunction


endclass