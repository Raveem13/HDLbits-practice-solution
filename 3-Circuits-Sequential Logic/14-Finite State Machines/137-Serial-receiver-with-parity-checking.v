module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Modify FSM and datapath from Fsm_serialdata

    // New: Add parity checking.
    
    //-------------Internal Constants-----------------
    parameter START=0, B1=1, B2=2, B3=3, B4=4, B5=5, B6=6, B7=7, B8=8, PB9=9, IDLE=10, WAIT=11, DONE=12;  // States 
    
    //-------------Internal Variables-----------------
    reg [3:0] state, next_state; //Used binary encoding, 4 state bits required for 13 states.
    reg [7:0] out_reg;
    reg odd_parity, odd_reg, pm_rst;
    
    // Parity module instantiation
    parity parity_checker(
        .clk(clk),
        .reset(pm_rst), // Reset at appropriate times
        .in(in),
        .odd(odd_parity)
    );
    
    // State transition logic - Combinational Logic
    always @(*) begin
        done = 0;  // forcing done flag = 0, after DONE state.
        pm_rst = (state == IDLE || state == DONE); //parity module reset before going START state.
        out_byte = pm_rst;
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
            B8 : next_state = PB9;
            PB9 : next_state = in ? DONE : WAIT;
            DONE : next_state = in ? IDLE : START;
            WAIT : next_state = in ? IDLE : WAIT;
            default : next_state = 4'bxxxx;
        endcase
        
     // New: Datapath to latch input bits. 
        case(state)
           // IDLE : ;
            START :out_reg[0] = in;
            B1 : out_reg[1] = in;
            B2 : out_reg[2] = in;
            B3 : out_reg[3] = in;
            B4 : out_reg[4] = in;
            B5 : out_reg[5] = in;
            B6 : out_reg[6] = in;
            B7 : out_reg[7] = in;
            // B8 : odd_reg = odd_parity;
            PB9 : odd_reg = in ? odd_parity : 0;
            DONE :begin
                out_byte = out_reg;
                done = odd_reg;
            end
            //WAIT : ;
            default : next_state = 4'bxxxx;
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
    // assign done = (state == DONE);    
    // assign out_byte = out_reg;

endmodule