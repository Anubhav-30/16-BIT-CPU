module instr_mem (
    input [15:0] addr,
    output reg [15:0] instr
);

    always @(*) begin
        case (addr)
            0: instr = 16'b0001_011_001_010_000;
            1: instr = 16'b0010_100_001_010_000;
            2: instr = 16'b0011_101_001_010_000;
            3: instr = 16'b0100_110_001_010_000;
            default: instr = 16'hDEAD; 
        endcase
    end

endmodule