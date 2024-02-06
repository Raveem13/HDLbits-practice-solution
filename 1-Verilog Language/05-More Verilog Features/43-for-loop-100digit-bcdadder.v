module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    genvar i;
    wire [400:0] carry;
    assign carry[0] = cin; 
    generate 
        for (i=0; i<400; i=i+4) begin : blockidname
            bcd_fadd bcdfa (a[i+3:i], b[i+3:i], carry[i], carry[i+4], sum[i+3:i] );
        end
    endgenerate
    assign cout = carry[400];
endmodule



// https://www.intel.com/content/www/us/en/support/programmable/articles/000090348.html
// https://stackoverflow.com/questions/33899691/instantiate-modules-in-generate-for-loop-in-verilog