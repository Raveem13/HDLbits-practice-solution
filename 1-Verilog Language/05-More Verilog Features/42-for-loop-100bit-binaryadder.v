module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
    assign sum[0] = a[0] ^ b[0] ^ cin;
    assign cout[0] = a[0] & b[0] | b[0] & cin | a[0] &  cin;    
    always @(*) begin
        for (integer i=1; i<100; i++) begin
        	sum[i] = a[i] ^ b[i] ^ cout[i-1];
        	cout[i] = a[i] & b[i] | b[i] & cout[i-1] | a[i] & cout[i-1];
    	end
    end

endmodule