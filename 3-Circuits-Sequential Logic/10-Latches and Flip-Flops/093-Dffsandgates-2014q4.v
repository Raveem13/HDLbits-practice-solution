// Note: Don't name module dff or any keywords
module top_module (
    input clk,
    input x,
    output z
); 
	wire d1, d2, d3, out;
    wire q1, q2, q3, q1b, q2b, q3b;
    initial begin
        {q1, q2, q3} <= 3'b0;
        {q1b, q2b, q3b} <= 3'b111;
	end
    
    xorg x1 ( x, q1, d1 );
    df df1 ( clk, d1, q1, q1b );
    andg a1 ( x, q2b, d2 );
    df df2 ( clk, d2, q2, q2b );
    org o1 ( x, q3b, d3 );
    df df3 ( clk, d3, q3, q3b );
    norg o2 ( q1, q2, q3, z );
    
endmodule

module df (
    input clk,    // Clocks are used in sequential circuits
    input d,
    output reg q ,
    output reg qb );//
    assign qb = ~q;
    always @(posedge clk) begin
        q <= d;
    end
endmodule

//Use built-in n-input gates instead of userdefined gates

module andg (
    input a, b,
    output out
);
    assign out = a & b;
endmodule

module org (
    input a, b,
    output out
);
    assign out = a | b;
endmodule

module norg (
    input a, b, c,
    output out
);
    assign out = ~( a | b | c );
endmodule

module xorg (
    input a, b,
    output out
);
    assign out = a ^ b;     
endmodule


// The below solution not working
  /*
module top_module (
    input clk,
    input x,
    output z
); 
	wire d1, d2, d3;
    reg q1, q2, q3, q1b, q2b, q3b;
    initial begin
        {q1, q2, q3} <= 3'b0;
        {q1b, q2b, q3b} <= 3'b111;
	end
    assign {q1b, q2b, q3b} = ~{q1, q2, q3};
    always @(posedge clk) begin
        d1 <= x ^ q1;
        d2 <= x & q2b;
        d3 <= x | q3b;
        {q1, q2, q3} <= {d1, d2, d3};
        z <= ~( q1 | q2 | q3 );
    end
endmodule

*/    