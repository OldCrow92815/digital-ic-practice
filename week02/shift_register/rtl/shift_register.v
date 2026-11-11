`timescale 1ns / 1ns

module shift_register(
    input clk,
    input rst_n,
    input load,
    input dir,
    input [7:0]data_in,
    input circular,
    
    output reg [7:0]shift_out
);

    always @(posedge clk or negedge rst_n)
    begin
        
        if(rst_n == 0)
        begin
            shift_out <= 0;
        end

        else if(load == 1)
        begin
            shift_out <= data_in;
        end

        else if(load == 0)
        begin

            if(dir == 1 && circular == 1)
            begin
                shift_out <= {shift_out[6:0],shift_out[7]};
            end

            else if(dir == 0 && circular == 1)
            begin
                shift_out <= {shift_out[0],shift_out[7:1]};
            end

            else if(dir == 1 && circular == 0)
            begin
                shift_out <= {shift_out[6:0],1'b0};
            end

            else if(dir == 0 && circular == 0)
            begin
                shift_out <= {1'b0,shift_out[7:1]};
            end

        end

    end

endmodule
