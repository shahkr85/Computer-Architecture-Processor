module Reg_testbench(); // Module to test the 32x64 Register (32x64bitReg.v)
    reg [4:0] rdAddrA, rdAddrB, wrAddr;
    reg [63:0] wrData;
    reg write, reset, clk;
    // create wires
    wire [63:0] rdDataA, rdDataB;

    reg32x64Bit dut (clk,write,reset,wrAddr,wrData, rdAddrA,rdAddrB,rdDataA,rdDataB);

    // give inputs initial values
    initial begin
        clk <= 1'b1;
        reset <= 1'b1;
        wrData <= 64'b0;
        write <= 1'b1;
        wrAddr <= 5'd31;
        rdAddrA <= 5'd30;
        rdAddrB <=5'd30;
        #5 reset <= 1'b0;
        #320 write <=1'b0;
        #320 $stop;
    end        

    //simulate clk w/ 10 tick period    
    always
        #5 clk <= ~clk;
        
    always begin
        #5 wrData <= {$random, $random}; //$random generates 32 random number
        wrAddr <= wrAddr + 5'b1;
        rdAddrA <= rdAddrA + 5'b1;
        rdAddrB <= rdAddrB + 5'b1;
        #5;
    end

    wire [63:0] R00, R01, R02, R03, R04, R05, R06, R07;
    wire [63:0] R08, R09, R10, R11, R12, R13, R14, R15;
    wire [63:0] R16, R17, R18, R19, R20, R21, R22, R23;
    wire [63:0] R24, R25, R26, R27, R28, R29, R30, R31;

    assign R00 = dut.reg0;
    assign R01 = dut.reg1;
    assign R02 = dut.reg2;
    assign R03 = dut.reg3;
    assign R04 = dut.reg4;
    assign R05 = dut.reg5;
    assign R06 = dut.reg6;
    assign R07 = dut.reg7;
    assign R08 = dut.reg8;
    assign R09 = dut.reg9;
    assign R10 = dut.reg10;
    assign R11 = dut.reg11;
    assign R12 = dut.reg12;
    assign R13 = dut.reg13;
    assign R14 = dut.reg14;
    assign R15 = dut.reg15;
    assign R16 = dut.reg16;
    assign R17 = dut.reg17;
    assign R18 = dut.reg18;
    assign R19 = dut.reg19;
    assign R20 = dut.reg20;
    assign R21 = dut.reg21;
    assign R22 = dut.reg22;
    assign R23 = dut.reg23;
    assign R24 = dut.reg24;
    assign R25 = dut.reg25;
    assign R26 = dut.reg26;
    assign R27 = dut.reg27;
    assign R28 = dut.reg28;
    assign R29 = dut.reg29;
    assign R30 = dut.reg30;
    assign R31 = dut.reg31;

endmodule 