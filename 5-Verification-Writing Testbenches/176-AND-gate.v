module top_module();
    
    reg [1:0] i;    // Inputs only reg
    wire o;         // Outputs declared as wires / reg
    
    // instantiate device under test
    andgate ag1 ( i, o );
    
    // apply inputs one at a time
	initial begin
		i = 0; #10;
        if (o != 0) $display("00-Failed");
        i = 1; #10;
        if (o != 0) $display("01-Failed");
        i = 2; #10;
        if (o != 0) $display("10-Failed");
        i = 3; #10;
        if (o != 1) $display("11-Failed");
    end
        
endmodule