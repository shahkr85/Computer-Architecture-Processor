module datapath_TB();
    reg clk, reset, Cin, RegWrite, RAMWrite, MUXSelect, InSelect, ALUstart; 
    reg[63:0] data;
    reg[4:0] FS, wrAddr, rdAddrA, rdAddrB;
    wire [63:0] ALUout;
    wire [63:0] RAMout;
    wire stat, Cout;
     
    datapath U1(clk, reset, Cin, RegWrite, RAMWrite, MUXSelect, InSelect, ALUstart, data, FS, wrAddr, rdAddrA, rdAddrB, RAMout, ALUout, stat, Cout);
    
    initial 
    begin
        forever #5 clk=~clk;
    end
	
    initial
    begin
        clk=1'b0;
        reset=1'b0;
        Cin=1'b0;
        RegWrite=1'b0;
        RAMWrite=1'b0;
        MUXSelect=1'b0;
        InSelect=1'b0;
        ALUstart=1'b0;
        data=64'b0;
        FS=5'b0;
        wrAddr=5'b0;
        rdAddrA=5'b0;
        rdAddrB=5'b0;
		data=63'b0;
	end 

	always 
	begin
        #5 wrAddr=5'b00000;
            data={$random,$random};
            RegWrite=1'b1;

        #5  wrAddr=5'b00001;
        	data={$random,$random};
        #5 rdAddrA=5'b00000;
            RegWrite=1'b0;
            ALUstart=1'b1;
            FS=5'b01000;
        #5 rdAddrA=5'b00001;

        #5 rdAddrA=5'b00000;
            rdAddrB=5'b00001;
            FS=5'b01100;
            InSelect=1'b1;
            wrAddr=5'b00011;
        #5    ALUstart=1'b0;
            RegWrite=1'b1;
        #5    RegWrite=1'b0;
            rdAddrA=5'b00011;
            FS=5'b01000;
            RAMWrite=1'b1;
        #5 RAMWrite=1'b0;
            ALUstart=1'b1;
        
        #5 rdAddrA=5'b00000;
            rdAddrB=5'b00001;
            FS=5'b10000;
            InSelect=1'b1;
            wrAddr=5'b00100;
        #5    ALUstart=1'b0;
            RegWrite=1'b1;
        #5    RegWrite=1'b0;
            rdAddrA=5'b00100;
            FS=5'b01000;
            RAMWrite=1'b1;
        #5 RAMWrite=1'b0;
            ALUstart=1'b1;
        
        #5 rdAddrA=5'b00000;
            rdAddrB=5'b00001;
            FS=5'b10100;
            InSelect=1'b1; //RegIn=ALU_Out
            wrAddr=5'b00101;
        #5    ALUstart=1'b0;
            RegWrite=1'b1;
        #5    RegWrite=1'b0;
            rdAddrA=5'b00101;
            FS=5'b01000;
            RAMWrite=1'b1;
        #5 RAMWrite=1'b0;
        
        #10 $stop;
    end

endmodule