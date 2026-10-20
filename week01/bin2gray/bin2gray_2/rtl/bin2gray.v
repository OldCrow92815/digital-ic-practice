`timescale 1ns / 1ns
module bin2gray(
    input [3:0] bin,
    output reg [3:0] gray
);
    reg[1:0] i;
always @(*) begin
    gray[3]=bin[3];
    for(i=0;i<3;i++)
    begin
        gray[i]=bin[i]^bin[i+1];
    end

end
endmodule


