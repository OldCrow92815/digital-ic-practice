`timescale 1ns / 1ns

module priority_encoder_8_3(
    input [7:0] data_in,
    output reg[2:0] data_out,
    output reg valid

);

always @(*) begin
    casez(data_in)
        8'b1???????: begin data_out=3'd7; valid=1; end
        8'b01??????: begin data_out=3'd6; valid=1; end
        8'b001?????: begin data_out=3'd5; valid=1; end
        8'b0001????: begin data_out=3'd4; valid=1; end
        8'b00001???: begin data_out=3'd3; valid=1; end
        8'b000001??: begin data_out=3'd2; valid=1; end
        8'b0000001?: begin data_out=3'd1; valid=1; end
        8'b00000001: begin data_out=3'd0; valid=1; end
        default: begin data_out=3'd0; valid=0; end
    endcase
end

endmodule
