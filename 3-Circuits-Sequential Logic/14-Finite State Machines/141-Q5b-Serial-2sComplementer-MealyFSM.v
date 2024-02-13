module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
 
    //-------------Internal Constants-----------------
    parameter S0=1, S1=2 ;  // States 

    //-------------Internal Variables-----------------
    reg [1:0] state, next_state;    //Used one hot encoding, 2 state bits required for 2 states.

    // State transition logic - Combinational Logic
    always @(*) begin
        case(state)
            S0 : next_state = x ? S1 : S0;
            S1 : next_state = x ? S1 : S1;
            // default : next_state = 1'bxx;
        endcase
    end

    // Current state logic - Sequential Logic
    always @(posedge clk, posedge areset) begin
    // State flip-flops with asynchronous reset
        if(areset)
            state <= S0;
        else
            state <= next_state;
    end

    // Output logic - Combinational output logic
    assign z = (state == S0) & x || (state == S1) & ~x;      

endmodule