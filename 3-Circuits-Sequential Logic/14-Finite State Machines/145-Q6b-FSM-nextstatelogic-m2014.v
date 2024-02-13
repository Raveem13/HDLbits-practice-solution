module top_module (
    input [3:1] y,
    input w,
    output Y2);
    
    //-------------Internal Constants-----------------
    parameter A=0, B=1, C=2, D=3, E=4, F=5;  // States 

    // Output logic - Combinational output logic, Y2 = (B | F) | w & (C | E)
    assign Y2 = (y == B | y == F) | w & (y == C | y == E);
    
endmodule