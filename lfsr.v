module lfsr_15bit(input clk, input restart,
				output [14:0] rand);
				
reg [14:0] random, random_official;
reg [4:0] counter; //keep track of the number of shifts before we output the final value
reg [14:0] rand1;

wire feedback;
assign feedback = random [14] ^ random[13]; //for a 16 bit random value, we tap the 14th and 13th bit

always @ (posedge clk or posedge restart)
begin
	if(restart)
	begin
		random = 15'hF; //an lfsr cannot have a 0 state
		counter = 0;
	end
	else
	begin
		random = {random[13:0], feedback};
		rand1 = random;
	end
end


assign rand = rand1;
				
endmodule

module lfsr_8bit(input clk, input restart,
					  output [7:0] rand);
	
reg [7:0] random, random_official;
reg [7:0] rand1;

wire feedback = random [7] ^ random[5] ^ random[4] ^ random[3]; //for a 4 bit random value, we tap the 8th, 6th bit, 5th, and 4th bits

always @ (posedge clk or posedge restart)
begin
	if(restart)
	begin
		random = 8'hF; //an lfsr cannot have a 0 state
	end
	else
	begin
		random = {random[6:0], feedback};
		rand1 = random;
	end
	
end

assign rand = rand1;

endmodule 

module lfsr_10bit(input clk, input restart,
					  output [9:0] rand);
	
reg [9:0] random;
reg [9:0] rand1;

wire feedback = random [9] ^ random[6]; //for a 10 bit random value, we tap the 10th and 7th bit

always @ (posedge clk or posedge restart)
begin
	if(restart)
	begin
		random = 10'hF; //an lfsr cannot have a 0 state
	end
	else
	begin
		random = {random[8:0], feedback};
		rand1 = random;
	end
end

assign rand = rand1;	

endmodule 