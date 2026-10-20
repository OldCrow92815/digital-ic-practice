`timescale 1ns / 1ns
module mux_4_1(
    input [3:0] data_in,
    input [1:0] sel,
    output reg data_out

);

always @(*) begin
    if(sel==2'b00) begin
        data_out=data_in[0];
    end

    else if(sel==2'b01) begin
        data_out=data_in[1];
    end

    else if(sel==2'b10) begin
        data_out=data_in[2];
    end

    else if(sel==2'b11) begin
        data_out=data_in[3];
    end
    else begin
        data_out=1'b0;
    end

end

endmodule


