module top_module(
    input clk,
    input areset,

    input  predict_valid,
    input  [6:0] predict_pc,
    output predict_taken,
    output [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);
    
    //-------------Internal Constants-----------------
    parameter PHT_SIZE = 128;

    //-------------Internal Variables-----------------
    reg [1:0] pht[PHT_SIZE-1:0];	// pattern history table (PHT) => 128-entry table of two-bit
    reg [6:0] hashed_index_p;
    reg [6:0] hashed_index_t;

    
    // Combinational Logic
    always @(*) begin
        hashed_index_p = predict_pc ^ predict_history;	
        predict_taken = (pht[hashed_index_p][1]);	// The branch direction prediction is a combinational path
    end

    // Sequential Logic
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            predict_history <= 0;					// clears the global history register to 0
            for (int i = 0; i < PHT_SIZE; i = i + 1)
                pht[i] <= 2'b01;					// clears the entire PHT to 2b'01 (weakly not-taken)
        end
        else begin
            if (train_valid) begin
                hashed_index_t = train_history ^ train_pc;
                if (train_taken)
                    pht[hashed_index_t] <= (pht[hashed_index_t] != 2'b11) ? pht[hashed_index_t] + 1 : pht[hashed_index_t];
                else
                    pht[hashed_index_t] <= (pht[hashed_index_t] != 2'b00) ? pht[hashed_index_t] - 1 : pht[hashed_index_t];
            end   
       		if (predict_valid)
            	predict_history <= {predict_history[5:0], predict_taken};
            if (train_valid && train_mispredicted)
                predict_history <= {train_history[5:0], train_taken};
        end
    end    

endmodule
