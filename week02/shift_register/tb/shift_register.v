`timescale 1ns / 1ns

module shift_register_tb();

    reg clk;
    reg rst_n;
    reg load;
    reg dir;
    reg circular;
    reg [7:0] data_in;
    wire [7:0] shift_out;

shift_register shift_register_inst0(
    .clk(clk),
    .rst_n(rst_n),
    .load(load),
    .dir(dir),
    .circular(circular),
    .data_in(data_in),
    .shift_out(shift_out)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    rst_n = 0;
    load = 0;
    dir = 0;
    circular = 0;
    data_in = 8'd0;
    #10;
    rst_n = 1;
    #10;

    load = 1;
    data_in = 8'b1010_0101;
    @(posedge clk);
    #1;
    $display("time=%0t ns, 加载初值, shift_out = %b", $time, shift_out);
    @(posedge clk);
    load = 0;

    $display("---------- 左移补零模式 ----------");
    dir = 1;
    circular = 0;
    repeat(8) begin
        @(posedge clk);
        $display("time=%0t ns, 左移补零, shift_out = %b", $time, shift_out);
    end

    load = 1;
    data_in = 8'b1010_0101;
    @(posedge clk);
    #1;
    $display("time=%0t ns, 重新加载初值, shift_out = %b", $time, shift_out);
    @(posedge clk);
    load = 0;

    $display("---------- 右移补零模式 ----------");
    dir = 0;
    circular = 0;
    repeat(8) begin
        @(posedge clk);
        $display("time=%0t ns, 右移补零, shift_out = %b", $time, shift_out);
    end

    load = 1;
    data_in = 8'b1010_0101;
    @(posedge clk);
    #1;
    $display("time=%0t ns, 重新加载初值, shift_out = %b", $time, shift_out);
    @(posedge clk);
    load = 0;

    $display("---------- 左移循环模式 ----------");
    dir = 1;
    circular = 1;
    repeat(8) begin
        @(posedge clk);
        $display("time=%0t ns, 左移循环, shift_out = %b", $time, shift_out);
    end

    load = 1;
    data_in = 8'b1010_0101;
    @(posedge clk);
    #1;
    $display("time=%0t ns, 重新加载初值, shift_out = %b", $time, shift_out);
    @(posedge clk);
    load = 0;

    $display("---------- 右移循环模式 ----------");
    dir = 0;
    circular = 1;
    repeat(8) begin
        @(posedge clk);
        $display("time=%0t ns, 右移循环, shift_out = %b", $time, shift_out);
    end

    #20;
    $stop;
end

endmodule
