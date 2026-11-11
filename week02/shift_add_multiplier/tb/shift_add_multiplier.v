`timescale 1ns / 1ns

module tb_shift_add_multiplier();

    reg clk;
    reg rst_n;
    reg start;
    reg [3:0] a;
    reg [3:0] b;

    wire done;
    wire [7:0] prodect;

    shift_add_multiplier u_dut (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .a(a),
        .b(b),
        .done(done),
        .prodect(prodect)
    );

    initial begin
        clk = 0;
        forever #10 clk = ~clk; 
    end

    task test_mul;
        input [3:0] in_a;
        input [3:0] in_b;
        input [7:0] expected;
        reg [7:0] exp_val;
        begin
            exp_val = in_a * in_b;
            
            @(posedge clk);
            a = in_a;
            b = in_b;
            start = 1;
            
            @(posedge clk); 
            start = 0;

            wait(done == 1);
            #1;
            
            if (prodect == exp_val) begin
                $display("PASS: %2d * %2d = %3d (Expected: %3d)", in_a, in_b, prodect, exp_val);
            end else begin
                $display("FAIL: %2d * %2d = %3d (Expected: %3d)", in_a, in_b, prodect, exp_val);
            end
            
            @(posedge clk);
        end
    endtask

    initial begin
        rst_n = 0;
        start = 0;
        a = 4'd0;
        b = 4'd0;

        #40;
        rst_n = 1;
        #20;

        $display("========================================");
        $display("Start Multiplier Testing...");
        $display("========================================");

        test_mul(4'd3,  4'd5,  8'd15);
        test_mul(4'd7,  4'd8,  8'd56);
        test_mul(4'd15, 4'd15, 8'd225);
        test_mul(4'd0,  4'd9,  8'd0);
        test_mul(4'd1,  4'd1,  8'd1);

        $display("========================================");
        $display("Testbench Finished Successfully.");
        $finish;
    end

endmodule