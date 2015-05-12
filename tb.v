module test;

reg clk;
reg restart;
reg[3:0] level;
reg hit_1, hit_2, hit_3, hit_4;
reg switch;
reg advance;
wire a, b, c, d, e, f, g;
wire [3:0] anode_en;
wire [7:0] random;
wire Led0, Led1, Led2, Led3, Led4, Led5, Led6, Led7;

/*wire A, B, C, D, E, F, G;
wire [3:0] anode_EN;*/

/*lfsr_15bit uut( .clk(clk), .restart(restart), .rand(random) );
lfsr_15bit uut2( .clk(clk), .restart(restart), .rand(random2) );*/

//lfsr_8bit uut (.clk(clk), .restart(restart), .rand(random));

/*mole_generator moleuut(.clk(clk), .restart(restart), .level(level), .a_mole(a), .b_mole(b), .c_mole(c),
					        .d_mole(d), .e_mole(e), .f_mole(f), .g_mole(g), .anode_en_mole(anode_en) );
							  


sevenseg my_seg(.clk(clk), .reset(restart), .mole_location(anode_en), .a1(a), .b1(b), .c1(c), .d1(d), .e1(e), .f1(f),
						.g1(g), .advance(advance), .A(A), .B(B), .C(C), .D(D), .E(E), .F(F), .G(G), .anode_EN(anode_EN));*/
						
mastergame master (.clk(clk), .RESTART(restart), .hit_4(hit_4), .hit_3(hit_3), .hit_2(hit_2), .hit_1(hit_1), .SWITCH(switch),
							.level(level),
							.a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g), 
							.Led0(Led0), .Led1(Led1), .Led2(Led2), .Led3(Led3), .Led4(Led4), .Led5(Led5), .Led6(Led6), .Led7(Led7),
							.anode_en(anode_en));

initial
	begin
	clk = 0;
	forever
		#100 clk = ~clk;
	end
	
	initial begin
	#1
	restart = 1;
	advance = 0;
	switch = 0;
	hit_4 = 0;
	hit_1 = 0;
	hit_2 = 0;
	hit_3 = 0;
	#1
	restart = 0;
	#1
	level = 1;
	#100000000
	hit_3 = 1;
	#1
	hit_3 = 0;
	#100000000
	hit_2 = 1;
	#10;
	hit_2 = 0;
	#100000000
	switch = 1;
	#100000000
	switch = 0;
	#100000000
	hit_4 = 1;
	#10
	hit_4 = 0;
	#100000000
	hit_3 = 1;
	#10
	hit_3 = 0;
	#10000000
	hit_2 = 1;
	#10
	hit_2 = 0;
	#10000000
	hit_2 = 1;
	#10
	hit_2 = 0;
	#10000000
	hit_1 = 1;
	#10
	hit_1 = 0;
	#100000000
	switch = 1;
	#200000000
	switch = 0;
	#10000000
	hit_1 = 1;
	#10
	hit_1 = 0;
	#10000000
	hit_1 = 1;
	#10
	hit_1 = 0;
	#10000000
	hit_1 = 1;
	#10
	hit_1 = 0;
	
	
	end
		



endmodule