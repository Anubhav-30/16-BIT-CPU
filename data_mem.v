module data_mem (
    input clk,
    input mem_read,
    input mem_write,
    input [15:0] addr,
    input [15:0] wd,
    output reg [15:0] rd
);

    reg [15:0] mem [0:255];
    integer i;

    initial begin
        for (i = 0; i < 256; i = i + 1)
            mem[i] = 0;
    end

    always @(posedge clk) begin
        if (mem_write)
            mem[addr] <= wd;
    end

    always @(*) begin
        if (mem_read)
            rd = mem[addr];
        else
            rd = 0;
    end

endmodule