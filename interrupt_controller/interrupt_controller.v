module interrupt_controller
    #(
        parameter DATA_WIDTH = 16,
        parameter ADDR_WIDTH = 4,
        parameter INTR_WIDTH = 16,
        parameter INTR_ADDR = 4,

        //Parameter for state machine
        parameter WAITING_FOR_INTR = 4'b0001,
        parameter INTR_DETECTED = 4'b0010,
        parameter INTR_GIVEN_TO_PROC = 4'b0100,
        parameter INTR_SERVICED = 4'b1000
    )
    (
        input wire clk_i,
        input wire rst_i,
        
        input wire [DATA_WIDTH-1:0] addr_i,     //Interrupt address to set priority value
        input wire [DATA_WIDTH-1:0] wr_data_i,  //Write Priority value
        input wire wr_en_i,                     //Write enable signal

        output reg [DATA_WIDTH-1:0] rd_data_o,  //Read priority value
        input wire rd_en_i,                     //Read enable

        input wire [INTR_WIDTH-1:0] intr_i,     //Interrupt Port
        output reg [INTR_ADDR-1:0] intr_to_service_o,  //Interrupt to be serviced
        input wire intr_serviced_i,             //Interrupt has been serviced notification by uP to IC

        output reg intr_valid_o,        //Interrupt is Valid - IC to uP
        output reg ready_o,             //Ready 
        input reg valid_i               //Valid signal from uP to IC to confirm valid RD/WR operation
    );

    reg [ADDR_WIDTH-1:0] state; //State machine: State variable

    reg [DATA_WIDTH-1:0] cur_highest_prio;  //Used to check and update highest priority active interrupt

    reg change_state_f; //Used in INTR_DETECTED state to decide whether to stay in same state of jump to INTR_GIVEN_TO_PROC state
    
    reg [INTR_ADDR-1:0] intr_with_highest_prio; //Reg to find highest priority interrupt
    
    integer j; //loop variable

    //Priority register memory
    reg [INTR_ADDR-1:0] intr_reg [INTR_WIDTH-1:0];

    //Interrupt priority register (intr_reg) Read/Write
    always @ (posedge clk_i) begin
        if(rst_i == 1) begin
            rd_data_o <= 0;
            ready_o <= 0;
        end

        else begin
            if(wr_en_i == 1 && valid_i == 1) begin
                ready_o <= 1;
                intr_reg[addr_i] <= wr_data_i;  //Giving priority value using write operation to intr_reg.
            end

            else if(rd_en_i == 1 && valid_i == 1) begin
                ready_o <= 1;
                rd_data_o <= intr_reg[addr_i];  //Reading priority value
            end

            else begin
                rd_data_o <= 0;
                ready_o <= 0;
            end

        end
    end

    //State machine to detect and complete interrupt request
    always @ (posedge clk_i) begin
        if(rst_i == 1) begin
            intr_valid_o <= 0;
            intr_to_service_o <= 0;
            cur_highest_prio <= 0;
            state <= WAITING_FOR_INTR;
            change_state_f <= 0;
            intr_with_highest_prio <= 0;
        end

        else begin
            case(state)
                //Check if there is any active interrupt
                WAITING_FOR_INTR: begin
                    if(intr_i != 0) begin
                        state <= INTR_DETECTED;
                    end
                    
                    else begin
                        state <= WAITING_FOR_INTR;
                    end
                end

                //Find the highests priority interrupt among active interrupts
                INTR_DETECTED: begin
                    if(change_state_f == 0) begin
                                        
                        for (j=0; j < INTR_WIDTH; j=j+1) begin
                            if(intr_i[j] == 1) begin
                                if(cur_highest_prio <= intr_reg[j]) begin
                                    cur_highest_prio = intr_reg[j];
                                    intr_with_highest_prio = j;
                                    $display("intr_reg[%0d]=%0d \tintr_i=%0h  \tcur_highest_prio=%0d \tintr_with_highest_prio=%0d",j,intr_reg[j], intr_i, cur_highest_prio ,intr_with_highest_prio);
                                end
                            end
                            
                            if(j == INTR_WIDTH-1) begin
                                change_state_f <= 1;
                            end
                        end
                        state <= INTR_DETECTED;
                    end

                    else begin
                        state <= INTR_GIVEN_TO_PROC;
                        change_state_f <= 0;
                        cur_highest_prio <= 0;
                        intr_to_service_o <= intr_with_highest_prio;
                    end
                end

                //Wait till interrupt is serviced by uP
                INTR_GIVEN_TO_PROC: begin
                    
                    if(intr_serviced_i == 0) begin
                        intr_valid_o <= 1;
                        state <= INTR_GIVEN_TO_PROC;
                    end

                    else begin
                        intr_to_service_o <= 0;
                        intr_valid_o <= 0;
                        state <= WAITING_FOR_INTR;
                    end
                end

                //Default
                default : begin
                    state <= WAITING_FOR_INTR;
                end

            endcase
        end
    end
endmodule
