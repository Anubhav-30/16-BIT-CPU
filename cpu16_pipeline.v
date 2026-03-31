module cpu16_pipeline (
    input clk,
    input rst
);

    reg [15:0] pc;
    wire [15:0] instr;

    instr_mem imem (.addr(pc), .instr(instr));

  
    reg [15:0] if_id_instr;

    // Register decode
    wire [2:0] rs1 = if_id_instr[8:6];
    wire [2:0] rs2 = if_id_instr[5:3];
    wire [2:0] rd  = if_id_instr[11:9];
    wire [3:0] opcode = if_id_instr[15:12];

    wire [15:0] reg_a, reg_b;

    reg_file rf (
        .clk(clk),
        .we(1'b0),             
        .rs1(rs1),
        .rs2(rs2),
        .rd(3'b000),
        .wd(16'd0),
        .rd1(reg_a),
        .rd2(reg_b)
    );

    wire reg_write, mem_read, mem_write, alu_src;

    control_unit cu (
        .opcode(opcode),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .alu_src(alu_src)
    );

    wire [15:0] alu_in2 = alu_src ? {{8{if_id_instr[7]}}, if_id_instr[7:0]} : reg_b;
    wire [15:0] alu_out;

    alu alu_inst (
        .a(reg_a),
        .b(alu_in2),
        .op(opcode),
        .result(alu_out)
    );

    reg [15:0] ex_mem_alu_out;
    reg [15:0] mem_wb_data;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pc <= 0;
            if_id_instr <= 0;
            ex_mem_alu_out <= 0;
            mem_wb_data <= 0;
        end else begin
            pc <= pc + 1;

          
            if_id_instr <= instr;
            ex_mem_alu_out <= alu_out;
            mem_wb_data <= ex_mem_alu_out;
        end
    end

endmodule