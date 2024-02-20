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

    parameter PHT_SIZE = 128;

    reg [1:0] pht[PHT_SIZE-1:0];
    reg [6:0] ghr;
    reg [6:0] hashed_index_p;
    reg [6:0] hashed_index_t;

    always @(*) begin
        begin
            hashed_index_p = predict_pc ^ predict_history;
        	predict_taken = (pht[hashed_index_p] == 2'b11 || pht[hashed_index_p] == 2'b10);
        end
    end

    always @(posedge clk, posedge areset) begin
        if (areset) begin
            predict_history <= 0;
            for (int i = 0; i < PHT_SIZE; i = i + 1)
                pht[i] <= 2'b01;
        end
        else if (predict_valid) begin
            if (train_valid) begin
                hashed_index_t = train_history ^ train_pc;
                if (train_mispredicted)
                    predict_history <= {train_history[5:0], train_taken};
                else
                    predict_history <= {predict_history[5:0], predict_taken};
                if (train_taken)
                    pht[hashed_index_t] <= (pht[hashed_index_t] != 2'b11) ? pht[hashed_index_t] + 1 : pht[hashed_index_t];
                else
                    pht[hashed_index_t] <= (pht[hashed_index_t] != 2'b00) ? pht[hashed_index_t] - 1 : pht[hashed_index_t];
            end   
            else
            	predict_history <= {predict_history[5:0], predict_taken};
        end
        //else
            //predict_history <= predict_history ;
    end
    
endmodule

/*
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

            // Parameters
        parameter PHT_SIZE = 128;
        parameter GHR_SIZE = 7;

        // Registers
        reg [1:0] pht[PHT_SIZE-1:0];
        reg [6:0] ghr;
        reg [6:0] hashed_index_t, hashed_index_p;
        reg [6:0] predicted_index;
        reg [1:0] predicted_outcome;

        // Hashing function
        always @* begin
        hashed_index_p = predict_pc ^ predict_history ;
        predict_taken = ( pht[hashed_index_p] == 2'b11 || pht[hashed_index_p] == 2'b10);
        end

        // Sequential Logic - State Update
        always @(posedge clk, posedge areset) begin
            if (areset) begin
                ghr <= 0;
                // predict_taken <= 0;
                predict_history <= 0;
                // Reset PHT entries to weakly not taken (WNT)
                for (int i = 0; i < PHT_SIZE; i = i + 1) begin
                    pht[i] <= 2'b01;
                end
            end
            else begin

                if (train_valid) begin
                    if (train_mispredicted)        //
                        predict_history <= ( train_history << 1 | train_taken );
                    else begin
                        
                        predict_history <= ( predict_history << 1 | predict_taken );
                    end
                    hashed_index_t = train_history ^ train_pc;
                        if (train_taken) begin
                            if (pht[hashed_index_t] != 2'b11)
                                pht[hashed_index_t] <= pht[hashed_index_t] + 1;
                        end
                        else begin
                            if (pht[hashed_index_t] != 2'b00)
                                pht[hashed_index_t] <= pht[hashed_index_t] - 1;
                        end
                end
                else if (predict_valid) begin
                    predict_history <= ( predict_history << 1 | predict_taken );
                    // hashed_index_p = predict_pc ^ predict_history ;
                    // predict_taken = ( pht[hashed_index_p] == 2'b11 || pht[hashed_index_p] == 2'b10);
                end
        /*    else if (predict_valid) begin
                ghr <= predict_history;
                predict_history <= ( predict_history << 1 | predict_taken );
            end */
            end
        end    
        
    endmodule

*/