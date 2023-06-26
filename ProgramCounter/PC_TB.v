module PC_TB; 
	reg clock;
    reg reset; 
	reg [63:0] pc_in;
    reg [1:0] ps;
	wire [63:0] pc_out;
    wire [63:0] PC4;
	
	ProgramCounter DUT (clock, reset, pc_in, ps, pc_out, PC4);

	initial begin
        clock =1'b0;
        reset =1'b1;
        pc_in <= {$random,$random};
        ps = 2'b00;
    end 

    always #5 clock<=~clock;

    always 
    begin 
        #10 ps = 2'b01;
        #10 ps = 2'b10;
        #10 ps = 2'b11;
        #10 reset = 1'b0;
        #10;
	end
	
endmodule 