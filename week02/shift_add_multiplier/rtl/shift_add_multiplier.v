`timescale 1ns / 1ns

module shift_add_multiplier(
    input clk,
    input rst_n,
    input start,
    input [3:0]a,
    input [3:0]b,

    output reg done,
    output reg [7:0]prodect
);

localparam IDLE = 2'd0;
localparam CALC = 2'd1;
localparam DONE = 2'd2;

reg [7:0]a_s;
reg [3:0]b_s;
reg [7:0]prodect_s;

reg [1:0]state;
reg [1:0]next_state;

reg [2:0]cnt;


always @(posedge clk or negedge rst_n)
begin
    if (rst_n == 0)
    begin
        state <= IDLE;
        prodect_s <= 8'd0;
        a_s <= 8'd0;
        b_s <= 4'd0;
        cnt <= 3'd0;
        prodect_s <= 8'd0;
    end
    else
    begin
        state <= next_state;
        case (state)
            IDLE: 
            begin
                cnt <= 3'd0;
                            
            if(start == 1)
            begin
                a_s <= {4'b0,a};
                b_s <= b;
                prodect_s <= 8'b0;
            end

            else
            begin
                ;
            end

            end

            CALC:
            begin
                if(b_s[0] == 1)
                begin
                    prodect_s <= prodect_s + a_s;
                end
                else
                begin
                    prodect_s <= prodect_s;
                end
                a_s <= a_s << 1;
                b_s <= b_s >> 1;
                cnt <= cnt + 1;
            end

            DONE:
            begin
                ;
            end

            default: 
            begin
                ;
            end
        endcase
        
    end
end

always @(*)
begin
    next_state = state;
    case(state)
    IDLE:
    begin
        if (start == 1)
        begin
            next_state = CALC;
        end
        else
        begin
            next_state = IDLE;
        end
    end

    CALC:
    begin
        if (cnt == 4)
        begin
            next_state = DONE;
        end
        else
        begin
            next_state = CALC;
        end
    end

    DONE:
    begin
        if (start == 0)
        begin
            next_state = IDLE;
        end
        else
        begin
            next_state = DONE;
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
    case(state)
    IDLE:
    begin
        done = 0;
        prodect = 8'd0;
    end 

    CALC:
    begin
        done = 0;
        prodect = 8'd0;
    end
    
    DONE:
    begin
        done = 1;
        prodect = prodect_s;
    end

    default: 
    begin
        done = 0;
        prodect = 8'd0;
    end
    endcase

end

endmodule
