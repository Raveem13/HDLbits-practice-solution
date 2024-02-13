module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4);

    //-------------Internal Constants-----------------
    parameter A=1, B=2, C=3, D=4, E=5, F=6;  //Bit positions of one hot encoding used
    
    // Output logic - Combinational output logic 
    // Y2 = ~w & y[1]
    assign Y2 = ~w & y[A] ;  
    // Y4 = w & (y[2] | y[3] | y[5] | y[6])
    assign Y4 = w & (y[B] | y[C] | y[E] | y[F]) ;    
    
endmodule