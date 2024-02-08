module top_module (
    input clk,
    input j,
    input k,
    output Q); 
    always @(posedge clk)
        Q <= (j | Q) & ( ~k | ~Q );
endmodule

// Learn topic creating a FF using another FF. If a inner FF is D-FF then Output will be same as Output expession (SOP/POS) of outer FF.
