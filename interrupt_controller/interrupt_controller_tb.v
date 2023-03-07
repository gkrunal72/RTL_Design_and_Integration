`include "interrupt_controller.v"

module interrupt_controller_tb;

parameter DATA_WIDTH = 16;
parameter ADDR_WIDTH = 4;
parameter INTR_WIDTH = 16;
parameter INTR_ADDR = 4;

reg clk_i;
reg rst_i;

reg [DATA_WIDTH-1:0] addr_i;    //Interrupt address to set priority value
reg [DATA_WIDTH-1:0] wr_data_i; //Write Priority value
reg wr_en_i;                    //Write enable signal

wire [DATA_WIDTH-1:0] rd_data_o; //Read priority value
reg rd_en_i;                    //Read enable

reg [INTR_WIDTH-1:0] intr_i;    //Interrupt Port
wire [INTR_ADDR-1:0] intr_to_service_o;  //Interrupt to be serviced
reg intr_serviced_i;            //Interrupt has been serviced notification by uP to IC

wire intr_valid_o;              //Interrupt is Valid - IC to uP
wire ready_o;                   //Ready for Read/Write operation - IC to uP
reg valid_i;                    //Validation signal for Read/Write opeartion - uP to IC

reg [30*8:1] testcase;          //Variable to get testcase name from elaboration

reg [ADDR_WIDTH-1:0] prio_arr [DATA_WIDTH-1:0]; //Array to store unique random priority values from 0-15

//Instantiation
interrupt_controller
    #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .INTR_WIDTH(INTR_WIDTH),
        .INTR_ADDR(INTR_ADDR)
    )
    ic1
    (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .addr_i(addr_i),
        .wr_data_i(wr_data_i),
        .wr_en_i(wr_en_i),
        .rd_data_o(rd_data_o),
        .rd_en_i(rd_en_i),
        .intr_i(intr_i),
        .intr_to_service_o(intr_to_service_o),
        .intr_serviced_i(intr_serviced_i),
        .intr_valid_o(intr_valid_o),
        .ready_o(ready_o),
        .valid_i(valid_i)
    );

    integer i;  //Loop variable
    integer seed;   //Seed for random

    //Clock
    initial begin
        clk_i = 0;

        forever #5 clk_i = ~clk_i;
    end

    //Assign initial values
    initial begin
        addr_i <= 0;
        wr_data_i <= 0;
        wr_en_i <= 0;
        rd_en_i <= 0;
        intr_i <= 0;
        intr_serviced_i <= 0;
        seed <= 2565;
    end

    //Actual testing
    initial begin
        rst_i <= 1;
        #50
        rst_i <= 0;
        
        //Fill up priority array
        fill_prio_arr();
        
        $value$plusargs("testcase=%s",testcase);
        $display("testcase = %0s",testcase);

        //Writing priority register
        for(i=0; i< DATA_WIDTH; i=i+1) begin
            if(testcase == "LO_REG_LO_PRIO") wr_mem_fd(i,i);
            if(testcase == "LO_REG_HI_PRIO") wr_mem_fd(i,DATA_WIDTH-1-i);
            if(testcase == "RANDOM_PRIO") begin
                wr_mem_fd(i,prio_arr[i]);
                $display("prio_arr[%0d]=%d", i, prio_arr[i]);
            end
        end

        intr_i <= $random(seed); 
        #700;

        intr_i <= $random(seed*2);
        #700;

        intr_i <= $random(seed*4);
        #700;

        $finish;
    end


    initial begin
        forever begin
            @(posedge clk_i)
            if(intr_valid_o == 1) begin
                #20;
                intr_serviced_i = 1;
                intr_i[intr_to_service_o] = 0;
                @(posedge clk_i)
                intr_serviced_i = 0;
            end
        end
    end

    //Task to write priority register
    task wr_mem_fd
        (
            input [ADDR_WIDTH:0] addr,
            input [DATA_WIDTH:0] data
        );
        begin
            
            //$display("\nWrite_fd : Start\n");
            
            //$display("start_addr+num_locs=%d",(start_addr+num_locs));
            
                @(posedge clk_i)
                valid_i <= 1;
                wr_en_i <= 1;
                addr_i <= addr;
                wait (ready_o == 1);
                wr_data_i <= data;
            
            //@(posedge clk_i)//Hold valid=1 for one more cycle to complete the last write operation
            @(posedge clk_i)
            valid_i <= 0;
            wr_en_i <= 0;
            addr_i <= 0;
            wr_data_i <= 0;
            //$display("\nWrite_fd : Stop\n");
        end
    endtask

    //Task to fill up priority array with unique random values from 0 to 15
    task fill_prio_arr();
        integer p,q; //Loop variables
        reg match;  //flag to find if randomly generator is already present in the array on not
        reg [DATA_WIDTH-1:0] temp;

        begin
            for(p=0; p<DATA_WIDTH;) begin
                
                temp=$urandom_range(0,15);
                
                for(q=0; q<DATA_WIDTH;q=q+1) begin       
            
                    if(temp==prio_arr[q])
                        match = match + 1;
                    end

                    if (match == 0) begin
                        prio_arr[p] = temp;
                        p = p+1;
                    end
                    match = 0;
                end
        end
    endtask

endmodule

