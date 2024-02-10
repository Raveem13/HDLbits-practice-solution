module top_module (
    input clk,
    input w, R, E, L,
    output Q
);
    always @(posedge clk) begin
        Q <= L ? R : ( E ? w : Q) ;
    end
endmodule

// Write a Verilog module (containing one flip-flop and 2 multiplexer) named top_module for this submodule.