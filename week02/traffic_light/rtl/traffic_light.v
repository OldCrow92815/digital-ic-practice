`timescale 1ns / 1ns

module traffic_light(
    input clk,
    input rst_n,
    input timer_en,
    
    output reg[2:0]light_ns,
    output reg[2:0]light_ew
);

    localparam S0 = 1'd0;
    localparam S1 = 1'd1;

    reg state;
    reg next_state;

    parameter green = 30;
    parameter yellow = 5;
    parameter red = 35;

    reg [25:0]count;
    parameter count_1s = 50000000;
    reg [5:0]count_s;

    always @(posedge clk or negedge rst_n)
    begin
        if (!rst_n) 
        begin
            state <= S0;
            count <= 0;
            count_s <= 0;
        end
        
        else if(timer_en == 0)
        begin
            state <= S0;
            count <= 0;
            count_s <= 0;
        end

        else if (timer_en == 1) 
        begin
            state <= next_state;
            if(count == count_1s-1)
            begin
                count <= 0;
            end

            else
            begin
                count <= count+1;                
            end

            if(count == count_1s-1)
            begin                
                if(count_s == red-1)
                begin
                    count_s <= 0;
                end

                else
                begin
                    count_s <= count_s+1;    
                end
            end

            else 
            begin
                count_s <= count_s;
            end
        end
        
    end

    always @(*)
    begin
        next_state = state;
        case (state)
            S0: 
            begin
                if(count_s== red-1)
                begin
                    next_state = S1;
                end
                else
                begin
                    next_state = S0;
                end
            end

            S1: 
            begin
                if(count_s== red-1)
                begin
                    next_state = S0;
                end
                else
                begin
                    next_state = S1;
                end
            end

            default: 
            begin
                next_state = S0;
            end
        endcase
    end

    always @(*)
    begin
        if(state == S0)
        begin
            if(count_s<green)
            begin
                light_ns = 3'b100;
                light_ew = 3'b001;
            end

            else
            begin
                light_ns = 3'b010;
                light_ew = 3'b001;
            end            
        end
        else
        begin
            if(count_s<green)
            begin
                light_ns = 3'b001;
                light_ew = 3'b100;
            end

            else
            begin
                light_ns = 3'b001;
                light_ew = 3'b010;
            end     
        end
    end

endmodule
