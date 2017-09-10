`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:17:25 09/09/2017 
// Design Name: 
// Module Name:    variableType 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module variableType(out,answer,A,B,C,D,E,F);
	
	input [7:0]A,B,C,D,E,F;
	
	output [10:0]out,answer;
	reg [10:0]out,answer;
	
	reg [47:0]X;
	reg [7:0]Z;
		
	integer count;
	
	always @(A or B or C or D or E or F)
		begin
			out = 0;
			X = {F,E,D,C,B,A};
			
			for (count = 0; count < 7; count = count + 1)
				begin
					Z = X&48'h0000000000FF;
					out = out + Z;
					X = X >> 8;
				end
				answer = out/4;
			end
								
endmodule

module test;

	wire [10:0]out,answer;
	
	reg [7:0]A,B,C,D,E,F;
	
	variableType haha(out,answer,A,B,C,D,E,F);
	
	initial
		begin
			A = 8'b00000011;
			B = 8'b00000011;
			C = 8'b00000011;
			D = 8'b00000011;
			E = 8'b00000011;
			F = 8'b00000011;
			#50 $finish;
		end
		
endmodule
