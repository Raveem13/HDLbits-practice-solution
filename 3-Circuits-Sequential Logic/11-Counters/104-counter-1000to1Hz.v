module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); //

    wire [3:0] qout0, qout1, qout2 ;
    assign c_enable[0] = 1;
    bcdcount counter0 (clk, reset, c_enable[0], qout0 );
    and (c_enable[1], qout0[3], qout0[0]);
    //assign c_enable[1] = qout0[3] & qout0[0];
    bcdcount counter1 (clk, reset, c_enable[1], qout1);
    and (c_enable[2], qout1[3], qout1[0], c_enable[1]);
    //assign c_enable[2] = qout1[3] & qout1[0];
    bcdcount counter2 (clk, reset, c_enable[2], qout2);    
    assign OneHertz = qout2[3] & qout2[0] & c_enable[2];

endmodule