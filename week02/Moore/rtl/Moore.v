`timescale 1ns / 1ns

module Moore(
    input clk,
    input rst_n,
    input data_in,

    output reg detected
);

    localparam IDLE = 3'd0;
    localparam S1 = 3'd1;
    localparam S10 = 3'd2;
    localparam S101 = 3'd3;
    localparam S1011 = 3'd4;

    reg [2:0]state;
    reg [2:0]next_state;

    always @(posedge clk or negedge rst_n)
    begin
        if (!rst_n) 
        begin
            state <= IDLE;
        end
        
        else 
        begin
            state <= next_state;
        end
        
    end

    always @(*)
    begin
        next_state = state;
        case (state)
            IDLE: 
            begin
                if(data_in == 1)
                begin
                    next_state = S1;
                end
                
                else
                begin
                    next_state = IDLE;
                end
            end

            S1:
            begin
                if(data_in == 0)
                begin
                    next_state = S10;
                end

                else
                begin
                    next_state = S1;
                end
            end

            S10:
            begin
                if(data_in == 1)
                begin
                    next_state = S101;
                end

                else
                begin
                    next_state = IDLE;
                end
            end

            S101:
            begin
                if(data_in == 1)
                begin
                    next_state = S1011;
                end

                else
                begin
                    next_state = S10;
                end
            end
            
            S1011:
            begin
                if(data_in == 1'b1)
                begin
                    next_state = S1;
                end

                else
                begin
                    next_state = IDLE;
                end
            end

            default:
            begin
                next_state = IDLE;
            end

        endcase
    end

    always @(*)
    begin
        if(state == S1011)
        begin
            detected = 1;
        end
        else
        begin
            detected = 0;
        end
    end

endmodule
