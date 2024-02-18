module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );

    //-------------Internal Constants-----------------
    parameter S=0, S1=1, S11=2, S110=3, B0=4, B1=5, B2=6, B3=7, Count=8, Wait=9 ;  // States 

    //-------------Internal Variables-----------------
    reg [3:0] state, next_state;   
    reg shift_ena, count_ena, sc1_ena ; 	// Intermediate enable signals used
    reg done_counting, sc1_c0 ;				
    reg [9:0] q;							// Inner 1k-counter output
    
    // 1k counter instantiation
    counter1k c1k (
        .clk(clk),
        .rst(count_ena), 
        //.ena_in(count_ena), 
        //.ena_out(sc1_ena),
        .qout(q)
    );
    
    and ( sc1_ena, q[0], q[1], q[2], q[5], q[6], q[7], q[8], q[9] );	// Count 1000 cycles then enable signal to shift+down counter  
    nor ( sc1_c0, count[0], count[1], count[2], count[3] );
    and ( done_counting, sc1_ena, sc1_c0);  							// set flag done_counting if outer count = 0 & inner count = 999
    
    // shift register & down counter instantiation
    shiftcount sc1 ( clk, shift_ena, sc1_ena, data, count );   
    
    
    // State transition logic - Combinational Logic - The Complete FSM
    always @(*) begin
        case(state)
            S : next_state = data ? S1 : S ;
            S1 : next_state = data ? S11 : S ;
            S11 : next_state = data ? S11 : S110 ;
            S110 : next_state = data ? B0 : S ;
            B0 : next_state = B1;
            B1 : next_state = B2;
            B2 : next_state = B3;
            B3 : begin
                //count_ena = 1;
                next_state = Count;
            end
            Count : next_state = done_counting ? Wait : Count;
            Wait : next_state = ack ? S : Wait;
            default : next_state = 4'bx;
        endcase
    end

    // Current state logic - Sequential Logic
    always @(posedge clk) begin
    // synchronous reset
        if(reset)
            state <= S;
        else
            state <= next_state;
    end

    // Output logic - Combinational output logic - The Complete FSM
    assign count_ena =  (state == B3) ;  // Control signals to start counter -> reset inner counter
    assign shift_ena = (state == B0) || (state == B1) || (state == B2) || (state == B3);  // Control signals to shift data
    
    assign counting = ( state == Count );
    assign done = (state == Wait);

endmodule

// 0-999 => 1k clock cycles counter module
module counter1k (
    input clk,
    input rst,
    // input ena_in,
    // output ena_out,
    output [9:0] qout );
    
    always @(posedge clk) begin
        if(rst)
            qout <= 0;
        else if ( qout == 999 ) begin
            // ena_out <= 1;
            qout <= 0;
        end
        else begin
            qout <= qout + 1;
            // ena_out <= 0;
        end
    end

endmodule

// 4-bit shift register and down counter module
module shiftcount (
    input clk,
    input s_ena,
    input c_ena,
    input data,
    output [3:0] count );
    
    always @(posedge clk) begin
        if(s_ena)
            count <= ( count<<1 ) | data;
        if (c_ena)	
            count <= count - 1;
    end    
    
endmodule