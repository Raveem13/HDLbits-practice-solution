module top_module (
    input clk,
    input in, 
    output out);
    wire q;
    always @(posedge clk) begin
        q = in ^ q;
        out = q;
    end
endmodule

// = (Blocking assigment)  used here, Not non-Blocking ( <= )