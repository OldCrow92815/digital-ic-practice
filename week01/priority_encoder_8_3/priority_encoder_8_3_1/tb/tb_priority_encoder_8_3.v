`timescale 1ns / 1ns

module priority_encoder_8_3_tb();

    reg [7:0] data_in;
    wire [2:0] data_out;
    wire valid;
    integer i;
    
priority_encoder_8_3 priority_encoder_8_3_inst0(
    .data_in(data_in),
    .data_out(data_out),
    .valid(valid)
);


initial begin

    for(i=0;i<256;i+=1) begin
        data_in=i;
        #20;
        $display("time=%0t ns, data_in=%b, data_out=%d, valid=%d", $time, data_in, data_out, valid);
    end

    #20;

    $stop;
end

endmodule
    
