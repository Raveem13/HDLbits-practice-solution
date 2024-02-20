module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);

    //-------------Internal Constants-----------------
    parameter SNT=0, WNT=1, WT=2, ST=3 ;  // states 

    //-------------Internal Variables-----------------
    reg [1:0] next_state;    //2 state bits for 4 states.

    // State transition logic - Combinational Logic
    always @(*) begin
        case(state)
            SNT : next_state = train_taken ? WNT : SNT ;
            WNT : next_state = train_taken ? WT : SNT ;
            WT : next_state = train_taken ? ST : WNT ;
            ST : next_state = train_taken ? ST : WT ;
        endcase
    end

	always @(posedge clk, posedge areset) begin
    // State flip-flops with asynchronous reset
        if(areset)
            state <= WNT ;
        else if (train_valid)
            state <= next_state;
    end

endmodule