module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    wire [31:0] preout, nedge;
    wire prerst;
    always @(posedge clk) begin
        preout <= in;
        //prerst <= reset;
        //nedge[1] <= ~in[1] & preout[1]; //Detects 1-0 transition
        out <= ((~in & preout) | out) & (~{32{reset}} );
        //out[1] <= tout;
    end
endmodule

// Solution based on below truth table I built
/*
    | nedge | reset | Qn | Qn+1 |
    |-------|-------|----|------|
    |   0   |   0   |  0 |   0  |
    |   0   |   0   |  1 |   1  |
    |   0   |   1   |  0 |   0  |
    |   0   |   1   |  1 |   0  |
    |   1   |   0   |  0 |   1  |
    |   1   |   0   |  1 |   1  |
    |   1   |   1   |  0 |   0  |
    |   1   |   1   |  1 |   0  |
*/


//Below is Non-working solution Debug done during solving
/*

    module top_module (
        input clk,
        input reset,
        input [31:0] in,
        output [31:0] out
    );
        wire [31:0] preout , nedge;
        wire prerst;
        wire tout;
        always @(posedge clk) begin
            preout <= in;
            //prerst <= reset;
            nedge[1] <= ~in[1] & preout[1];
            out[1] <= (~in[1] & preout[1]) | (~reset & out[1]);
            //out[4] <= (~in[4] & preout[4]) | (~{32{reset}} & out[4]);
            //out[1] <= tout;
        end
    endmodule

*/
