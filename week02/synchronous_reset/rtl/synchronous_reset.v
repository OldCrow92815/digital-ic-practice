`timescale 1ns / 1ns

module synchronous_reset(

    input clk,
    input rst_n,
    input load,
    input up_down,

    input [7:0]preset_val,
    output reg [7:0]count

);

    always @(posedge clk)
    begin
    if(rst_n==0)
        begin
            count <= 0;
        end
    else if(load == 1)
        begin
            count <= preset_val;            
        end
    else
    begin
        if(up_down == 1)
            begin
                count <= count+1;
                if(count >= 255)
                    begin
                    count <= 0;
                    end
            end
    else
        begin
            count <=count-1;
            if(count <= 0)
                begin
                    count <= 255;
                end
        end
    end
    end

endmodule
