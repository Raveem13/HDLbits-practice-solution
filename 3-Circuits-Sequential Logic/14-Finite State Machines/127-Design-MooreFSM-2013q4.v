module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 

    //-------------Internal Constants------------------
    parameter Low=0, S2b1=1, S3b2=2, Full=3, S2b1d=4, S3b2d=5;
    //-------------Internal Variables------------------
    reg [2:0] state, next_state;
    reg [3:0] flowrate;
    
    // State transition logic
    always @(*) begin
        case(state)
            Low : case(s)
                3'b000 : next_state =  Low;
                3'b001 : next_state =  S2b1;
            endcase
            S2b1: case(s)
                3'b000 : next_state =  Low;
                3'b001 : next_state =  S2b1;
                3'b011 : next_state =  S3b2;
            endcase
            S3b2: case(s)
                3'b001 : next_state =  S2b1d;
                3'b011 : next_state =  S3b2;
                3'b111 : next_state =  Full;
            endcase
            Full: case(s)
                3'b011 : next_state =  S3b2d;
                3'b111 : next_state =  Full;
            endcase
            S2b1d: case(s)		
                3'b000 : next_state =  Low;    
                3'b001 : next_state =  S2b1d;
                3'b011 : next_state =  S3b2;
            endcase
            S3b2d: case(s)				
                3'b001 : next_state =  S2b1d;   
                3'b011 : next_state =  S3b2d;
                3'b111 : next_state =  Full;
            endcase
        endcase
        
    // Output logic
        case (state)
        // Fill in output logic
            Low : flowrate = 4'b1111;
            S2b1: flowrate = 4'b0011;
            S3b2: flowrate = 4'b0001;
            Full: flowrate = 4'b0000;
            S2b1d: flowrate = 4'b1011;
            S3b2d: flowrate = 4'b1001;            
        endcase
    end
    
    // State flip-flops with synchronous reset - current state logic
    always @(posedge clk) begin
        if (reset) state <= Low;
       	else state <= next_state;
    end    
	
    // Output logic
    assign { dfr, fr3, fr2, fr1} = flowrate;
    
endmodule