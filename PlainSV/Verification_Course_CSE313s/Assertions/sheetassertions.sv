// Write a System Verilog assertion to check the following: 
// If there are two occurrences of “a” rising while  state = ACTIVE, and no “b” occurs 
// between them, then within 3 cycles of the second rise of “a”, START must occur.
assert property (
    @(posedge clk) ($rose(a) && state=ACTIVE) [->2] intersect (!b[*1:$])
    |-> ##[1:3] state=START;
)

// Write a System Verilog assertion to check the following: 
// Every “a” must eventually be acknowledged by “b”, unless “c” appears any time 
// before “b” appears.
assert property
    (
        @(posedge clk) a |-> !c s_until b;//means !c has to be true until b is evaluated to true. 
        //if !c became false that no need for evaluating b, and the expresssion evaluates to true
    )

// Write a System Verilog assertion to check the following: 
// Every time the request req goes high, gnt arrives exactly 3 clocks later. If this is 
// not achieved an error is reported with the message: “no grant after request”. 
// But this assertion should only be checked if the reset signal, rst, is not active. 
assert property(
    
    @(posedge clk) 
    disable iff(rst)//assuming rst is active high
    $rose(req) |-> ##3 gnt;
)
else begin
    $error("no grant after request");
end

//  Write a System Verilog assertion to check the following: 
// If a signal “a” is high on a given posedge of the clock, the signal “b” should be 
// high for 3 clock cycles followed by “c” that should be high after “b” is high for the 
// third time. During this entire sequence, if reset is detected at any point, the 
// checker will stop. 
assert property (
    @(posedge clk)
    disable iff(reset)
    a|-> b[*3] ##1 c;
)

// Write a System Verilog assertion to check the following: 
// A request “req” is high for one or more cycles, then returning to zero, is followed 
// after one or more cycles, by an acknowledge, “ack” for one or more cycles before 
// “ack” returns to zero. “ack” must be zero in the cycle in which “req” returns to 
// zero. During this entire sequence, if reset is detected at any point, the checker will 
// stop. 
assert property(
    @(posedge clk)
    disable iff(reset)
    $rose(req) |-> ##[1:$]ack ##[1:$]!ack;
)