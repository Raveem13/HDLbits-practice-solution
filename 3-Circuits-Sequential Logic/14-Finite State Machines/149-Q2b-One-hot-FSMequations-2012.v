module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    //-------------Internal Constants-----------------
    parameter A=0, B=1, C=2, D=3, E=4, F=5;  //Bit positions of one hot encoding used
    
    // Output logic - Combinational output logic 
    // Y1 = w * y[0]
    assign Y1 = w & y[A] ;  
    // Y3 = ~w * (y[1] + y[2] + y[4] + y[5])
    assign Y3 = ~w & (y[B] | y[C] | y[E] | y[F]) ;        
    
endmodule