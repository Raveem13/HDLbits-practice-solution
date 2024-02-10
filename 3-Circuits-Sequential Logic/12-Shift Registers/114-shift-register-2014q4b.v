module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //

    MUXDFF md0 ( KEY[0], KEY[1], KEY[2], LEDR[1], SW[0], LEDR[0] );
    MUXDFF md1 ( KEY[0], KEY[1], KEY[2], LEDR[2], SW[1], LEDR[1] );
    MUXDFF md2 ( KEY[0], KEY[1], KEY[2], LEDR[3], SW[2], LEDR[2] );
    MUXDFF md3 ( KEY[0], KEY[1], KEY[2], KEY[3], SW[3], LEDR[3] );
    
endmodule

module MUXDFF (
    input clk,
    input E, L, w, R,
    output Q
);
    //Verilog module (containing one flip-flop and 2 multiplexer) named top_module for this submodule.
    always @(posedge clk) begin
        Q <= L ? R : ( E ? w : Q) ;
    end
endmodule