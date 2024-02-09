module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
); //

    control c1 (reset, enable, Q, c_enable, c_load, c_d);
   	count4 the_counter (clk, c_enable, c_load, c_d , Q );
endmodule

module control (
    input reset,
    input enable,
    input [3:0] qin,
    output c_enable,
    output c_load,
    output [3:0] c_d
);
    always @(*) begin
        c_enable <= enable;
        if (reset || (qin == 12 && enable)) begin   //Check Slow Decade counter code
            c_load <= 1;
            c_d <= 1;
        end
        else
            c_load = 0;
    end
endmodule
