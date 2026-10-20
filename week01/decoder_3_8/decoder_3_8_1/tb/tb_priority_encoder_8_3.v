`timescale 1ns / 1ns

module decoder_3_8_tb();

    reg [2:0] data_in;
    wire [7:0] data_out;
    reg enable;
    integer i;

decoder_3_8 decoder_3_8_inst0(
    .data_in(data_in),
    .enable(enable),
    .data_out(data_out)
);

initial begin
    enable=1;

    for(i=0;i<8;i+=1) begin
        data_in=i;
        #20;
        $display("time=%0t ns, enable=%b, data_in=%b, data_out=%b", $time, enable, data_in, data_out);
    end

    enable=0;

    for(i=0;i<8;i+=1) begin
        data_in=i;
        #20;
        $display("time=%0t ns, enable=%b, data_in=%b, data_out=%b", $time, enable, data_in, data_out);
    end
    $stop;
end

endmodule
    
