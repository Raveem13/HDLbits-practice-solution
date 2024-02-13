module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 

    //-------------Internal Constants-----------------
    parameter A=0, B=1, C=2, D=3, E=4, F=5, G=6, H=7, I=8, J=9;  // States 

    //-------------Internal Variables-----------------
    reg [3:0] state, next_state;    // 10 states.

    // State transition logic - Combinational Logic
    always @(*) begin
        case(state)
            A : next_state = B;
            B : next_state = C;
            C : next_state = x ? D : C;
            D : next_state = x ? D : E;
            E : next_state = x ? F : C;
            F : next_state = y ? G : I;
            G : next_state = H;
            I : next_state = y ? H : J;
            J : next_state = J;
            H : next_state = H;
            //default : next_state = 4'bxxxx;
        endcase
    end

    // Current state logic - Sequential Logic
    always @(posedge clk) begin
    // active-low synchronous reset
        if(!resetn)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic - Combinational output logic
    assign f = (state == B);
    assign g = (state == F) || (state == G) || (state == H) || (state == I);
    
endmodule