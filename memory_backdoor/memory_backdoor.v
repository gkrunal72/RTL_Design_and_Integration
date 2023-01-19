module memory_backdoor

    #(
        parameter WIDTH = 16,
        parameter DEPTH = 16,
        parameter ADDR_LINES = 4
    )
    (
        input   wire    clk_i,
        input   wire    rst_i,
        input   wire    wr_rd_i,
        input   wire    [ADDR_LINES-1:0]    addr_i,
        input   wire    [WIDTH-1:0]         wr_data_i,
        output  reg     [WIDTH-1:0]         rd_data_o,
        input   wire    valid_i,
        output  reg     ready_o
    );

    //define memory
    reg [WIDTH-1:0] mem [DEPTH-1:0];

    always @ (posedge clk_i or posedge rst_i) begin
        
        if (rst_i==1) begin
            rd_data_o <= 0;
            ready_o <= 0;
        end

        else begin
            if(valid_i==1) begin
                
                //wr_rd_i == 1 --> Write
                if(wr_rd_i == 1) begin
                    ready_o <= 1;
                    mem[addr_i] <= wr_data_i;
                end


                //wr_rd_i == 0 --> Read 
                else if (wr_rd_i == 0) begin
                    ready_o <= 1;
                    rd_data_o <= mem[addr_i];
                end

                else
                    ready_o <= 0;
            end

            else
                ready_o <= 0;
        end
    end
endmodule
