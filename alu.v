module alu (
    input [15:0] a,
    input [15:0] b,
    input [3:0] op,
    output reg [15:0] result
);

    always @(*) begin
        case (op)
            4'b0001: result = a + b;
            4'b0010: result = a - b;
            4'b0011: result = a & b;
            4'b0100: result = a | b;
            default: result = 16'd0;
        endcase
    end

endmodule 