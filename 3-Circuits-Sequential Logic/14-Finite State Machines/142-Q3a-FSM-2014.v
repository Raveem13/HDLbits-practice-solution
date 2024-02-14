module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);

    //-------------Internal Constants-----------------
    parameter A=0, B=1, C1W0=2, C1W1=3, C2W1=4, C2W2=5, C3W2=6, C2W0=7,  C3W3=8 ;  // States 

    //-------------Internal Variables-----------------
    reg [3:0] state, next_state;

    // State transition logic - Combinational Logic
    always @(*) begin
        case(state)
            A : next_state = s ? B : A;
            B : next_state = w ? C1W1 : C1W0;
            C1W0 : next_state = w ? C2W1 : C2W0;
            C2W0 : next_state = C3W3;
            C1W1 : next_state = w ? C2W2 : C2W1;
            C2W1 : next_state = w ? C3W2 : C3W3;
            C2W2 : next_state = w ? C3W3 : C3W2;
            C3W2 : next_state = w ? C1W1 : C1W0;
            C3W3 : next_state = w ? C1W1 : C1W0;
			//default : next_state = 4'bxxx;
        endcase
    end

    // Current state logic - Sequential Logic
    always @(posedge clk) begin
    // State flip-flops with synchronous reset
        if(reset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic - Combinational output logic
    assign z = (state == C3W2);
    
endmodule