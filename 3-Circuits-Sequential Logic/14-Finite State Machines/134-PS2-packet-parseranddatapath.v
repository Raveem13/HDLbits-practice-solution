module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    // FSM from fsm_ps2
    parameter B1=0, B2=1, B3=2, Done=3;
    reg [1:0] state, next_state;  // 4 states with binary encoding -> 2bits
    reg [23:0] out_reg;
    reg [23:16] o_temp;
    
    // State transition logic (combinational)
    always @(*)begin
        case(state)
            B1 : next_state = in[3] ? B2 : B1;
            B2 : next_state = B3;
            B3 : next_state = Done;
            Done : next_state = in[3] ? B2 : B1;
            default : next_state = 2'bxx;
        endcase
  
       // New: Datapath to store incoming bytes.
        case(state)
            B1 : o_temp = in;
            B2 : out_reg[23:8] = { o_temp, in };
            B3 : out_reg[7:0] = in;
            Done : begin
                out_bytes = out_reg;
                o_temp = in;
            end
        endcase 
    end
    
    // State flip-flops (sequential)
    always @(posedge clk)begin
     	if(reset)
         	state <= B1;
  		else
         	state <= next_state;
    end
        
    // Output logic
    assign done = ( state == Done );
	// assign out_bytes = out_reg;
    
endmodule