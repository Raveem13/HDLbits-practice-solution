module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 

    //-------------Internal Constants-----------------
    parameter A=0, B=1, C=2, D=3 ;  // States 

    //-------------Internal Variables-----------------
    reg [1:0] state, next_state;    

    // State transition logic - Combinational Logic
    always @(*) begin
        case(state)
            A : next_state = r[B] ? B : (r[C] ? C : (r[D] ? D : A) ) ;
            B : next_state = r[B] ? B : A ;
            C : next_state = r[C] ? C : A ;
            D : next_state = r[D] ? D : A ;
        endcase
    end

    // Current state logic - Sequential Logic
    always @(posedge clk) begin
    // State flip-flops with asynchronous / synchronous reset
        if(!resetn)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic - Combinational output logic
    assign g = {(state == D) , (state == C) , (state == B)};    
    
endmodule