module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);

    wire eni = 1'b1;
    bcdcntr d1 (clk, eni, reset, q[3:0]);
    and (ena[1], q[3], q[0]);
    bcdcntr d2 (clk, ena[1], reset, q[7:4]);
    and (ena[2], q[7], q[4], ena[1]);
    bcdcntr d3 (clk, ena[2], reset, q[11:8]);
    and (ena[3], q[11], q[8], ena[2]);
    bcdcntr d4 (clk, ena[3], reset, q[15:12]);
    
endmodule

// 1-digit 4bit BCD counter with enable (module from slow decade counter)
module bcdcntr (
    input clk,
    input enin,
    input reset,
    output [3:0] qout);
    always @(posedge clk)begin
        if (reset || (qout == 9 && enin))begin
            qout <= 0;
        end
    	else if(enin)begin
            	qout <= qout + 1;
    	end
    end    
endmodule