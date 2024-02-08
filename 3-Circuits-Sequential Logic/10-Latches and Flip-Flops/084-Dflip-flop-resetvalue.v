module top_module (
    input clk,
    input reset,
    input [7:0] d,
    output [7:0] q
);
    always @(negedge clk)begin
        if (reset)
        	q <= 7'h34;
        else
            q <= d;
    end
endmodule

// Resetting a register to '1' is sometimes called "preset"