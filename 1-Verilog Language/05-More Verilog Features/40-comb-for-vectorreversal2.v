module top_module( 
    input [99:0] in,
    output [99:0] out
);
    always @(*)
        for (integer i=0; i<100; i=i+1) begin
        out[i] = in[99-i];
    end
endmodule