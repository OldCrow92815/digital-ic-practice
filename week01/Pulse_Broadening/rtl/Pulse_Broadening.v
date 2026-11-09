`timescale 1ns / 1ns

module Pulse_Broadening(
    input clk,
    input rst_n,
    input pulse_in,
   
    output reg pulse_out
);

    reg [3:0]count;
    reg count_n;
    reg count_f;
    localparam N=10;

    reg pulse_d0;

    always @(posedge clk or negedge rst_n)
    begin
        pulse_d0 <= pulse_in;
    end

    always @(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
        begin
            count_f <= 0;
            count <= 0;
            count_n <= 0;
            pulse_out <= 0;
        end

        if(pulse_in && !pulse_d0 && !count_f)
        begin
            count_f <= 1;
            pulse_out <= 1;
            count_n <= 1;                        
        end
        else
        begin
            count_n <= count_n;
        end

        if(count_n)
        begin
            count <= count+1;
        end
        else
        begin
            count <= 0;
        end

        if(count >= N-1)
        begin
            count_f <= 0;
            count_n <= 0;
            pulse_out <= 0;
            count <= 0;
        end
        else
        begin
            ;
        end
    end   

endmodule
    
