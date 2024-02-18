module top_module(
    input clk,
    input areset,

    input predict_valid,
    input predict_taken,
    output [31:0] predict_history,

    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);
    
    always @(posedge clk, posedge areset) begin   
        if(areset) 						// asynchronous reset that resets the history counter to zero.
            predict_history <= 0;      
        else if (train_mispredicted)
            predict_history <= ( train_history << 1 | train_taken );
        else if (predict_valid)
            predict_history <= ( predict_history << 1 | predict_taken );
    end
    
endmodule