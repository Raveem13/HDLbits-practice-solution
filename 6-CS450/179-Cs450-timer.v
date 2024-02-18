module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);
    
    reg [9:0] q;
    reg t;
    
    always @(posedge clk) begin
        //tc <= 0;
        if(load)
            q <= data;
        else if ( q == 0)
            tc <= 1;
        else
            q <= q - 1;
    end
    
    //assign tc = ( q == 0 );
    
endmodule
