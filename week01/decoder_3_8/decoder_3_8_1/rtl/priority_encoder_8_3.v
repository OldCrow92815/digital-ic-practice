`timescale 1ns / 1ns
module decoder_3_8(
    input [2:0] data_in,
    output reg[7:0] data_out,
    input enable

);

always @(*) begin
   case (enable)
        1'b1: begin
            case (data_in)
                3'd7: data_out=8'b10000000;
                3'd6: data_out=8'b01000000;
                3'd5: data_out=8'b00100000;
                3'd4: data_out=8'b00010000;
                3'd3: data_out=8'b00001000;
                3'd2: data_out=8'b00000100;
                3'd1: data_out=8'b00000010;
                3'd0: data_out=8'b00000001;
            default: data_out=8'b00000000;
            endcase
              end
        1'b0: data_out=8'b00000000;    
    default: data_out=8'b00000000;
   endcase

end

endmodule


