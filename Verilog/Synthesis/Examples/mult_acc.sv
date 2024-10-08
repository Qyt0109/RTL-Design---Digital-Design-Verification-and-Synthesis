
//  The following code implements a parameterizable Multiply-accumulate unit
//  with synchronous load to reset the accumulator without losing a clock cycle
//  Size of inputs/output should be less than/equal to what is supported by the architecture else extra logic/dsps will be inferred
parameter SIZEIN = <sizein>;     // width of the inputs
parameter SIZEOUT = <sizeout>;   // width of output
wire_or_reg <clk>;               // clock
wire_or_reg <ce>;                // clock enable
wire_or_reg <sload>;             // synchronous load
wire_or_reg signed [SIZEIN-1:0]   <a>;  // 1st input to multiply-accumulate
wire_or_reg signed [SIZEIN-1:0]   <b>;  // 2nd input to multiply-accumulate
wire_or_reg signed [SIZEOUT-1:0] <accum_out>; // output from multiply-accumulate

// Declare registers for intermediate values
reg signed [SIZEIN-1:0]   <a_reg>, <b_reg>;
reg                       <sload_reg>;
reg signed [2*SIZEIN-1:0] <mult_reg>;
reg signed [SIZEOUT-1:0]  <adder_out>, <old_result>;

always @(<sload_reg> or <adder_out>)
begin
 if (<sload_reg>)
    <old_result> <= 0;
 else
    // 'sload' is now and opens the accumulation loop.
    // The accumulator takes the next multiplier output
    // in the same cycle.
    <old_result> <= <adder_out>;
end

always @(posedge <clk>)
 if (<ce>)
  begin
    <a_reg>     <= <a>;
    <b_reg>     <= <b>;
    <mult_reg>  <= <a_reg> * <b_reg>;
    <sload_reg> <= <sload>;
    // Store accumulation result into a register
    <adder_out> <= <old_result> + <mult_reg>;
 end

// Output accumulation result
assign <accum_out> = <adder_out>;
				
				