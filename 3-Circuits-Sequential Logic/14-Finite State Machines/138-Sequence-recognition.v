module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);

    //-------------Internal Constants-----------------
    parameter ONE0=0, ONE1=1, ONE2=2, ONE3=3, ONE4=4, ONE5=5, ONE6=6, ERR=7, DISC=8, FLAG=9 ;  // States 

    //-------------Internal Variables-----------------
    reg [3:0] state, next_state;    //Used one hot encoding, 4 state bits required for 4 states.

    // State transition logic - Combinational Logic
    always @(*) begin
        case(state)
			ONE0 : next_state = in ? ONE1 : ONE0;
            ONE1 : next_state = in ? ONE2 : ONE0;
            ONE2 : next_state = in ? ONE3 : ONE0;
            ONE3 : next_state = in ? ONE4 : ONE0;
            ONE4 : next_state = in ? ONE5 : ONE0;
            ONE5 : next_state = in ? ONE6 : DISC;
            ONE6 : next_state = in ? ERR : FLAG;
            ERR : next_state = in ? ERR : ONE0;
            DISC : next_state = in ? ONE1 : ONE0;
            FLAG : next_state = in ? ONE1 : ONE0;
            default:next_state = 4'bxxxx;
        endcase
    end

    // Current state logic - Sequential Logic
    always @(posedge clk) begin
    // State flip-flops with asynchronous / synchronous reset
        if(reset)
            state <= ONE0;
        else
            state <= next_state;
    end

    // Output logic - Combinational output logic
    assign disc = (state == DISC );    
    assign flag = (state == FLAG );
    assign err = (state == ERR );
    
endmodule