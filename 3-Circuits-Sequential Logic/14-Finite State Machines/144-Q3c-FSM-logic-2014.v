module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
	
    //-------------Internal Constants-----------------
    parameter S0=0, S1=1, S2=2, S3=3, S4=4;  // States 
/*
    //-------------Internal Variables-----------------
    reg [2:0] state, next_state;    //Used one hot encoding, 4 state bits required for 4 states.

    // State transition logic - Combinational Logic
    always @(*) begin
        case(state)
            curr_state : next_state = input ? next_state_true : next_state_false ;
            
            default : next_state = 4'bxxx;
        endcase
    end 

    // Current state logic - Sequential Logic
    always @(posedge clk) begin
            state <= next_state;
    end
    */

    // Output logic - Combinational output logic
    assign z = (y == S3) || (y == S4);  
    assign Y0 = ~x & ((y == S1) || (y == S3) || (y == S4)) || x & ((y == S0) || (y == S2));
    
endmodule