module mastergame (input clk, input RESTART, input hit_4, input hit_3, input hit_2, input hit_1, 
						 input SWITCH, 
						 output [3:0] level,
						 output a, b, c, d, e, f, g,
						 output Led0, Led1, Led2, Led3, Led4, Led5, Led6, Led7,
						 output [3:0] anode_en);

reg a1, b1, c1, d1, e1, f1, g1;
wire a11, b11, c11, d11, e11, f11, g11;
//wire a, b, c, d, e, f, g;
wire [3:0] anode_en;
reg hit = 0;
integer advance_flag;
wire [3:0] anode_en1;
wire [2:0] mole_type;
reg [2:0] curr_mole;
reg [3:0] level;
reg [9:0] overall_score; //the maximum score a player can achieve in the game is
reg [9:0] level_score; //the max score a player can achieve in a level is 1000 (legendary where all moles are Master Chiefs)
wire [9:0] level_score_out;
reg [6:0] num_moles; //at most, the game will have 100 moles in a level
wire game_clk;
reg [3:0] anode_temp1; //holds the mole generated
reg [3:0] totalthou, totalhund, totaltens, totalones; //registers that will hold the anod


mole_generator the_moler( .clk(clk), .restart(RESTART), .level(level), .type_of_mole(mole_type), 
								.a_mole(a11), .b_mole(b11), .c_mole(c11), .d_mole(d11), .e_mole(e11), .f_mole(f11), .g_mole(g11),
								.anode_en_mole(anode_en1) );
								
game_clock mygame_clk(.clk(clk), .reset(RESTART), .clk1(game_clk));
								
game_sevenseg myseven (.clk(clk), .reset(RESTART), .mole_location(anode_temp1), .advance(advance_flag), .level_mode(SWITCH),
						.an_thou(totalthou), .an_hund(totalhund), .an_tens(totaltens), .an_ones(totalones),
						.a1(a1), .b1(b1), .c1(c1), .d1(d1), .e1(e1), .f1(f1), .g1(g1), .anode_EN(anode_en),
						.A(a), .B(b), .C(c), .D(d), .E(e), .F(f), .G(g));
						
					 
/////////////////////////////////////////////
// hit checker                             //
/////////////////////////////////////////////
wire ahit1_i;
wire ahit2_i;
wire ahit3_i;
wire ahit4_i;

assign ahit1_i = hit_1;
assign ahit2_i = hit_2;
assign ahit3_i = hit_3;
assign ahit4_i = hit_4;

reg [27:0] hit1counter;
reg realhit1;
wire Hit1;
assign Hit1 = realhit1;

always @(posedge clk or posedge ahit1_i or posedge RESTART)
begin
	if(RESTART)
	begin
		hit1counter <= 0;
		realhit1 <= 0;
	end
	else
	begin
		if(ahit1_i)
		begin
			hit1counter <= hit1counter + 1;
		end
		else if(hit1counter == 100000)
		begin
			hit1counter <= 0;
			realhit1 <= 0;
		end
		else if(hit1counter > 0)
		begin
			hit1counter <= hit1counter + 1;
			realhit1 <= 1;
		end
	end
end

reg [27:0] hit2counter;
reg realhit2;
wire Hit2;
assign Hit2 = realhit2;

always @(posedge clk or posedge ahit2_i or posedge RESTART)
begin
	if(RESTART)
	begin
		hit2counter <= 0;
		realhit2 <= 0;
	end
	else
	begin
		if(ahit2_i)
		begin
			hit2counter <= hit2counter + 1;
		end
		else if(hit2counter == 100000)
		begin
			hit2counter <= 0;
			realhit2 <= 0;
		end
		else if(hit2counter > 0)
		begin
			hit2counter <= hit2counter + 1;
			realhit2 <= 1;
		end
	end
end

reg [27:0] hit3counter;
reg realhit3;
wire Hit3;
assign Hit3 = realhit3;

