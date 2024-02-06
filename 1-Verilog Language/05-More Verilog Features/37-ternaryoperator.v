module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);//
    wire [7:0] mtemp;
    // assign intermediate_result1 = compare? true: false;
	assign mtemp = a < b ? a : b;
    assign min = mtemp < c ? ( mtemp < d ? mtemp : d ) : ( c < d ? c : d );
endmodule