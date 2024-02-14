module top_module (input a, input b, input c, output out);//
	
    wire temp;
    andgate inst1 ( temp, a, b, c, 1, 1 );
    //andgate inst1 ( .a(a), .b(b), .c(c), .d(1), .e(1), .out(temp) );
    assign out = ~ temp;
    
endmodule