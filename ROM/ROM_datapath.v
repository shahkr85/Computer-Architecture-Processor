module ROM_datapath (reset, clock, instruction, controlWord, ALU_out,RAM_out,status,PC_out,k)
    input reset;
    input clock;
    output [31:0] instruction;
    output [31:0] controlWord;
    output [63:0] ALU_out;
    output [63:0] RAM_out;
    output [3:0] status;
    output [63:0] PC_out;
    output [63:0] k;

assign {PS, DA, SA, SB, FS, regW, ramW, EN_MEM, EN_ALU, EN_B, EN_PC, selB, PCsel, SL} = controlWord; 

    reg32x64 dut1 (clock, regW, reset, DA, wrData, SA, SB, rdDataA, rdDataB); 

    input [63:0] inB;
    assign inB =EN_B  ? rdDataB : 64'bz;
    ALU dut2 (inA, inB, FS, Cin, F, stat, Cout);

	input [63:0] pc_in;
    if(EN_PC=1'b0)
        PS=2'b00;
    ProgramCounter dut5 (clock, reset, pc_in, PS, PC_out, PC4);

    output reg [15:0] address;
    ROM dut3 (instruction, address);
	
    output reg [7:0] address1;
    assign address1 = EN_MEM ? F[31:0]: 32'bz;
	assign Data = ALU_out ? F: 64'bz; 
    RAM256x64 dut4 (address1, clock, ALU_out, ramW, RAM_out);

endmodule

