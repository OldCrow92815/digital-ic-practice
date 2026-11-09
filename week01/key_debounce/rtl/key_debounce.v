`timescale 1ns / 1ns
module key_debounce (
    input  clk,
    input  rst_n, //复位
    input  key_in,
    output  reg key_out
);     

    reg key_d0;
    reg key_d1;
    wire key_in_pedge;//上升
    wire key_in_nedge;//下降
    //reg key_state;

    reg [1:0]state;
    localparam IDLE=0;
    localparam FILTER0=1;
    localparam DOWN=2;
    localparam FILTER1=3;

    localparam count_max=999999;
    reg [19:0]count; //1000000
    reg count_n;//计数复位
    wire ms_20;
    
    always @(posedge clk)
    key_d0 <= key_in;

    always @(posedge clk)
    key_d1 <= key_d0;

    assign key_in_pedge = (key_d0==1) && (key_d1==0);
    assign key_in_nedge = (key_d0==0) && (key_d1==1);
    
    assign ms_20 = (count >= count_max);

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
        begin
            state <= IDLE;
            count_n <= 0;
            count <= 0;
            key_out <= 0;
            //key_state <= 1;
        end
        else
        begin
            key_out <= 0;
        end
        case (state)
            IDLE: 
                if(key_in_nedge)
                begin
                    state <= FILTER0;
                    count_n <= 1;
                end

                else
                begin
                    state <= IDLE;
                    count_n <= 0;
                end

            FILTER0: 
                if(ms_20)
                begin
                    state <= DOWN;
                    //key_state <= 0;
                end
                else if(key_in_pedge)
                begin
                    state <= IDLE;
                    count_n <= 0;
                    //key_state <= 1;
                end
                else
                    state <= FILTER0;
            
            DOWN: 
                if(key_in_pedge)
                begin
                    state <= FILTER1;
                    count_n <= 1;
                end
                else
                begin
                    state <= DOWN;
                    count_n <= 0;
                end

            FILTER1: 
                if(ms_20)
                begin
                    state <= IDLE;
                    //key_state <= 1;
                    key_out <= 1;
                end
                else if(key_in_nedge)
                begin
                    state <= DOWN;
                    count_n <= 0;
                end
                else
                    state <= FILTER1;

            default: state <= IDLE;
        endcase


    end

    always @(posedge clk or negedge rst_n) begin
        if(count_n==1)
            count <= count+1;
        else 
        begin
            count <= 0;
        end
    end


    
endmodule
