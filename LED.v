module LEDBlink( input [3:0] level, input clk, input reset,
					  output led_0, led_1, led_2, led_3, led_4, led_5, led_6, led_7);

reg [26:0] counter;
reg temp_led0, temp_led1, temp_led2, temp_led3, temp_led4, temp_led5, temp_led6, temp_led7;

always @ (posedge clk or posedge reset)
begin
	if(reset)
	begin
		counter <= 0;
	end
	else
	begin
		counter <= counter + 1;
	end
	
	case(level)
		1:
			begin
				//use the slowest blinker
				temp_led0 = 1; //leave this solid to indicate that this is the level
				temp_led1 = counter[26];
				temp_led2 = counter[26];
				temp_led3 = counter[26];
				temp_led4 = counter[26];
				temp_led5 = counter[26];
				temp_led6 = counter[26];
				temp_led7 = counter[26];
			end
		2:
			begin
				temp_led0 = counter[25];
				temp_led1 = 1;
				temp_led2 = counter[25];
				temp_led3 = counter[25];
				temp_led4 = counter[25];
				temp_led5 = counter[25];
				temp_led6 = counter[25];
				temp_led7 = counter[25];
			end
		3:
			begin
				temp_led0 = counter[24];
				temp_led1 = counter[24];
				temp_led2 = 1;
				temp_led3 = counter[24];
				temp_led4 = counter[24];
				temp_led5 = counter[24];
				temp_led6 = counter[24];
				temp_led7 = counter[24];
			end
		4:
			begin
				temp_led0 = counter[23];
				temp_led1 = counter[23];
				temp_led2 = counter[23];
				temp_led3 = 1;
				temp_led4 = counter[23];
				temp_led5 = counter[23];
				temp_led6 = counter[23];
				temp_led7 = counter[23];
			end
		5:
			begin
				temp_led0 = counter[22];
				temp_led1 = counter[22];
				temp_led2 = counter[22];
				temp_led3 = counter[22];
				temp_led4 = 1;
				temp_led5 = counter[22];
				temp_led6 = counter[22];
				temp_led7 = counter[22];
			end
		6:
			begin
			temp_led0 = counter[21];
			temp_led1 = counter[21];
			temp_led2 = counter[21];
			temp_led3 = counter[21];
			temp_led4 = counter[21];
			temp_led5 = 1;
			temp_led6 = counter[21];
			temp_led7 = counter[21];
			end
		7:
			begin
				temp_led0 = counter[22];
				temp_led1 = counter[22];
				temp_led2 = counter[22];
				temp_led3 = counter[22];
				temp_led4 = counter[22];
				temp_led5 = counter[22];
				temp_led6 = 1;
				temp_led7 = counter[22];
			end
		8:
			begin
				temp_led0 = counter[21];
				temp_led1 = counter[21];
				temp_led2 = counter[21];
				temp_led3 = counter[21];
				temp_led4 = counter[21];
				temp_led5 = counter[21];
				temp_led6 = counter[21];
				temp_led7 = 1;
			end
		default:
			begin
				temp_led0 = 1;
				temp_led1 = 1;
				temp_led2 = 1;
				temp_led3 = 1;
				temp_led4 = 1;
				temp_led5 = 1;
				temp_led6 = 1;
				temp_led7 = 1;
			end
	endcase
end

assign led_0 = temp_led0;
assign led_1 = temp_led1;
assign led_2 = temp_led2;
assign led_3 = temp_led3;
assign led_4 = temp_led4;
assign led_5 = temp_led5;
assign led_6 = temp_led6;
assign led_7 = temp_led7;


endmodule 