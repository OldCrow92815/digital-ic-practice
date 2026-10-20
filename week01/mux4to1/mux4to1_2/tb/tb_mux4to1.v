`timescale 1ns / 1ns

module mux_4_1_tb();

    reg [3:0] data_in;
    reg [1:0] sel;
    wire data_out;

mux_4_1 mux_4_1_inst0(
    .data_in(data_in),
    .sel(sel),
    .data_out(data_out)
);

initial begin
    data_in=4'b1010; sel=2'b00;
    #20;
    $display("time=%0t ns, sel=%b, data_in=%b, data_out=%b", $time, sel, data_in, data_out);
    data_in=4'b1010; sel=2'b01;
    #20;
    $display("time=%0t ns, sel=%b, data_in=%b, data_out=%b", $time, sel, data_in, data_out);
    data_in=4'b1010; sel=2'b10;
    #20;
    $display("time=%0t ns, sel=%b, data_in=%b, data_out=%b", $time, sel, data_in, data_out);
    data_in=4'b1010; sel=2'b11;
    #20;
    $display("time=%0t ns, sel=%b, data_in=%b, data_out=%b", $time, sel, data_in, data_out);

    data_in=4'b0101; sel=2'b00;
    #20;
    $display("time=%0t ns, sel=%b, data_in=%b, data_out=%b", $time, sel, data_in, data_out);
    data_in=4'b0101; sel=2'b01;
    #20;
    $display("time=%0t ns, sel=%b, data_in=%b, data_out=%b", $time, sel, data_in, data_out);
    data_in=4'b0101; sel=2'b10;
    #20;
    $display("time=%0t ns, sel=%b, data_in=%b, data_out=%b", $time, sel, data_in, data_out);
    data_in=4'b0101; sel=2'b11;
    #20;
    $display("time=%0t ns, sel=%b, data_in=%b, data_out=%b", $time, sel, data_in, data_out);
    #20;
    $stop;
end

endmodule
    