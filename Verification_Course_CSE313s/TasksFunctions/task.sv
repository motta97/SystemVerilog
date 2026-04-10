module top;

    //first style
    task shift;
        output x;
        reg[31:0]x;
        input y;
        reg [31:0]y; //note that for tasks inputs can be regs! unlike for modules
        x=y<<2;
    endtask
    //second style, more compact
    task shift_ss(
        output reg[31:0]x,
        input reg[31:0]y
    );
        x=y<<2;
    endtask
    initial begin
        int a, b=12;
        shift(a,b);
        $display("Values are: %0d, %0d",a,b);

    end
endmodule