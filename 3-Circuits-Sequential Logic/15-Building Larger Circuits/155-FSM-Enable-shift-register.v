module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);

    //-------------Internal Constants-----------------
    parameter C0=0, C1=1, C2=2, C3=3, C4=4 ;  // States 

    //-------------Internal Variables-----------------
    reg [2:0] state, next_state;  

    // State transition logic - Combinational Logic
    always @(*) begin
        case(state)
            C0 : next_state = C1;
            C1 : next_state = C2;
            C2 : next_state = C3;
            C3 : next_state = C4;
            C4 : next_state = C4;
            default : next_state = 3'bxxx;
        endcase
      
        case(state)
            C0 : shift_ena = 1;
            C1 : shift_ena = 1;
            C2 : shift_ena = 1;
            C3 : shift_ena = 1;
            C4 : shift_ena = 0;
            default : shift_ena = 0;
        endcase 
    end

    // Current state logic - Sequential Logic
    always @(posedge clk) begin
        if(reset)
            state <= C0;
        else
            state <= next_state;
    end

    // Output logic - Combinational output logic
    // or 
    // assign shift_ena = (state == C0) || (state == C1) || (state == C2) || (state == C3) ;
    
endmodule