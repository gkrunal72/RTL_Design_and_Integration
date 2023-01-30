//Pattern Detector with Mealy state machine
module pattern_detector_mealy

    #(
        parameter RST = 3'b000,
        parameter STATE1 = 3'b001,
        parameter STATE2 = 3'b010,
        parameter STATE3 = 3'b011,
        parameter STATE4 = 3'b100,
    )
    
    (
        input wire clk_i,
        input wire rst_i,
        input wire d_i,
        output reg pattern_detected_o
    );

    reg [2:0] state;
    
//    reg [2:0] next_state;
    
    always @ (posedge clk_i) begin
        
        if(rst_i == 0) begin
            pattern_detected_o <= 0;
            state <= RST;
        end

        else begin
            case(state)
                RST : begin        
                    pattern_detected_o <= 0;
                    
                    if(d_i == 0)
                        state <= RST;

                    else
                        state <= STATE1;
                end
                
                STATE1 : begin
                    
                    pattern_detected_o <= 0;
                    
                    if(d_i == 0)
                        state <= RST;
                    else
                        state <= STATE2;
                end
                
                STATE2 : begin
                    
                    pattern_detected_o <= 0;
                    
                    if(d_i == 0)
                        state <= STATE3;
                    else
                        state <= STATE2;
               
                end
                
                STATE3 : begin
                    
                    pattern_detected_o <= 0;
                    
                    if(d_i == 0)
                        state <= RST;
                    else
                        state <= STATE4;
                
                end
                
                STATE4 : begin
                    
                    if(d_i == 0) begin
                        state <= RST;
                        pattern_detected_o <= 0;
                    end

                    else begin
                        state <= STATE2;
                        pattern_detected_o <= 1;
                    end
                end
                
                default : begin
                    state <= RST;
                end     
            endcase
        end
    end
endmodule
