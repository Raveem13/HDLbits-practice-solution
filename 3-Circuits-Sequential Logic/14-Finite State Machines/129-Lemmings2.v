module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
    //-------------Internal Constants-----------------
	parameter FL=1, FR=2 , WL=4, WR=8;  // States : FallLeft, FallRight, WalkLeft, WalkRight
    //-------------Internal Variables-----------------
    reg [3:0] state, next_state; //Used one hot encoding, 4 state bits required for 4 states.

    // State transition logic - Combinational Logic
    always @(*) begin
        case(state)
            WL : next_state = ground ? (bump_left ? WR : WL) : FL ;
            FL : next_state = ground ? WL : FL;
            WR : next_state = ground ? (bump_right ? WL : WR) : FR;
            FR : next_state = ground ? WR : FR;
        endcase
    end

    // Current state logic - Sequential Logic
    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if(areset)
            state <= WL;
        else
            state <= next_state;
    end

    // Output logic - Combinational output logic
    assign aaah = (state == FL || state == FR); // Go aaah when Fall left or Fall right    
    assign walk_left = (state == WL ); 
    assign walk_right = (state == WR);

endmodule