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
    // F > D > W Switch 
    parameter SPLAT0=0, SPLAT1=1, FL=2, FR=3, DL=4, DR=5, WL=6, WR=7;	// States 
    
    //-------------Internal Variables-----------------
    reg [3:0] state, next_state; //used Binary encoding, 4 state bits required.
	// Counter for tracking the number of clock cycles in FL state
    reg [4:0] flr_counter;   // For max 21 cycles
    
    
    // State transition logic - Combinational Logic
    always @(*) begin
        case(state)
            WL : begin 
                if (ground)
                    next_state = (dig ? DL : (bump_left ? WR : WL)) ;
                else
                    next_state = FL;
            end
            FL : begin 
                if (flr_counter >= 20 )
                    next_state = ground ? SPLAT0 : SPLAT1 ;
                else
                	next_state = ground ? WL : FL;
            end
            DL : next_state = ground ? DL : FL;
            WR : begin 
                if (ground)
                    next_state = dig ? DR : (bump_right ? WL : WR) ;
                else
                    next_state = FR;
            end
            FR :begin 
                if (flr_counter >= 20 )
                    next_state = ground ? SPLAT0 : SPLAT1 ;
                else
                	next_state = ground ? WR : FR;
            end
            DR : next_state = ground ? DR : FR;
            SPLAT0: next_state = SPLAT0 ;
            SPLAT1: next_state = ground ? SPLAT0 : SPLAT1 ;
            // default : next_state = SPLAT;
        endcase
    end

    // Current state logic - Sequential Logic
    always @(posedge clk, posedge areset) begin
        // asynchronous reset
        if(areset) begin
            state <= WL;
        	flr_counter <= 0;
        end
        else begin
            state <= next_state;
            if (state == FL || state == FR) 
                flr_counter <= flr_counter + 1;
            else 
                flr_counter <= 0;
        end
    end
    
    // Output logic - Combinational output logic
    assign aaah = (state == FL || state == FR || state == SPLAT1) ; 
    assign digging = (state == DL || state == DR);
    assign walk_left = (state == WL ); 
    assign walk_right = (state == WR );       
    
endmodule