module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 

    //-------------Internal Constants-----------------
    // F > D > W Switch, States : FallLeft, FallRight, DigLeft, DigRight, WalkLeft, WalkRight
    parameter FL=0, FR=1, DL=2, DR=3, WL=4, WR=5;  
    //-------------Internal Variables-----------------
    reg [2:0] state, next_state; //used Binary encoding, 3 state bits required for 6 states.

    // State transition logic - Combinational Logic
    always @(*) begin
        case(state)
            WL : next_state = ground ? (dig ? DL : (bump_left ? WR : WL)) : FL ;
            FL : next_state = ground ? WL : FL;
            DL : next_state = ground ? DL : FL;
            WR : next_state = ground ? (dig ? DR : (bump_right ? WL : WR)) : FR;
            FR : next_state = ground ? WR : FR;
            DR : next_state = ground ? DR : FR;    
            default : next_state = 3'bxxx;
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
    assign digging = (state == DL || state == DR);
    assign walk_left = (state == WL ); 
    assign walk_right = (state == WR);    
    
endmodule