module CU_TB; 
    parameter cw_bits = 31;
	parameter K_bits = 64;

	reg [31:0] instruction;
	reg [4:0] status; 	// V, C, N, Z
	reg reset, clock;

    wire [cw_bits-1:0] controlWord;
	wire [K_bits-1:0] K;
	
	ControlUnit dut (instruction, status, reset, clock, controlWord, K);


	initial begin
        clock =1'b0;
        reset =1'b0;
        status=5'b0;
        instruction=32'b0;
    end 

    always #5 clock<=~clock;

    always 
    begin 
        #10 
        instruction [31:21] <= instruction [31:21] + 1;
	end
	
endmodule 