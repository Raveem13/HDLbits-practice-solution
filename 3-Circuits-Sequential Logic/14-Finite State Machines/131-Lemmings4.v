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
    parameter SPLAT=0, FL=1, FR=2, DL=3, DR=4, WL=5, WR=6; 
    integer count = 0;
    //-------------Internal Variables-----------------
    reg [2:0] state, next_state; //used Binary encoding, 3 state bits required for 7 states.

    // State transition logic - Combinational Logic
    always @(*) begin
        case(state)
            WL : next_state = ground ? (dig ? DL : (bump_left ? WR : WL)) : FL ;
            //FL : next_state = ground ? WL : FL;
            FL : begin 
                if(count > 22)
                    next_state = SPLAT;
                else if(ground || ~(state == SPLAT) )begin
                    //count = 0;
                    next_state = WL;
                end
                else begin
                    next_state = FL;
                end
            end
            DL : next_state = ground ? DL : FL;
            WR : next_state = ground ? (dig ? DR : (bump_right ? WL : WR)) : FR;
            FR : next_state = ground ? WR : FR;
            DR : next_state = ground ? DR : FR;
            SPLAT : next_state = SPLAT;
            default : next_state = 3'bxxx;
        endcase
    end

    // Current state logic - Sequential Logic
    always @(posedge clk, posedge areset) begin
        // asynchronous reset
        if(areset)
            state <= WL;
        else if (state == FL ) begin
        	count <= count + 1;
        	state <= next_state;
        end
        else begin
            count = 0;
            state <= next_state;
        end
    end

    // Output logic - Combinational output logic
    assign aaah = (state == FL || state == FR); // Go aaah when Fall left or Fall right  
    assign digging = (state == DL || state == DR);
    assign walk_left = (state == WL ); 
    assign walk_right = (state == WR );     
    
endmodule