module top_module ();
    
    reg clk, rst, tin, qo; 
    
    tff tf1 ( clk, rst, tin, qo );
    
    //generate Clock
    always begin
        clk = 0;
    	forever begin
            #5 clk = ~clk;
        end
    end
    
   	// generate input patterns
    initial begin
        rst = 1; tin = 0; #10;
        rst = 0; tin = 1; #10;
    end

endmodule