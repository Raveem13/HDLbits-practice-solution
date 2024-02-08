module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    wire [7:0] out;
    always @(posedge clk) begin
        out <= in;
        pedge <= in & ~out;
    end
endmodule

// AND (&) Operation for only 0-1 edge detection in next cycle