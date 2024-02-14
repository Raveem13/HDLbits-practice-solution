module top_module (
    input clock,
    input a,
    output p,
    output q );
    
    always @(*)
        if(clock)
            p = a; 
    
    always @(negedge clock)
        q <= a;    
	
endmodule