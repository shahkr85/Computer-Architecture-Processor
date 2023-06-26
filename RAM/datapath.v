module datapath(input clk, reset, Cin, RegWrite, RAMWrite, MUXSelect, InSelect, ALUstart,
					input[63:0] data, 
					input[4:0] FS, wrAddr, rdAddrA, rdAddrB, 
					output [63:0] RAMout, ALUout, 
					output stat, Cout);
    wire read;
    assign read=~RegWrite;
    wire [63:0] rdDataA, rdDataB; 
    reg [63:0] ALUin, RegIn;
    always @(*)
    begin
        case (InSelect)
            1'b0: RegIn=data;
            1'b1: RegIn=ALUout;
        endcase
    end
    always @(*)
    begin
        case (MUXSelect)
            1'b1: ALUin=wrAddr;
            1'b0: ALUin=rdDataA;
        endcase
    end
    wire [7:0] address;
    assign address=ALUout[63:56];

    reg32x64Bit T1 (.clk(clk), .regWrite(RegWrite), .reset(reset), .wrAddr(wrAddr), .rdAddrA(rdAddrA), .rdAddrB(rdAddrB), .RegIn(RegIn), .rdDataA(rdDataA), .rdDataB(rdDataB));
    ALU T2 (ALUin, Cin, ALUstart, FS, Cout, stat, ALUout);
    RAM256x64 T3 (.address(address), .clock(clk), .ramWrite(RAMwrite), .out(RAMout));
endmodule
