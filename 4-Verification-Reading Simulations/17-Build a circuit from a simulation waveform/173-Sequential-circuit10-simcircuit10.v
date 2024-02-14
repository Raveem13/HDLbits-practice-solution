module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state  );
    
    assign q = a ^ b ^ state;
    always @(posedge clk) begin
        state <= a & b | b & state | a & state ;
    end

endmodule