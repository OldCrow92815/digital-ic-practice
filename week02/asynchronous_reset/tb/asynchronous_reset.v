`timescale 1ns / 1ns
module asynchronous_reset_tb();
    reg               clk;
    reg               rst_n;
    reg               load;
    reg               up_down;
    reg      [7:0]    preset_val;
    wire     [7:0]    count_async;

    asynchronous_reset u_async_cnt(
        .clk(clk),
        .rst_n(rst_n),
        .load(load),
        .up_down(up_down),
        .preset_val(preset_val),
        .count(count_async)
    );

    initial begin
        clk = 1'b1;
        forever #10 clk = ~clk;
    end

    initial begin
        rst_n      = 1'b0;
        load       = 1'b0;
        up_down    = 1'b0;
        preset_val = 8'd100;
        #40;
        rst_n = 1'b1;

        #30;
        @(posedge clk);
        #5;
        load = 1'b1;
        up_down = 1'b1;
        @(posedge clk);
        #5;
        load = 1'b0;

        up_down = 1'b1;
        #8000;

        @(posedge clk);
        #2;
        rst_n = 1'b0;
        #25;
        rst_n = 1'b1;
        #100;

        @(posedge clk);
        #5;
        preset_val = 8'd150;
        load = 1'b1;
        up_down = 1'b0;
        @(posedge clk);
        #5;
        load = 1'b0;

        up_down = 1'b0;
        #8000;

        @(posedge clk);
        #2;
        rst_n = 1'b0;
        #25;
        rst_n = 1'b1;
        #200;

        $stop;
    end

    initial begin
        $dumpfile("async_cnt_wave.vcd");
        $dumpvars(0, asynchronous_reset_tb);
    end

endmodule
