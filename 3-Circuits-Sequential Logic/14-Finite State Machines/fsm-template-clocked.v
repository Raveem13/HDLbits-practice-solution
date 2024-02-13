module top_module(
    input clk,
    input ,
    input ,
    input ,
    input ,
    output ,
    output ,
    output ); 
    
    //-------------Internal Constants-----------------
    parameter S0=1, S1=2, S2=4, S3=8, ......;  // States 

    //-------------Internal Variables-----------------
    reg [3:0] state, next_state;    //Used one hot encoding, 4 state bits required for 4 states.
    reg [N:0] temp;                //Any temp register.

    // State transition logic - Combinational Logic
    always @(*) begin
        case(state)
            curr_state : next_state = input ? next_state_true : next_state_false ;

        endcase
    end

    // Current state logic - Sequential Logic
    always @(posedge clk) begin
    // State flip-flops with asynchronous / synchronous reset
        if(reset)
            state <= rst_state;
        else
            state <= next_state;
    end

    // Output logic - Combinational output logic
    // assign out = (state == ...);


endmodule