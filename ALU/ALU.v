module ALU (inA, inB, FS, Cin, F, stat, Cout);
	input [63:0] inA, inB;	//input before potential invert
	reg [63:0] A, B;			//after potential invert
	input [4:0] FS;
	input Cin;
	output reg [63:0] F;
	
	//p2//
	output reg[3:0] stat;	// {V, C, N, Z}
	output Cout; 
	wire [64:0] temp;
//	assign temp = {1'b0, A} + {1'b0, B};
//	assign Cout = temp[64];
	//Carry-Propogate, Carry-Generate? 
	
	always @(*) begin	//Function Select
		case (FS[0])		//B inverter
			1'b1: B = ~inB + 1'b1;
			default: B = inB;
		endcase
		
		case (FS[1])		//A inverter
			1'b1: A = ~inA + 1'b1;
			default: A = inA;
		endcase
	end
	
//		assign temp = {1'b0, A} + {1'b0, B};
//		assign Cout = temp[64];
		
	always @(*) begin	
		case (FS[4:2])	
			3'b000: F = A & B; 		//and
			3'b001: F = A | B;		//or
			3'b010:	begin				//add
				if(Cin) begin
					F = A + B + Cin;
				end
				else begin
					F = A + B;
				end
			end	
			3'b011: F = A ^ B; 		//xor
			3'b100: F = A >> 1; 		//shift left
			3'b101: F = A << 1; 		//shift right
			3'b110:  					//output 0
				F = 64'b0000000000000000;
				
			3'b111: 						//output 0 or 16’b1111111111111111
				F = 16'b1111111111111111;
			default: F = 16'b0000000000000000;
		endcase
	end
	
	//p2
	
	assign temp = {1'b0, A} + {1'b0, B};
	assign Cout = temp[64];
	
	always @(*) begin	//Output Status	{V, C, N, Z}
		if(F == 0) 
			stat[0] <= 1'b1;
		else
			stat[0] <= 1'b0;
		if (F < 0)
			stat[1] <= 1'b1;
		else
			stat[1] <= 1'b0;
		if(Cout!=0) 
			stat[2] <= 1'b1;
		else
			stat[2] <= 1'b0;
		if(Cout && F >= 0) 
			stat[3] <= 1'b1;
		else
			stat[3] <= 1'b0;
	end
	
	/*case (F)
			F == 0: stat[0] <= 1'b1;	// Z
		//	F <  0: stat[1] <= 1'b1;	// N
			Cout!= 0: stat[2] <= 1'b1;	// C
			//F 		stat[3] <= 1'b1;	// V
			default: stat <= 4'b0;		//
		endcase*/
	
endmodule 