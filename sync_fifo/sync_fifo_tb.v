
`include "sync_fifo.v"

module sync_fifo_tb;

parameter WIDTH = 8;
parameter DEPTH = 16;
parameter PTR_WIDTH = 4;

reg clk_i;
reg rst_i;

reg wr_en_i;
reg [WIDTH-1:0] wr_data_i;

reg rd_en_i;
wire [WIDTH-1:0] rd_data_o;

wire full;
wire empty;

wire wr_error;
wire rd_error;

reg [30*8:1] test_case;

sync_fifo
    #(
        .WIDTH(WIDTH),
        .DEPTH(DEPTH),
        .PTR_WIDTH(PTR_WIDTH)
    )
    f1 (
        .clk_i(clk_i),
        .rst_i(rst_i),
        
        .wr_en_i(wr_en_i),
        .wr_data_i(wr_data_i),
        
        .rd_en_i(rd_en_i),
        .rd_data_o(rd_data_o),

        .full(full),
        .empty(empty),

        .wr_error(wr_error),
        .rd_error(rd_error)
    );


    initial begin
        clk_i = 0;
        forever #5 clk_i = ~clk_i;
    end

    initial begin
        $value$plusargs("test_case=%0s",test_case);
        rst_i = 1;
        #20
        rst_i = 0;
        rd_en_i = 0;
    end

    integer i;

    initial begin


        wait (rst_i == 0)

        case(test_case)
            "FULL" : begin
                write_fifo(DEPTH);
            end

            "EMPTY" : begin
                write_fifo(DEPTH-5);
                read_fifo(DEPTH-5);
            end

            "WR_ERR" : begin
                write_fifo(DEPTH+2);
            end

            "RD_ERR" : begin
                write_fifo(DEPTH);
                read_fifo(DEPTH+2);
            end
            
            default : begin
                $display("Testcase is not valid");
            end

        endcase

        #20;
        $finish;
    end

    task write_fifo(input integer num_write);
        begin
            for(i=0; i<=num_write-1; i=i+1) begin
                @(posedge clk_i);
                wr_en_i = 1;
                wr_data_i = $random;
            end

            @(posedge clk_i)
            wr_en_i = 0;
            wr_data_i = 0;
            end
    endtask
    
    task read_fifo(input integer num_read);
        begin
            for(i=0; i<=num_read-1; i=i+1) begin
                @(posedge clk_i);
                rd_en_i = 1;
            end
            @(posedge clk_i)
            rd_en_i = 0;
        end
    endtask

endmodule



