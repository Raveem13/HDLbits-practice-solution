module top_module (
    input clk,
    input areset,
    input x,
    output z
); 

    //-------------Internal Constants-----------------
    parameter S0=0, S1=1, S2=2;  // States 

    //-------------Internal Variables-----------------
    reg [1:0] state, next_state;

    // State transition logic - Combinational Logic
    always @(*) begin
        case(state)
            S0 : next_state = x ? S1 : S0;
            S1 : next_state = x ? S2 : S1;
            S2 : next_state = x ? S2 : S1;
            default: next_state = 2'bxx;
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
    assign z = (state == S1) ;    
    
endmodule