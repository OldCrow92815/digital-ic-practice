`timescale 1ns / 1ns

module bin2gray_tb();

    reg [3:0] bin;
    wire [3:0] gray;
    integer i;

bin2gray bin2gray_inst0(
    .bin(bin),
    .gray(gray)
);

initial begin

    for(i=0;i<16;i+=1) begin
        bin=i;
        #20;
        $display("time=%0t ns, bin=%b, gray=%b", $time, bin, gray);
    end
    #20;
    
    $stop;
end

endmodule
    
