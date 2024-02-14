module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );
    
    //-------------Internal Constants-----------------
    parameter S=0, S1=1, S11=2, S110=3, B0=4, B1=5, B2=6, B3=7, Count=8, Wait=9 ;  // States 

    //-------------Internal Variables-----------------
    reg [3:0] state, next_state;    

    // State transition logic - Combinational Logic
    always @(*) begin
        case(state)
            S : next_state = data ? S1 : S ;
            S1 : next_state = data ? S11 : S ;
            S11 : next_state = data ? S11 : S110 ;
            S110 : next_state = data ? B0 : S ;
            B0 : next_state = B1;
            B1 : next_state = B2;
            B2 : next_state = B3;
            B3 : next_state = Count;
            Count : next_state = done_counting ? Wait : Count;
            Wait : next_state = ack ? S : Wait;
            //default : next_state = x;
        endcase
    end

    // Current state logic - Sequential Logic
    always @(posedge clk) begin
    // synchronous reset
        if(reset)
            state <= S;
        else
            state <= next_state;
    end

    // Output logic - Combinational output logic
    assign shift_ena = (state == B0) | (state == B1) | (state == B2) | (state == B3);
    assign counting = ( state == Count );
    assign done = ( state == Wait );

endmodule