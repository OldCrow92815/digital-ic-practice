`timescale 1ns / 1ns

module tb_traffic_light();

    reg clk;
    reg rst_n;
    reg timer_en;
    
    wire [2:0] light_ns;
    wire [2:0] light_ew;

    traffic_light #(
        .green(5),
        .yellow(2),
        .red(7),
        .count_1s(1)
    ) u_traffic_light (
        .clk(clk),
        .rst_n(rst_n),
        .timer_en(timer_en),
        .light_ns(light_ns),
        .light_ew(light_ew)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst_n = 0;
        timer_en = 0;
        
        #20;
        rst_n = 1;
        #20;
        timer_en = 1;
        
        #300;
        
        $display("========================================");
        $display("Testbench Finished Successfully.");
        $finish;
    end

    initial begin
        $timeformat(-9, 0, " ns", 10);
        $display("Time\t\tlight_ns\tlight_ew");
        $monitor("%0t\t\t%b(%s)\t%b(%s)", $time, 
                 light_ns, 
                 (light_ns == 3'b100) ? "GREEN" : (light_ns == 3'b010) ? "YELLOW" : (light_ns == 3'b001) ? "RED" : "UNKNOWN",
                 light_ew,
                 (light_ew == 3'b100) ? "GREEN" : (light_ew == 3'b010) ? "YELLOW" : (light_ew == 3'b001) ? "RED" : "UNKNOWN"
                 );
    end

    always @(posedge clk) begin
        if (light_ns == 3'b100 && light_ew == 3'b100) begin
            $display("========================================");
            $display("ERROR: Conflict! NS and EW are both GREEN! Time = %0t", $time);
            $display("========================================");
            $finish; 
        end
    end

endmodule