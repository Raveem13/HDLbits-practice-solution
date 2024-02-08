module top_module (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);
    always @(posedge clk) begin
        Q <= L ? R : ( E ? w : Q) ;
    end
endmodule

// Write a Verilog module (containing one flip-flop and multiplexer) named top_module for this submodule.