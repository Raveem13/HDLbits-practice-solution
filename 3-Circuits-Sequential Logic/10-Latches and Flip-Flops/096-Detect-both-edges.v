module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    wire [7:0] out;
    always @(posedge clk) begin
        out <= in;
        anyedge <= in ^ out;
    end
endmodule

// XOR (^) Operation for 0-1 & 1-0 both edge detection in next cycle