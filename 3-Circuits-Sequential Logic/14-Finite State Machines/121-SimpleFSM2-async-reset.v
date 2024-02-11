module top_module(
    input clk,
    input areset,    // Asynchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=0, ON=1; 
    reg state, next_state;

    always @(*) begin
        // State transition logic
        case(state)
            OFF: next_state = j ? ON : OFF;
            ON: next_state = k ? OFF : ON;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if(areset)
            state <= OFF;
        else
            state <= next_state;
    end

    // Output logic
    // assign out = (state == ...);
    assign out = state;

endmodule


    // Website solution
    /*
    module top_module (
        input clk,
        input j,
        input k,
        input areset,
        output out
    );
        parameter A=0, B=1;
        reg state;
        reg next;
        
        always_comb begin
            case (state)
                A: next = j ? B : A;
                B: next = k ? A : B;
            endcase
        end
        
        always @(posedge clk, posedge areset) begin
            if (areset) state <= A;
            else state <= next;
        end
            
        assign out = (state==B);
        //I observed here as it should be last state / highest value state
        
    endmodule

    */