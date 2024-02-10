module top_module(
    input clk,
    input areset,  // async active-high reset to zero
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q); 
    always @(posedge clk, posedge areset)begin
        if (areset)
            q <= 0;
        else if (load)
            q <= data;
        else if (ena)
            q <= q>>1;    //			q <= q[3:1];	// Use vector part select to express a shift.
    end
endmodule