module top_module (input x, input y, output z);
    wire a1z, a2z, b1z, b2z;
    a ia1(x, y, a1z);
    a ia2(x, y, a2z);
    b ib1(x, y, b1z);
    b ib2(x, y, b2z);    
    assign z = (a1z | b1z) ^ (a2z & b2z);
endmodule

module a (input x, input y, output z);
    assign  z = (x^y) & x;
endmodule

module b ( input x, input y, output z );
	assign z = ~x ^ y;
endmodule