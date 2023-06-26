module ProgramCounter (clock, reset, pc_in, ps, pc_out, PC4);
	input clock;
	input reset;
	input [63:0] pc_in;
	input [1:0] ps;

	output reg [63:0] pc_out = 0;
	output reg [63:0] PC4;
	
	always @(posedge clock) 
        begin
        if (reset==1)
            pc_out<=64'b0;
        else
			case (ps) 
				2'b00: pc_out <= pc_out;
				2'b01: pc_out <= pc_out + 64'b1;
				2'b10: pc_out <= pc_in;
				2'b11: pc_out <= pc_out + pc_in;
			endcase

        PC4 <= pc_out;
	end
endmodule 