module multiplier(out,A,B,clk,reset);

	output [15:0]out;
	reg [15:0]out;
	
	input [7:0]A,B;
	input clk,reset;
	
	integer mult;
	
	always @(negedge clk or reset)
		begin
			if(reset)
				out = 0;
			else
				case({A[7],B[7]})
					2'b00:begin out = A*B;end
					2'b01:begin out = A*((~B)+1);end
					2'b10:begin out = ((~A)+1)*B;end
					2'b11:begin mult = ((~A)+1)*((~B)+1);
									out = (~mult)+1;end
					default:begin out = 16'hXXXX;end
				endcase
		end
endmodule

module test;
	
	wire [15:0]out;
	
	reg [7:0]A,B;
	reg clk,reset;
	
	multiplier labProject(out,A,B,clk,reset);
	
	initial
		clk = 1'b1;
		always
			#5 clk = ~clk;
	
	initial
		begin
			A = 5;
			B = 13;
			#10 B = -13;
			#16 A = -5;
			#20 reset = 1;
			#10 $finish;
		end
endmodule
