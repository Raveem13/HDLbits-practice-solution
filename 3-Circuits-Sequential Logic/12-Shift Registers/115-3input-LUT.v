module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z ); 

    wire [7:0] otemp;
    always @(posedge clk) begin
        if(enable)
            otemp <= { otemp[6:0], S };
    end
    assign Z = otemp[{A, B, C}];
  
endmodule

//Refer problem-113 Shift Register - 2014 q4k