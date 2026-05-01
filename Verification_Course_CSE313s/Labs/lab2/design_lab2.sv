module seq_detector(
    input line,
    input clk,
    input reset,
    output reg found
);
typedef enum {reset_state,Zero,Zero_One,Zero_One_One}state;
state current_state, next_state;
//fsm for next_state
//fsm for output
//fsm for reset and initial

//reset fsm
always @(posedge clk) begin
    if(reset)begin
        current_state<=reset_state;
    end
    else begin
        current_state<=next_state;
    end
end
//next state fsm
always_comb begin
    next_state=current_state;
    case(current_state)
    reset_state: begin
        if(line==1'b0)begin
            next_state=Zero;
        end
        else next_state=reset_state;
    end
    Zero: begin
        if(line==1'b1)begin
            next_state=Zero_One;
        end
        else next_state=Zero;
    end
    Zero_One:begin
        if(line==1'b1)begin
            next_state=Zero_One_One;
        end
        else next_state=Zero;
    end
    Zero_One_One:begin
        if(line==1'b1)begin
            next_state=reset_state;
        end
        else next_state=Zero;
    end
    default: next_state=reset_state;        
    endcase
end
always_comb begin
    if(current_state==Zero_One_One)begin
        found<=1'b1;
    end
    else found<=1'b0;
end

endmodule