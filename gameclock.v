module game_clock(input clk, input reset, output clk1);

reg [23:0] counter;
reg temp_clock;

always @ (posedge clk or posedge reset)
begin
	if(reset)
	begin
		counter <= 0;
		temp_clock <= 0;
	end
	else
	begin
		if(counter == 10000)
		begin
			temp_clock <= ~temp_clock;
			counter <= 0;
		end
		else
			counter <= counter + 1;
	end
end

assign clk1 = temp_clock;
endmodule 