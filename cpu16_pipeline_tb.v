module cpu16_pipeline_tb;

    reg clk;
    reg rst;

    cpu16_pipeline uut (
        .clk(clk),
        .rst(rst)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("cpu16_pipeline.vcd");
        $dumpvars(0, cpu16_pipeline_tb);

        clk = 0;
        rst = 1;

        #10 rst = 0;

        #300 $finish;
    end

endmodule