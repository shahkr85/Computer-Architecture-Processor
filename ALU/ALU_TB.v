module ALU_TB();			//Note: All inputs are reg and all outputs are wire in testbench
	reg [63:0] A, B;
	reg [4:0] FS;
	reg Cin;
	
	wire [63:0] F;
	//p2
	wire [3:0] stat;
	wire [64:0] Cout;
	

	initial begin
		A <= 64'b1101;
		B <= 64'b0110;
		Cin <= 1'b0;
		FS <= 5'b00000;
	end
	
	ALU dut (.inA(A), .inB(B), .FS(FS), .Cin(Cin), .F(F), .stat(stat), .Cout(Cout));
	
	always @(FS) begin
		#20
		FS <= 5'b00000;	// A & B		0-40 	
		#20
		FS <= 5'b00100;	//A | B		40-60		
		#20
		FS <= 5'b01000;	//A + B		60-80
		#20 
		FS <= 5'b01100;	//A ^ B		80-100
		#20
		FS <= 5'b10000;	//A >> 1		100-120
		#20
		FS <= 5'b10100;	//A << 1		120-140
		#20
		FS <= 5'b11000;	//All 0		140-160
		#20
		FS <= 5'b11100;	//All 1		160-180
		#20
		FS <= 5'b01001;	//A - B		180-200
		#20
		B <= 1'b0;
		FS <= 5'b01000;	//A			200-220
		#20
		FS <= 5'b01010;	//~A			220-240
		#20
		B <= 1'b1;
		Cin <= 1'b1;
		FS <= 5'b01000;	//A+B+Cin	260
		//#20
	/*				280
		#20
			300 */
	end 
	
	initial
		#285 $finish;

endmodule 