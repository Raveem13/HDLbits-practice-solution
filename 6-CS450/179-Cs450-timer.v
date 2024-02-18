module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);

    reg [9:0] counter;

    always @(posedge clk) begin
        if (load)
            counter <= data; // Load the counter with data
        else if (counter > 0)
            counter <= counter - 1; 
    end

    // Output signal terminal count
    always @(*) begin
        if (counter == 0)
            tc = 1; // Counter has reached 0
        else
            tc = 0; // Counter has not reached 0
    end
    
endmodule