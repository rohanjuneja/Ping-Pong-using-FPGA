`timescale 1ns / 1ps

// giving a clock pulse with every pushbutton press
module clk_pulse ( 
    input wire inp ,
    input wire cclk ,
    output wire outp  
);
reg delay1, delay2, delay3;

always @(posedge cclk)
begin
	   	delay1 <= inp;
	   	delay2 <= delay1;
	   	delay3 <= ~delay2;
end
assign outp = delay1 & delay2 & delay3;

endmodule
