module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Use FSM from Fsm_serial

    //-------------Internal Constants-----------------
    parameter START=0, B1=1, B2=2, B3=3, B4=4, B5=5, B6=6, B7=7, B8=8, IDLE=9, WAIT=10, DONE=11;  // States 
    //-------------Internal Variables-----------------
    reg [3:0] state, next_state; //Used binary encoding, 4 state bits required for 12 states.
    reg [7:0] out_reg;
    
    // State transition logic - Combinational Logic
    always @(*) begin
        case(state)
            IDLE : next_state = in ? IDLE : START;
            START : next_state = B1;
            B1 : next_state = B2;
            B2 : next_state = B3;
            B3 : next_state = B4;
            B4 : next_state = B5;
            B5 : next_state = B6;
            B6 : next_state = B7;
			B7 : next_state = B8;
            B8 : next_state = in ? DONE : WAIT;
            DONE : next_state = in ? IDLE : START;
            WAIT : next_state = in ? IDLE : WAIT;
            //default : next_state = 4'bxxx;
        endcase
        
     // New: Datapath to latch input bits.   
        case(state)
           // IDLE : 
            START : out_reg[0] = in;
            B1 : out_reg[1] = in;
            B2 : out_reg[2] = in;
            B3 : out_reg[3] = in;
            B4 : out_reg[4] = in;
            B5 : out_reg[5] = in;
            B6 : out_reg[6] = in;
            B7 : out_reg[7] = in;
            //B8 : out_reg[] = in;
            DONE :out_byte = out_reg;
            //WAIT : ;
            //default : next_state = 4'bxxx;
        endcase
    end

    // Current state logic - Sequential Logic
    always @(posedge clk) begin
    // synchronous reset
        if(reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Output logic - Combinational output logic
    assign done = (state == DONE);    
    
    //assign out_byte = out_reg;

endmodule