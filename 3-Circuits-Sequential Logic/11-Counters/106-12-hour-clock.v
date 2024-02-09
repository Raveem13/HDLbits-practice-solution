module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
	
    wire s1en, m0en, m1en, h0en, pmen;
    wire [3:0] pmchange;
    
    bcd10cntr s0(clk, ena, reset, ss[3:0]);
    and (s1en, ss[3], ss[0], ena);
    bcd10cntr #( .MAX(5) ) s1(clk, s1en, reset, ss[7:4]);
    
    and (m0en, ss[6], ss[4], s1en);
    
    bcd10cntr m0(clk, m0en, reset, mm[3:0]);
    and (m1en, mm[3], mm[0], m0en);
    bcd10cntr #( .MAX(5) ) m1(clk, m1en, reset, mm[7:4]);    
    
    and (h0en, mm[6], mm[4], m1en);
    
    bcd12cntr hh10(clk, h0en, reset, hh[7:0]);

    bcd10cntr #( .MAX(11) ) pm0(clk, h0en, reset, pmchange[3:0]);  //0-11 = 4'b1011
    and (pmen, pmchange[3], pmchange[1], pmchange[0], h0en);
    pmstate (clk, pmen, pm);
    //bcd10cntr h0(clk, h0en, reset, hh[3:0]); // reset @ 9 & 12.
    //and (h1en, hh[3], hh[0], h0en);      
    //bcd10cntr #( .MAX(1) ) h1(clk, h1en, reset, hh[7:4]);      
    
endmodule

// 1-digit 4bit "Parameterized module" of BCD counter with enable (module from slow decade counter)
module bcd10cntr #(parameter MAX = 9) (
    input clk,
    input enin,
    input reset,
    output [3:0] qout);
    always @(posedge clk)begin
        if (reset || (qout == MAX && enin))begin
            qout <= 0;
        end
    	else if(enin)begin
            	qout <= qout + 1;
    	end
    end    
endmodule

// 1-digit 4bit mod 12 BCD counter with enable 
module bcd12cntr (
    input clk,
    input enin,
    input reset,
    output [7:0] qout);
    //output [7:0] qtemp;
    always @(posedge clk)begin
        if (reset)
            qout <= 8'h12;
        else if (qout == 8'h12 && enin)
            qout <= 1;
    	else if(enin)begin
            if (qout == 9)
                qout <= 16;
            else
                qout <= qout + 1;
    	end
    end    
endmodule

// Module for PM status check
module pmstate (
    input clk,
    input pmen,
    output pmflag);
    always @(posedge clk)begin
        if (pmen)
            pmflag <= pmflag ^ 1;  //Complement previous state
    end
endmodule