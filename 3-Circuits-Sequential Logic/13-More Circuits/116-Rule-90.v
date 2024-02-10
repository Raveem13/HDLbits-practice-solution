module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q ); 
    
	always @(posedge clk) begin
		if (load)
			q <= data;	// Load the DFFs with a value.
		else begin
            // For q=1010101  left values   101010
            //                right values  101010 
			//     left           right           
			//  neighbour       neighbour						
			q <= q[511:1] ^ {q[510:0], 1'b0} ;
		end
	end
endmodule

// Using for-loop
/* 
        module top_module(
            input clk,
            input load,
            input [511:0] data,
            output [511:0] q ); 
            
            always @(posedge clk)begin
                if (load)
                    q <= data;
                else begin
                    for (integer i=0; i<512; i=i+1 )begin
                        if (i == 0)
                            q[i] <= 0 ^ q[i+1];
                        else if (i == 511)
                            q[i] <= 0 ^ q[i-1];
                        else
                            q[i] <= q[i-1] ^ q[i+1];
                        end
                end
            end
        endmodule
 */