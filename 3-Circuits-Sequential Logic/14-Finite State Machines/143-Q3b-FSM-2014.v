module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);

    //-------------Internal Constants-----------------
    parameter S0=0, S1=1, S2=2, S3=3, S4=4;  // States 

    //-------------Internal Variables-----------------
    reg [2:0] state, next_state;    //Used one hot encoding, 3 state bits required for 5 states.

    // State transition logic - Combinational Logic
    always @(*) begin
        case(state)
            S0 : next_state = x ? S1 : S0;
            S1 : next_state = x ? S4 : S1;
            S2 : next_state = x ? S1 : S2;
            S3 : next_state = x ? S2 : S1;
            S4 : next_state = x ? S4 : S3;
            default : next_state = 3'bxxx;
        endcase
    end

    // Current state logic - Sequential Logic
    always @(posedge clk) begin
    // State flip-flops with asynchronous / synchronous reset
        if(reset)
            state <= S0;
        else
            state <= next_state;
    end

    // Output logic - Combinational output logic
    assign z =(state == S3) || (state == S4);    
    
endmodule