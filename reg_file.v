module reg_file (
    input clk,
    input we,
    input [2:0] rs1, rs2, rd,
    input [15:0] wd,
    output reg [15:0] rd1, rd2
);

    reg [15:0] regs [0:7];

    initial begin
        regs[0] = 16'd0;
        regs[1] = 16'd5;
        regs[2] = 16'd3;
        regs[3] = 16'd7;
        regs[4] = 16'd2;
        regs[5] = 16'd9;
        regs[6] = 16'd4;
        regs[7] = 16'd1;
    end

    always @(*) begin
        rd1 = regs[rs1];
        rd2 = regs[rs2];
    end

    always @(posedge clk) begin
        if (we)
            regs[rd] <= wd;
    end

endmodule