module RAM256x64(address, clock, in, ramWrite, out);
    input [7:0] address;
    input clock;
    input [63:0] in;
    input ramWrite;
    output reg [63:0] out;
    
    reg [63:0] mem [0:255];
    
    always @(posedge clock) begin
        if(ramWrite) begin
            mem[address] <= in;
        end
    end
    
    always @(negedge clock) begin
        out <= mem[address];
    end
    
endmodule
