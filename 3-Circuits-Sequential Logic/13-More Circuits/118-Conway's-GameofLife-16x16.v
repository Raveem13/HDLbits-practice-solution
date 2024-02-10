module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 

    always @(posedge clk) begin
        if (load)
            q <= data;
        else begin
            for (integer i=0; i<16; i=i+1) begin
                for (integer j=0; j<16; j=j+1) begin
                	integer count = 0;
                    integer tni, bni, lni, rni; 
                    if (i == 0 && j == 0)begin
    					tni = 15;
                        bni = (i+1);
                    	lni = 15;
                        rni = (j+1);
                    end
                    else if (i == 15 && j == 15)begin
                        tni = (i-1);
    					bni = 0;
                        lni = (j-1);
                    	rni = 0;
                    end
                    else if (i == 0 && j == 15)begin
    					tni = 15;
                        bni = (i+1);
                        lni = (j-1);
                    	rni = 0;
                    end
                    else if (i == 15 && j == 0)begin
                        tni = (i-1);
    					bni = 0;
                    	lni = 15;
                        rni = (j+1);
                    end
                    else if (i == 0) begin
                        tni = 15;
                    	bni = (i+1);
                        lni = (j-1);
                        rni = (j+1);
                    end
                    else if (j == 0)begin
                        tni = (i-1);
                        bni = (i+1);
                        lni = 15;
                        rni = (j+1);
                    end
                    else if (i == 15)begin
                        tni = (i-1);
                        bni = 0;
                        lni = (j-1);
                        rni = (j+1);
                    end
                    else if (j == 15)begin
                        tni = (i-1);
                        bni = (i+1);
                        lni = (j-1);
                        rni = 0;
                    end
                    else begin
                        tni = (i-1);
                        bni = (i+1);
                        lni = (j-1);
                        rni = (j+1);
                    end
                    //      bottom      ,       top     ,   left    ,   right   ,       l-t     ,       l-b     ,       r-b     ,       r-t	
                    count = q[bni*16+j] + q[tni*16+j] + q[lni+i*16] + q[rni+i*16] + q[lni+tni*16] + q[lni+bni*16] + q[rni+bni*16] + q[rni+tni*16];
                    if(count < 2 || count >= 4)
                        q[i*16+j] <= 0;
                    else if(count == 3)
                        q[i*16+j] <= 1;
            	end
            end
        end
    end
    
endmodule