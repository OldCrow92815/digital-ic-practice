`timescale 1ns / 1ns
module Mealy_tb();
reg clk;
reg rst_n;
reg data_in;
wire detected;
wire [2:0] state;
reg data_sample;

initial begin
    $fsdbDumpfile("testcase.fsdb");
    $fsdbDumpvars(0, Mealy_tb);
end

Mealy u_Mealy(
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data_in),
    .detected(detected)
);
assign state = u_Mealy.state;

initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end

initial begin
    rst_n = 1'b0;
    data_in = 1'b0;
    data_sample = 1'b0;
    #10;
    rst_n = 1'b1;
    #10;

    data_in = 1; #10;
    data_in = 0; #10;
    data_in = 1; #10;
    data_in = 1; #10;
    data_in = 0; #10;
    data_in = 1; #10;
    data_in = 1; #10;
    data_in = 1; #10;
    data_in = 0; #10;
    data_in = 1; #10;
    data_in = 1; #10;

    #20;
    $stop;
end

always @(posedge clk) begin
    data_sample <= data_in;
    case(state)
        3'd0: $display("time=%0t ns, data_in=%b, state=IDLE, detected=%b", $time, data_sample, detected);
        3'd1: $display("time=%0t ns, data_in=%b, state=S1,    detected=%b", $time, data_sample, detected);
        3'd2: $display("time=%0t ns, data_in=%b, state=S10,   detected=%b", $time, data_sample, detected);
        3'd3: $display("time=%0t ns, data_in=%b, state=S101,  detected=%b", $time, data_sample, detected);
        default: $display("time=%0t ns, data_in=%b, state=ERROR, detected=%b", $time, data_sample, detected);
    endcase
end

endmodule
