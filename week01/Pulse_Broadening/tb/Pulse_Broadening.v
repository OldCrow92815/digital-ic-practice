`timescale 1ns / 1ns
module Pulse_Broadening_tb();
    reg clk;
    reg rst_n;
    reg pulse_in;
    wire pulse_out;

Pulse_Broadening Pulse_Broadening_inst0(
    .clk(clk),
    .rst_n(rst_n),
    .pulse_in(pulse_in),
    .pulse_out(pulse_out)
);

initial begin    
    clk = 1'b1;    
    forever #10 clk = ~clk;
end

initial begin    
    rst_n = 1'b0;
    pulse_in = 1'b0;
    #40;    
    rst_n = 1'b1; 

    #70;          
    @(posedge clk);
    #5;              
    pulse_in = 1'b1;
    @(posedge clk);
    #5;
    pulse_in = 1'b0;

    #1000;
    @(posedge clk);
    #5;
    pulse_in = 1'b1;
    @(posedge clk);
    #5;
    pulse_in = 1'b0;

    #1000;
    $stop;    
end

endmodule
