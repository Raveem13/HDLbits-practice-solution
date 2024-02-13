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
    reg [3:0] state, next_state; //Used binary encoding, 4 state bits required for 12 states.
    reg [7:0] out_reg;
    reg pairity, in_b=0;
    
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
            B8 : next_state = PB9;
            PB9 : next_state = in ? DONE : WAIT;
            DONE : next_state = in ? IDLE : START;
            WAIT : next_state = in ? IDLE : WAIT;
            //default : next_state = 4'bxxx;
        endcase
        
     // New: Datapath to latch input bits.   
        case(state)
           // IDLE : 
            START : begin
                out_reg[0] = in;
                //in_b = in;
                parity p1( clk, reset, in, pairity );
            end
            B1 : begin 
                out_reg[1] = in;
                in_b = in;
            end
            B2 : begin 
                out_reg[2] = in;
                in_b = in;
            end
            B3 : begin 
                out_reg[3] = in;
                in_b = in;
            end
            B4 : begin 
                out_reg[4] = in;
                in_b = in;
            end
            B5 : begin 
                out_reg[5] = in;
                in_b = in;
            end
            B6 : begin 
                out_reg[6] = in;
                in_b = in;
            end
            B7 : begin 
                out_reg[7] = in;
                in_b = in;
            end
            B8 : in_b = in;
            DONE :begin
                out_byte = out_reg;
                done = pairity;
            end
            //WAIT : ;
            //default : next_state = 4'bxxx;
        endcase
    end

    // Current state logic - Sequential Logic
    always @(posedge clk) begin
    // synchronous reset
        if(reset)
            state <= IDLE;
        else begin
        	//parity p1( clk, reset, in_b, pairity );
            state <= next_state;
        end
    end

    // Output logic - Combinational output logic
    // assign done = (state == DONE);    
    
    // assign out_byte = out_reg;

endmodule
