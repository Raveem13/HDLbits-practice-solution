module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire [31:0] b1;
    wire cout1, cout2;
    assign b1 = {32{sub}} ^ b;
    add16 addlw( a[15:0], b1[15:0], sub, sum[15:0], cout1 );
    add16 addhw( a[31:16], b1[31:16], cout1, sum[31:16], cout2 );
endmodule
