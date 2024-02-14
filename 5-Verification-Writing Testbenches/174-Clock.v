module top_module ( );
    //_________Variables & Constants___________
    reg clk;
    // instantiate device under test
    dut dut1 ( clk );
    
    always // no sensitivity list, so it always executes
    begin
        clk = 0; #5; 
        clk = 1; #5; // 10ns period
    end

endmodule