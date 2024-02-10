module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 5'h1
    output [4:0] q
); 
    wire q3x, q0x;
    reg [4:0] rstdata = 5'h1;
    dffrstdata dffrd0 ( clk, reset, rstdata[0], q[1], q[0] );
    dffrstdata dffrd1 ( clk, reset, rstdata[1], q[2], q[1] );
    xor ( q3x, q[0], q[3] );
    dffrstdata dffrd2 ( clk, reset, rstdata[2], q3x, q[2] );
    dffrstdata dffrd3 ( clk, reset, rstdata[3], q[4], q[3] );
    xor ( q0x, q[0], 1'b0 );
    dffrstdata dffrd4 ( clk, reset, rstdata[4], q0x, q[4] );
    
endmodule

//Sync reset D-FF with reset data in
module dffrstdata (
    input clk,
    input reset,            // Synchronous reset
    input rstd,
    input d,
    output q
);
    always @(posedge clk)begin
        if (reset)
        	q <= rstd;
        else
            q <= d;
    end
endmodule