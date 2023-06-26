module RAM_TB();
	reg [7:0] address;
	reg clock;
	reg [63:0] in;
	reg ramWrite;
	wire [63:0] out;

	RAM256x64 dut (address,clock,in,ramWrite,out);

	initial begin 
		clock =0;
		ramWrite = 1'b0;
		address=1'b0;
		in=64'b0;
	end

	always #5 clock = ~clock;

	always begin
		 ramWrite =1'b1;
		 #10 in <= {$random, $random}; //$random generates 32 random number
		 address <= address + 8'b1;
	end

endmodule 