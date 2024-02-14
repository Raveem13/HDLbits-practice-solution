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
    wire shift_ena, count_ena ;
    wire done_counting;
    reg [9:0] inner_count;
    
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
            B3 : next_state = Count;
            Count : next_state = done_counting ? Wait : Count;
            Wait : next_state = ack ? S : Wait;
            //default : next_state = 3'bxx;
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

    count1k inner_counter (
    	.clk(clk),
    	.reset(reset),
    	.q(inner_count)
	);

    
    // 4-bit shift register and down counter
    always @(posedge clk) begin
        if(shift_ena)
            count <= ( count<<1 ) | data;
        if (count_ena)	begin
            //if(count == 0) 
                //done_counting = 1;
            if (inner_count == 999) begin
            	count <= count - 1; // Increment the outer counter when the inner counter reaches its maximum value
        	end
            
        end
    end
    
    // Output logic - Combinational output logic - The Complete FSM
    assign shift_ena = (state == B0) | (state == B1) | (state == B2) | (state == B3);
    assign count_ena = ~ shift_ena ;
    assign counting = ( state == Count );
    assign done = ( state == Wait );

endmodule

module count1k (
    input clk,
    input reset,
    output [9:0] q);
    
    always @(posedge clk)begin
        if(reset || q == 999)
            q <= 0;
        else
            q <= q + 1;
    end

endmodule