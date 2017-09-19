module divider_16by8(quotient,remainder,dividend,divisor,clr,clk);

	output [15:0]quotient,remainder;						//Declare quotient and remainder buses as output
	reg [15:0]quotient,remainder;
	
	input [15:0]dividend;									//Declare dividend bus as input
	input [7:0]divisor;										//Declare divisor bus as input
	input clr,clk;												//Declare clear and clock as inputs
	
	integer i,quo,temp,difference;						//Initialize variables to be used for temporary storage
	
	always @(negedge clk or clr)							//Define output update scenario
		begin
			if(clr)begin										//Set reset scenario
					quotient = 16'h0000;
					remainder = 16'h0000;end

			else if(divisor == 8'h00)begin				//Set output for divison by zero
					quotient = 16'hZZZZ;
					remainder = 16'hZZZZ;end

			else if(dividend == 16'h0000)begin			//Set output when dividend = 0
					quotient = 16'h0000;
					remainder = dividend;end
					
			else													//Code for legit inputs
				begin
					temp = dividend;
					for(i=1;i<=258;i=i+1)begin
						difference = temp - divisor;
						if(difference>=0)begin
							quo = i;
							temp = difference;end
						else if(difference<0)begin
							quotient = quo;
							remainder = difference + divisor;
							i = 258;end
					end
				end
		end

endmodule

module test;
	
	wire [15:0]quotient,remainder;
	
	reg [15:0]dividend;
	reg [7:0]divisor;
	reg clr,clk;
	
	divider_16by8 miniProject(quotient,remainder,dividend,divisor,clr,clk);
	
	initial
		clk = 1'b1;
		always
			#5 clk = ~clk;
	
	initial
		begin
			dividend = 16'hFFFF;
			divisor = 8'hFFFF;
			#19 clr = 1'b1;
			#5 $finish;
		end
		
endmodule
