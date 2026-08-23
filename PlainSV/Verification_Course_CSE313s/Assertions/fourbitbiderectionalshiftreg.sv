// Write at least 4 System Verilog Assertions for validating a 4bit bidirectional shift register
// with active low synchronous reset.
//assumptions: data is 1 bit
property synch_reset;
@(posedge clk) !reset|=>shift_reg=4'b0000;
endproperty
property left_in;
@(posedge clk) (left_en && reset && !right_en)
|->shift_reg[0]=data;
endproperty
property right_in;
@(posedge clk) right_en|->shift_reg[3]=data;
endproperty
property left_right;
@(posedge clk) !(right_en&&left_en);
endproperty