always @(posedge clk or posedge ahit3_i or posedge RESTART)
begin
	if(RESTART)
	begin
		hit3counter <= 0;
		realhit3 <= 0;
	end
	else
	begin
		if(ahit3_i)
		begin
			hit3counter <= hit3counter + 1;
		end
		else if(hit3counter == 100000)
		begin
			hit3counter <= 0;
			realhit3 <= 0;
		end
		else if(hit3counter > 0)
		begin
			hit3counter <= hit3counter + 1;
			realhit3 <= 1;
		end
	end
end



reg [27:0] hit4counter;
reg realhit4;
wire Hit4;
assign Hit4 = realhit4;

always @(posedge clk or posedge ahit4_i or posedge RESTART)
begin
	if(RESTART)
	begin
		hit4counter <= 0;
		realhit4 <= 0;
	end
	else
	begin
		if(ahit4_i)
		begin
			hit4counter <= hit4counter + 1;
		end
		else if(hit4counter == 100000)
		begin
			hit4counter <= 0;
			realhit4 <= 0;
		end
		else if(hit4counter > 0)
		begin
			hit4counter <= hit4counter + 1;
			realhit4 <= 1;
		end
	end
end

integer increment1 = 0;
integer decrement2 = 0;
integer increment2 = 0;
integer increment10 = 0;

reg [13:0] total_score;


////////////////////////////////
// Hit and Score Handling     //
////////////////////////////////
					 
always @ (posedge game_clk or posedge RESTART)
begin

if(RESTART == 1)
begin
	level <= 1;
	level_score = 0;
	total_score = 0;
	totalthou <= 0;
	totalhund <= 0;
	totaltens <= 0;
	totalones <= 0;
