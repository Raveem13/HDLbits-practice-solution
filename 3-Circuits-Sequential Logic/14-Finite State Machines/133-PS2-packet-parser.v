module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //

    parameter B1=0, B2=1, B3=2, Done=3;
    reg [1:0] state, next_state;  // 4 states with binary encoding -> 2bits
    
    // State transition logic (combinational)
    always @(*)
        case(state)
            B1 : next_state = in[3] ? B2 : B1;
            B2 : next_state = B3;
            B3 : next_state = Done;
            Done : next_state = in[3] ? B2 : B1;
        endcase
    
    // State flip-flops (sequential)
    always @(posedge clk)
        if(reset)
            state <= B1;
    	else
            state <= next_state;
    
    // Output logic
    assign done = ( state == Done );

endmodule