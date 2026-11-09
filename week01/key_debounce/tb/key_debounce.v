`timescale 1ns / 1ns
module key_debounce_tb();
    reg clk;
    reg rst_n;
    reg key_in;
    wire key_out;

key_debounce key_debounce_inst0(
    .clk(clk),
    .rst_n(rst_n),
    .key_in(key_in),
    .key_out(key_out)
);

initial begin
    clk = 1'b1;
    forever #10 clk = ~clk;
end

initial begin
    rst_n = 1'b0;
    key_in = 1'b1;
    #40;
    rst_n = 1'b1;

    #10000000;
    repeat(30) begin
        #5 key_in = {$random} % 2;
    end
    #1000;
    key_in = 1'b0;
    #22000000;
    repeat(30) begin
        #5 key_in = {$random} % 2;
    end
    #1000;
    key_in = 1'b1;
    #22000000;

    repeat(30) begin
        #5 key_in = {$random} % 2;
    end
    #1000;
    key_in = 1'b0;
    #22000000;
    repeat(30) begin
        #5 key_in = {$random} % 2;
    end
    #1000;
    key_in = 1'b1;
    #22000000;

    #200;
    $stop;
end

endmodule
