module mole_generator(input clk, input restart, input [3:0] level,
							 output a_mole, b_mole, c_mole, d_mole, e_mole, f_mole, g_mole, 
							 output [3:0] anode_en_mole,
							 output [2:0] type_of_mole);
							 
//type of mole is defined as follows:
//0 -plague
//1 - normal
//2 - Royal
//3 - Master Chief

wire [14:0] rand;
wire [9:0] plague;
wire [7:0]  location;
reg [6:0] temp_mole;	
reg [3:0] temp_anode;	
reg [2:0] temp_typeofmole;

//instantiate the lfsrs
lfsr_15bit mole_generation(.clk(clk), .restart(restart), .rand(rand));
lfsr_8bit  mole_location(.clk(clk), .restart(restart), .rand(location));
lfsr_10bit plaguemole(.clk(clk), .restart(restart), .rand(plague));

always @(rand)
begin
	if(rand <= 328) //Master Chief Mole, 1% chance of appearing
		begin
			temp_mole = 7'b0000000;
			temp_typeofmole = 3;
		end
	else if(rand >328 && rand <= 9831) //Royal Mole, 29% chance of appearing
		begin
			temp_mole = 7'b0100100;
			temp_typeofmole = 2;
		end
	
	else if(rand > 9831 && rand <= 32767) //Normal mole (70% chance)/ Plague Mole
		begin
			case(level)
				1:
					begin
						//start off with only 5% chance
						if(plague < 51)
						begin
							temp_mole = 7'b1000000;
							temp_typeofmole = 0;
						end
						else
						begin
							temp_mole = 7'b1111001;
							temp_typeofmole = 1;
						end
					end
				2:
					begin
						//10% chance
						if(plague <103)
						begin
							temp_mole = 7'b1000000;
							temp_typeofmole = 0;
						end
						else
						begin
							temp_mole = 7'b1111001;
							temp_typeofmole = 1;
						end
					end
				3:
					begin
						//15% chance
						if(plague <154)
						begin
							temp_mole = 7'b1000000;
							temp_typeofmole = 0;
						end
						else
						begin
							temp_mole = 7'b1111001;
							temp_typeofmole = 1;
						end
					end
				4:
					begin
						//20% chance
						if(plague < 205)
						begin
							temp_mole = 7'b1000000;
							temp_typeofmole = 0;
						end
						else
						begin
							temp_mole = 7'b1111001;
							temp_typeofmole = 1;
						end
					end
				5:
					begin
						//25% chance
						if(plague < 266)
						begin
							temp_mole = 7'b1000000;
							temp_typeofmole = 0;
						end
						else
						begin
							temp_mole = 7'b1111001;
							temp_typeofmole = 1;
						end
					end
				6:
					begin
						//30% chance
						if(plague < 307)
						begin
							temp_mole = 7'b1000000;
							temp_typeofmole = 0;
						end
						else
						begin
							temp_mole = 7'b1111001;
							temp_typeofmole = 1;
						end
					end
				7:
					begin
						//35% chance
						if(plague < 358)
						begin
							temp_mole = 7'b1000000;
							temp_typeofmole = 0; 
						end
						else
						begin
							temp_mole = 7'b1111001;
							temp_typeofmole = 1;
						end
					end
				8:
					begin
						//50% chance
						if(plague < 512)
						begin
							temp_mole = 7'b1000000;
							temp_typeofmole = 0;
						end
						else
						begin
							temp_mole = 7'b1111001;
							temp_typeofmole = 1;
						end
					end
				default: //just present a normal mole....
				begin
					temp_mole = 7'b1111001;
					temp_typeofmole = 1;
				end
				endcase
				
		end
	else //default case
		begin
			temp_mole = 7'b0111111;
			temp_typeofmole = 6; //error case
		end
	
	if(location >= 0 && location < 64)
		temp_anode <= 4'b1110;
	else if(location >= 64 && location < 128)
		temp_anode <= 4'b1101;
	else if(location >= 128 && location < 192)
		temp_anode <= 4'b1011;
	else
		temp_anode <= 4'b0111;
end

assign {g_mole, f_mole, e_mole, d_mole, c_mole, b_mole, a_mole} = temp_mole;
assign anode_en_mole = temp_anode;
assign type_of_mole = temp_typeofmole;
			
endmodule 