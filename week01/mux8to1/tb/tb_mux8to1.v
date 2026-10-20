`timescale 1ns / 1ns

module mux_8_1_tb();

    reg [7:0] data_in;
    reg [2:0] sel;
    wire data_out;

mux_8_1 mux_8_1_inst0(
    .data_in(data_in),
    .sel(sel),
    .data_out(data_out)
);

initial begin
    data_in=8'b10101010; sel=3'b000;
    #20;
    $display("time=%0t ns, sel=%b, data_in=%b, data_out=%b", $time, sel, data_in, data_out);
    data_in=8'b10101010; sel=3'b001;
    #20;
    $display("time=%0t ns, sel=%b, data_in=%b, data_out=%b", $time, sel, data_in, data_out);
    data_in=8'b10101010; sel=3'b010;
    #20;
    $display("time=%0t ns, sel=%b, data_in=%b, data_out=%b", $time, sel, data_in, data_out);
    data_in=8'b10101010; sel=3'b011;
    #20;
    $display("time=%0t ns, sel=%b, data_in=%b, data_out=%b", $time, sel, data_in, data_out);
    data_in=8'b10101010; sel=3'b100;
    #20;
    $display("time=%0t ns, sel=%b, data_in=%b, data_out=%b", $time, sel, data_in, data_out);
    data_in=8'b10101010; sel=3'b101;
    #20;
    $display("time=%0t ns, sel=%b, data_in=%b, data_out=%b", $time, sel, data_in, data_out);
    data_in=8'b10101010; sel=3'b110;
    #20;
    $display("time=%0t ns, sel=%b, data_in=%b, data_out=%b", $time, sel, data_in, data_out);
    data_in=8'b10101010; sel=3'b111;
    #20;
    $display("time=%0t ns, sel=%b, data_in=%b, data_out=%b", $time, sel, data_in, data_out);
    #20;

    $stop;
end

endmodule
    
