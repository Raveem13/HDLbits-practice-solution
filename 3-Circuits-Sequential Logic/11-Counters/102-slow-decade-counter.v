module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);
    always @(posedge clk)
        if (reset || (q == 9 && slowena))
            q <= 0;
    	else if(slowena)
            	q <= q + 1;
endmodule