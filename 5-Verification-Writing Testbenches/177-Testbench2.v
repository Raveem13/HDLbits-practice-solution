module top_module();

    reg clk, i, o;
    reg [2:0] s;
    
    q7 dut1( clk, i, s,  o);
    
    initial begin 
        clk = 0;
        forever begin
            #5 clk = ~clk; //generate Clock with period = 10ns
        end 
    end 
    
    // generate input patterns here
    initial begin
        i = 0; s = 2; #10;
        s = 6; #10;
        i = 1; s = 2; #10;
        i = 0; s = 7; #10;
        i = 1; s = 0; #30;
        i = 0; #10;
    end

endmodule