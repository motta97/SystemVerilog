module test;
  byte dt_byte;
  integer dt_integer = 32'b0000_1111_xxxx_ZZZZ;
  int dt_int = dt_integer;
  bit[15:0] dt_bit = 16'h8000;
  shortint dt_short_int1 = dt_bit;
  shortint dt_short_int2 = dt_short_int1-1;
	initial begin
      $display(dt_integer);
      $display(dt_int);
      $display(dt_bit);
      
      $display(dt_short_int1);
      $display(dt_short_int2);
      
      
      
    end


endmodule