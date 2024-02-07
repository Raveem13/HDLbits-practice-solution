module top_module( 
    input [99:0] a, b,
    input cin,
    output cout,
    output [99:0] sum );
    
    reg [100:0] temp_a;
    assign temp_a = a;
    assign { cout, sum }  = { temp_a + b + cin };
endmodule