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
            SNT : next_state = train_valid ? ( train_taken ? WNT : SNT ) : SNT ;
            WNT : next_state = train_valid ? ( train_taken ? WT : SNT ) : WNT ;
            WT : next_state = train_valid ? ( train_taken ? ST : WNT ) : WT ;
            ST : next_state = train_valid ? ( train_taken ? ST : WT ) : ST ;
        endcase
    end

	always @(posedge clk, posedge areset) begin
    // State flip-flops with asynchronous reset
        if(areset)
            state <= WNT ;
        else 
            state <= next_state;
    end

endmodule