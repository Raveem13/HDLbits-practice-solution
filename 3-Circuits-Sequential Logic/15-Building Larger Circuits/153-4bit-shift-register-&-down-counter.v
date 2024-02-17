module top_module (
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output [3:0] q);
    
    always @(posedge clk) begin
        if(shift_ena)
            q <= ( q<<1 ) | data;
        if (count_ena)	
            q <= q - 1;     // It should go to F after 0, to match test cases.
    end

endmodule