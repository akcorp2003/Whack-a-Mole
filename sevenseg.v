module game_sevenseg(
 input clk, reset,
 input [3:0] mole_location, 
 input a1, b1, c1, d1, e1, f1, g1, //the drawing of the mole
 input [31:0] advance,
 input level_mode,
 input [3:0] an_thou, an_hund, an_tens, an_ones,
 output A, B, C, D, E, F, G, 
 output [3:0] anode_EN
 );
 
reg [16:0] counter;

always @ (posedge clk or posedge reset)
begin
	if(reset)
		counter <= 0;
	else
		counter <= counter + 1;
end 

reg [6:0] output_temp; //the seven-seg display
reg [3:0] display_temp;
reg [3:0] number_to_display;

always @ (*)
begin

	if(level_mode == 0)
	begin

	case(counter[15:14])
	
		2'b00: //refresh rightmost display
		begin
			if(mole_location == 4'b1110)
			begin
				output_temp = {g1,f1,e1,d1,c1,b1,a1};
			end
			else
			begin
				output_temp = 7'b0111111; //display a dash
			end
			display_temp = 4'b1110;
		end
		
		2'b01: //refresh the second from the right display
		begin
			if(mole_location == 4'b1101)
			begin
				output_temp = {g1,f1,e1,d1,c1,b1,a1};
			end
			else
			begin
				output_temp = 7'b0111111;
			end
			display_temp = 4'b1101;
		end
		
		2'b10: //refresh the second from left display
		begin
			if(mole_location == 4'b1011)
			begin
				output_temp = {g1,f1,e1,d1,c1,b1,a1};
			end
			else
			begin
				output_temp = 7'b0111111;
			end
			display_temp = 4'b1011;
		end
		
		2'b11: //refresh the leftmost display
		begin
			if(mole_location == 4'b0111)
			begin
				output_temp = {g1,f1,e1,d1,c1,b1,a1};
			end
			else
			begin
				output_temp = 7'b0111111;
			end
			display_temp = 4'b0111;
		end
		default:
		begin
			output_temp = 7'b0111111;
			display_temp = 4'b0111;
		end
	endcase
	end//end if
	else
	begin
		
		case (counter[15:14])
			2'b00:
			begin
				display_temp = 4'b1110;
				number_to_display = an_ones;
			end
			
			2'b01:
			begin
				display_temp = 4'b1101;
				number_to_display = an_tens;
			end
			
			2'b10:
			begin
				display_temp = 4'b1011;
				number_to_display = an_hund;
			end
			
			2'b11:
			begin
				display_temp = 4'b0111;
				number_to_display = an_thou;
			end
			default:
			begin
				display_temp = 4'b0000;
				number_to_display = 4'b1111;
			end
		endcase
		
		case(number_to_display)
			4'd0:
				output_temp = 7'b1000000;
			4'd1:
				output_temp = 7'b1111001;
			4'd2:
				output_temp = 7'b0100100;
			4'd3:
				output_temp = 7'b0110000;
			4'd4:
				output_temp = 7'b0011001;
			4'd5:
				output_temp = 7'b0010010;
			4'd6:
				output_temp = 7'b0000010;
			4'd7:
				output_temp = 7'b1111000;
			4'd8:
				output_temp = 7'b0000000;
			4'd9:
				output_temp = 7'b0010000;
			default:
				output_temp = 7'b0111111;
		endcase
	end//end else
end

assign anode_EN = display_temp;
assign {G,F,E,D,C,B,A} = output_temp;
 
 
endmodule 