end
else
begin
	if( anode_temp1 == 4'b1110 && Hit1 == 1)
	begin
		hit = 1;
	end
	else if( anode_temp1 == 4'b1101 && Hit2 == 1)
	begin
		hit = 1;
	end
	else if( anode_temp1 == 4'b1011 && Hit3 == 1)
	begin
		hit = 1;
	end
	else if( anode_temp1 == 4'b0111 && Hit4 == 1)
	begin
		hit = 1;
	end
	else
	begin
		hit = 0;
	end
		
	if( hit == 1)
	begin
		if(curr_mole == 0)
		begin
			decrement2 = 1;
			level_score = level_score - 2;
			if(level_score <= 2)
				level_score = 0;
			if(total_score <= 1 )
				total_score = 0;
			else
				total_score = total_score - 2;
		end
		else if(curr_mole == 1)
		begin
			level_score = level_score + 1;
			total_score = total_score + 1;
			increment1 = 1;
		end
		else if(curr_mole == 2)
		begin
			level_score = level_score + 2;
			total_score = total_score + 2;
			increment2 = 1;
		end
		else if(curr_mole == 3)
		begin
			level_score = level_score + 10;
			total_score = total_score + 10;
			increment10 = 1;
		end
		else
			level_score = level_score;
	end
	else
		level_score = level_score;
		
	//check if the user is eligible to move onto the next level
	case (level)
		1:
			begin
				if(level_score == 10)
				begin
					level <= level + 1;
					level_score = 0;
					advance_flag = 1;
				end
				else
				begin
					level <= level;
					advance_flag = 0;
				end
			end
		2:
			begin
				if(level_score == 20)
				begin
					level <= level + 1;
					level_score = 0;
					advance_flag = 1;
				end
				else
				begin
					level <= level;
					advance_flag = 0;
				end
			end
		3:
			begin
				if(level_score == 25)
				begin
					level <= level + 1;
					level_score = 0;
					advance_flag = 1;
				end
				else
				begin
					level <= level;
					advance_flag = 0;
				end
			end
		4:
			begin
				if(level_score == 30)
				begin
					level <= level + 1;
					level_score = 0;
					advance_flag = 1;
				end
				else
				begin
					level <= level;
					advance_flag = 0;
				end
			end
		5:
			begin
				if(level_score == 35)
				begin
					level <= level + 1;
					level_score = 0;
					advance_flag = 1;
				end
				else
				begin
					level <= level; 
					advance_flag = 0;
				end
			end
		6:
			begin
				if(level_score == 40)
				begin
					level <= level + 1;
					level_score = 0;
					advance_flag = 1;
				end
				else
				begin
					level <= level;
					advance_flag = 0;
				end
			end
		7:
			begin
				if(level_score == 45)
				begin
					level <= level + 1;
					level_score = 0;
					advance_flag = 1;
				end
				else
				begin
					level <= level;
					advance_flag = 0;
				end
			end
		8:
			begin
				if(level_score == 75)
				begin
					level <= 1; //restart the game!!
					level_score = 0;
					advance_flag = 1;
				end
				else
				begin
					level <= level;
					advance_flag = 0;
				end
			end
		default:
		begin
			level <= level;
			advance_flag = 0;
		end
	endcase
end

/////////total score calculation///////////////////
if (increment1 == 1 || increment2 == 1 || decrement2 == 1 || increment10 == 1)
	begin
		//handle each incrementation case-by-case
		if( increment1 == 1)
		begin
			increment1 = 0;
			if(totalones == 9)
			begin
				totalones <= 0;
				if(totaltens == 9)
				begin
					totaltens <= 0;
					if(totalhund == 9)
					begin
						totalhund <= 0;
						if(totalthou == 9)
						begin
							totalthou <= 0;
						end
						else
						begin
							totalthou <= totalthou + 1;
						end
					end
					else
						totalhund <= totalhund + 1;
				end
				else
					totaltens <= totaltens + 1;
			end
			else
				totalones <= totalones + 1;
		end//end increment1 if
		else if(increment2 == 1)
		begin
			increment2 = 0;
			if(totalones == 8 || totalones == 9) //for the case of 9999 or 9998, we reset the total score to be 0;
			begin
				totalones <= 0;
				if(totaltens == 9)//xx98 --> +2 --> xx00 or simply totaltens+1
				begin
					totaltens <= 0;
					if(totalhund == 9)
					begin
						totalhund <= 0;
						if(totalthou == 9)
						begin
							totalthou <= 0;
						end
						else
							totalthou <= totalthou + 1;
					end
					else
						totalhund <= totalhund + 1;
				end
				else
					totaltens <= totaltens + 1;
			end
			else
				totalones <= totalones + 2;
		end//end increment2 elseif
		else if (decrement2 == 1)
		begin
			decrement2 = 0;
			if(total_score <= 1) //prevent any negative values poppping up
			begin
				totalones <= 0;
				totaltens <= 0;
				totalhund <= 0;
				totalthou <= 0;
			end
			else
			begin
				if(totalones == 1)
				begin
					totalones <= 9;
					if(totaltens == 0)
					begin
						totaltens <= 9;
						if(totalhund == 1)
						begin
							totalhund <= 0;
						end
						else if(totalhund == 0)
						begin
							totalhund <= 9;
							if(totalthou == 1)
							begin
								totalthou <= 0;
							end
							else
								totalthou <= totalthou - 1;
						end
						else
							totalhund <= totalhund - 1;
					end
					else
						totaltens <= totaltens - 1;
				end
				else
					totalones <= totalones - 2;
			end
		end//end decrement2 elseif
		else//case of increment10
		begin
			if(total_score >= 9990)
			begin
				//basically a reset
				totalones <= 0;
				totaltens <= 0;
				totalhund <= 0;
				totalthou <= 0;
			end
			else
			begin
				//we do not need to handle a case for totalones
				if(totaltens == 9)
				begin
					totaltens <= 0;
					if(totalhund == 9)
					begin
						totalhund <=0;
						totalthou <= totalthou + 1;
					end
					else
						totalhund <= totalhund + 1;
				end
				else
					totaltens <= totaltens + 1;
			end
					
		end//end increment10 else
	end//end if
else
begin
end

end//end always


////////////////////////////////////////////////////////
// mole frequency                                     //
////////////////////////////////////////////////////////
reg [27:0] freq_counter; //the slowest appearance of moles on the 
                         //display will be 1 every 3 seconds
reg [27:0] freq_counter2;


always @ (posedge clk or posedge RESTART)
begin

if(RESTART)
begin
	freq_counter = 0;
	anode_temp1 <= 0;
	curr_mole <= 9;
end
else
begin

if(SWITCH != 1)
begin	
	freq_counter = freq_counter + 1;	
	case(level)
		1:
			begin
				if(freq_counter == 150000000)
				begin
					anode_temp1 <= anode_en1;
					curr_mole <= mole_type;
					freq_counter = 0;
				end
				else
					anode_temp1 <= anode_temp1; //keep the previous state
			end
		2:
			begin
				if(freq_counter == 125000000)
				begin
					anode_temp1 <= anode_en1;
					curr_mole <= mole_type;
					freq_counter = 0;
				end
				else
					anode_temp1 <= anode_temp1;
			end
		3:
			begin
				if(freq_counter == 110000000)
				begin
					anode_temp1 <= anode_en1;
					curr_mole <= mole_type;
					freq_counter = 0;
				end
				else
					anode_temp1 <= anode_temp1;
			end
		4:
			begin
				if(freq_counter == 100000000)
				begin
					anode_temp1 <= anode_en1;
					curr_mole <= mole_type;
					freq_counter = 0;
				end
				else
					anode_temp1 <= anode_temp1;
			end
		5:
			begin
				if(freq_counter == 80000000)
				begin
					anode_temp1 <= anode_en1;
					curr_mole <= mole_type;
					freq_counter = 0;
				end
				else
					anode_temp1 <= anode_temp1;
			end
		6:
			begin
				if(freq_counter == 60000000)
				begin
					anode_temp1 <= anode_en1;
					curr_mole <= mole_type;
					freq_counter = 0;
				end
				else
					anode_temp1 <= anode_temp1;
			end
		7:
			begin
				if(freq_counter == 50000000)
				begin
					anode_temp1 <= anode_en1;
					curr_mole <= mole_type;
					freq_counter = 0;
				end
				else
					anode_temp1 <= anode_temp1;
			end
		8:
			begin
				if(freq_counter == 25000000)
				begin
					anode_temp1 <= anode_en1;
					curr_mole <= mole_type;
					freq_counter = 0;
				end
				else
					anode_temp1 <= anode_temp1;
			end
		default:
		begin
			anode_temp1 <= anode_temp1;
			curr_mole <= 9;
		end
	endcase
end//end SWITCH if
else
begin
end//end SWITCH else	
end
end

//the accompanying seven segment display frequencies to go with the mole frequency
always @ (posedge clk or posedge RESTART)
begin
	if(RESTART)
	begin
		freq_counter2 = 0;
		a1 <= 0;
		b1 <= 0;
		c1 <= 0;
		d1 <= 0;
		e1 <= 0;
		f1 <= 0;
		g1 <= 0;
	end
	else
	begin
	if(SWITCH != 1)
	begin
		freq_counter2 = freq_counter2 + 1;

		case(level)
			1:
				begin
					if(freq_counter2 == 150000000)
					begin
						freq_counter2 = 0;
						a1 <= a11;
						b1 <= b11;
						c1 <= c11;
						d1 <= d11;
						e1 <= e11;
						f1 <= f11;
						g1 <= g11;
					end
					else
					begin
						a1 <= a1;
						b1 <= b1;
						c1 <= c1;
						d1 <= d1;
						e1 <= e1;
						f1 <= f1;
						g1 <= g1;
					end
				end
			2:
				begin
					if(freq_counter2 == 125000000)
					begin
						freq_counter2 = 0;
						a1 <= a11;
						b1 <= b11;
						c1 <= c11;
						d1 <= d11;
						e1 <= e11;
						f1 <= f11;
						g1 <= g11;
					end
					else
					begin
						a1 <= a1;
						b1 <= b1;
						c1 <= c1;
						d1 <= d1;
						e1 <= e1;
						f1 <= f1;
						g1 <= g1;
					end
				end
			3:
				begin
					if(freq_counter == 110000000)
					begin
						freq_counter2 = 0;
						a1 <= a11;
						b1 <= b11;
						c1 <= c11;
						d1 <= d11;
						e1 <= e11;
						f1 <= f11;
						g1 <= g11;
					end
					else
					begin
						a1 <= a1;
						b1 <= b1;
						c1 <= c1;
						d1 <= d1;
						e1 <= e1;
						f1 <= f1;
						g1 <= g1;
					end

				end
			4:
				begin
					if(freq_counter == 100000000)
					begin
						freq_counter2 = 0;
						a1 <= a11;
						b1 <= b11;
						c1 <= c11;
						d1 <= d11;
						e1 <= e11;
						f1 <= f11;
						g1 <= g11;
					end
					else
					begin
						a1 <= a1;
						b1 <= b1;
						c1 <= c1;
						d1 <= d1;
						e1 <= e1;
						f1 <= f1;
						g1 <= g1;
					end
				end
			5:
				begin
					if(freq_counter == 80000000)
					begin
						freq_counter2 = 0;
						a1 <= a11;
						b1 <= b11;
						c1 <= c11;
						d1 <= d11;
						e1 <= e11;
						f1 <= f11;
						g1 <= g11;
					end
					else
					begin
						a1 <= a1;
						b1 <= b1;
						c1 <= c1;
						d1 <= d1;
						e1 <= e1;
						f1 <= f1;
						g1 <= g1;
					end
				end
			6:
				begin
					if(freq_counter == 60000000)
					begin
						freq_counter2 = 0;
						a1 <= a11;
						b1 <= b11;
						c1 <= c11;
						d1 <= d11;
						e1 <= e11;
						f1 <= f11;
						g1 <= g11;
					end
					else
					begin
						a1 <= a1;
						b1 <= b1;
						c1 <= c1;
						d1 <= d1;
						e1 <= e1;
						f1 <= f1;
						g1 <= g1;
					end
				end
			7:
				begin
					if(freq_counter == 50000000)
					begin
						freq_counter2 = 0;
						a1 <= a11;
						b1 <= b11;
						c1 <= c11;
						d1 <= d11;
						e1 <= e11;
						f1 <= f11;
						g1 <= g11;
					end
					else
					begin
						a1 <= a1;
						b1 <= b1;
						c1 <= c1;
						d1 <= d1;
						e1 <= e1;
						f1 <= f1;
						g1 <= g1;
					end
				end
			8:
				begin
					if(freq_counter == 25000000)
					begin
						freq_counter2 = 0;
						a1 <= a11;
						b1 <= b11;
						c1 <= c11;
						d1 <= d11;
						e1 <= e11;
						f1 <= f11;
						g1 <= g11;
					end
					else
					begin
						a1 <= a1;
						b1 <= b1;
						c1 <= c1;
						d1 <= d1;
						e1 <= e1;
						f1 <= f1;
						g1 <= g1;
					end
				end
			default:
				begin
					a1 <= a1;
					b1 <= b1;
					c1 <= c1;
					d1 <= d1;
					e1 <= e1;
					f1 <= f1;
					g1 <= g1;
				end
		endcase
	end//end SWITCH if
	else
	begin
	end//end SWITCH else
	end//end else
end

/////////////////////////////////////////
// LED display                         //
/////////////////////////////////////////

//wire led_0, led_1, led_2, led_3, led_4, led_5,led_6, led_7;

LEDBlink LED_level( .level(level), .clk(clk), .reset(RESTART),
						  .led_0(Led0), .led_1(Led1), .led_2(Led2), .led_3(Led3), .led_4(Led4), .led_5(Led5), .led_6(Led6),
						  .led_7(Led7) );


/*assign anode_en = anode_final;
assign {g, f, e, d, c, b, a} = {g1, f1, e1, d1, c1, b1, a1};*/

endmodule 