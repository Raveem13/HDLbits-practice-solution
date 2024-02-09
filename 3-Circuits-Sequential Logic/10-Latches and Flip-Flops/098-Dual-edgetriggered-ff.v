module top_module (
    input clk,
    input d,
    output q
);
	wire nq, pq;
    
    nedff ndff1 ( clk, d, nq );
    pedff pdff1 ( clk, d, pq );
    mux2t1 mux1 ( nq, pq, clk, q );
endmodule

//-ve edge triggered dff
module nedff (
    input clk,
    input din,
    output out
);
    always @(negedge clk)
        out <= din; 
endmodule

//+ve edge triggered dff
module pedff (
    input clk,
    input din,
    output out
);
    always @(posedge clk)
        out <= din; 
endmodule

//2to1 Mux with clock as sector
module mux2t1 (
    input a,
    input b,
    input sel,
    output y
);
	assign y = sel ? b : a;
endmodule