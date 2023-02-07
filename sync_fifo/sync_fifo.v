module sync_fifo
    #(
        parameter WIDTH = 8,
        parameter DEPTH = 16,
        parameter PTR_WIDTH = 4
    )
    (
        input wire clk_i,
        input wire rst_i,

        input wire wr_en_i,
        input wire [WIDTH-1:0] wr_data_i,

        input wire rd_en_i,
        output reg [WIDTH-1:0] rd_data_o,

        output reg full,
        output reg empty,
        output reg wr_error,
        output reg rd_error
    
    );

    reg [PTR_WIDTH-1:0] wr_ptr;
    reg [PTR_WIDTH-1:0] rd_ptr;
    reg [PTR_WIDTH:0] counter;

    //reg wr_rollover;
    //reg rd_rollover;

    reg [WIDTH-1:0] mem [DEPTH-1:0];

    assign full = (counter <= DEPTH-1) ? 0 : 1;
    assign empty = (counter > 0) ? 0 : 1;

    //write
    always @ (posedge clk_i) begin
        if(rst_i == 1) begin
            wr_ptr <= 0;
            wr_error <= 0;
        end

        else begin
            
            if(wr_en_i == 1 && full == 0) begin
                mem[wr_ptr] <= wr_data_i;
                wr_ptr <= wr_ptr + 1;
                wr_error <= 0;
            end
            
            else if(wr_en_i == 1 && full == 1)
               wr_error <= 1;

            else
                wr_error <= 0; 
        end
    end

    //read
    always @ (posedge clk_i) begin
        if(rst_i == 1) begin
            rd_data_o <= 0;
            rd_ptr <= 0;
            rd_error <= 0;
        end

        else begin
            if(rd_en_i == 1 && empty == 0) begin
                rd_data_o <= mem[rd_ptr];
                rd_ptr <= rd_ptr + 1;
                rd_error <= 0;
            end

            else if(rd_en_i == 1 && empty == 1) begin
                rd_error <= 1;
            end

            else
                rd_error <= 0;

        end
    end

    //counter
    always @ (posedge clk_i) begin
        if(rst_i == 1) begin
            counter <= 0;
        end

        else begin
            case({wr_en_i,rd_en_i})
                2'b00 : counter <= counter;
                2'b01 : begin
                    if(empty == 0)
                        counter <= counter - 1;
                    else
                        counter <= counter;
                end
                2'b10 : begin
                    if(full == 0)
                        counter <= counter + 1;
                    else
                        counter <= counter;
                end 
                2'b11 : begin
                    counter <= counter;
                end
                default: counter <= 0;
            endcase
        end
    end
endmodule
