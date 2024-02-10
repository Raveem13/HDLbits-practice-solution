module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q); 
    always @(posedge clk)begin
        if (load)
            q <= data;
        else if(ena == 2'b01) // Rotate right using concatenation
            q <= { q[0], q[99:1] }; 
        else if(ena == 2'b10)  // Rotate left using concatenation
            q <= { q[98:0], q[99] };  
    end
endmodule