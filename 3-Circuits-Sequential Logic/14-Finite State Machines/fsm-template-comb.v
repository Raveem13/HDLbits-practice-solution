module top_module(
    input in,
    input [3:0] state,
    output [3:0] next_state,
    output out); //

    //-------------Internal Constants-----------------
    // 4 states. Uses the following one-hot state encoding: A=4'b0001, B=4'b0010, C=4'b0100, D=4'b1000
    parameter A=0, B=1, C=2, D=3;   

    //-------------Internal Variables-----------------

    // State transition logic: Derive an equation for each state flip-flop.
    assign next_state[A] = state[0]&(~in) | state[2]&(~in);
    assign next_state[B] = state[0]&in | state[1]&in | state[3]&in;
    assign next_state[C] = state[1]&(~in) | state[3]&(~in) ;
    assign next_state[D] = state[2]&in;

    // Output logic: 
    assign out = state[3]&(~in) | state[3]&in ;

endmodule

// State |  Next state  | Output
//       | in=0 | in=1  |
//   A   |   A	 |  B	|   0
//   B   |   C	 |  B	|   0
//   C   |   A	 |  D	|   0
//   D   |   C	 |  B	|   1