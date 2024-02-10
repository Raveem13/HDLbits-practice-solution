module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
 
    wire [3:0] otemp;
    always @(posedge clk) begin
        if(!resetn)
            otemp <= 0;
        else
            otemp <= { otemp[2:0], in };
    end
    assign out = otemp[3];
endmodule