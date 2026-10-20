`timescale 1ns / 1ns

module priority_encoder_8_3(
    input [7:0] data_in,
    output reg[2:0] data_out,
    output reg valid

);

always @(*) begin
    if(data_in[7]==1) begin
        data_out=3'd7;
    end
    
    else if(data_in[6]==1) begin
        data_out=3'd6;
    end

    else if(data_in[5]==1) begin
        data_out=3'd5;
    end

    else if(data_in[4]==1) begin
        data_out=3'd4;
    end

    else if(data_in[3]==1) begin
        data_out=3'd3;
    end

    else if(data_in[2]==1) begin
        data_out=3'd2;
    end

    else if(data_in[1]==1) begin
        data_out=3'd1;
    end

    else if(data_in[0]==1) begin
        data_out=3'd0;
    end

    else begin
        data_out=3'd0;
    end


    if(data_in != 0) begin
        valid=1'd1;
    end

    else begin
        valid=1'd0;
    end


end

endmodule
