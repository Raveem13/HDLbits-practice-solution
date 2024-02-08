module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);

    wire [4:0] carry;
    assign carry[0] = 0;
    genvar i;
    generate
    	for (i=0; i<4; i=i+1) begin: fadderid
            fa fainst( x[i], y[i], carry[i], carry[i+1], sum[i]);
    	end
    endgenerate
    assign sum[4] = carry[4];
endmodule

// 1 bit Full adder module
module fa( 
    input a, b, cin,
    output cout, sum );
	assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);
endmodule