module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);

    //-------------Internal Constants-----------------
    parameter A=0, B=1, C=2, D=3, E=4, F=5;  // States 

    //-------------Internal Variables-----------------
    reg [2:0] state, next_state; 

    // State transition logic - Combinational Logic
    always @(*) begin
        case(state)
            A : next_state = w ? A : B ;
            B : next_state = w ? D : C ;
            C : next_state = w ? D : E ;
            D : next_state = w ? A : F ;
            E : next_state = w ? D : E ;
            F : next_state = w ? D : C ;
            default : next_state = 3'bxxx;
        endcase
    end

    // Current state logic - Sequential Logic
    always @(posedge clk) begin
    //synchronous reset
        if(reset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic - Combinational output logic
    assign z = (state == E) || (state == F) ;

endmodule