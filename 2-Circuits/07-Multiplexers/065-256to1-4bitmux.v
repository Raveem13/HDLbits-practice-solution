module top_module( 
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out );
    reg [10:0] i;    
	always @(*) begin
    	i = sel * 4; // Calculate starting index for slicing
        for (integer j = 0; j < 4; j = j + 1) begin
            if (j < 4) begin
                out[j] = in[i + j]; // Perform slicing operation
            end
    	end
	end
endmodule

//  Using generate block 
/*
    module top_module( 
        input [1023:0] in,
        input [7:0] sel,
        output reg [3:0] out
    );

    reg [11:0] i; // Define i as a reg

    always @(*) begin
        i = sel * 4; // Calculate starting index for slicing
    end

    // Use a generate block to conditionally assign values to out
    genvar j;
    generate
        for (j = 0; j < 4; j = j + 1) begin : gen_slice
            always @(*) begin
                if (j < 4) begin
                    out[j] = in[i + j]; // Perform slicing operation
                end
            end
        end
    endgenerate

    endmodule

*/