//The oneHz_gen module divides the 100 MHz input clock down to 1 Hz.
`timescale 1ns / 1ps

module oneHz_gen(
    input clk_100MHz,       
    output clk_1Hz
    );
    
    reg [25:0] counter_reg = 0;
    reg clk_reg = 0;
    
    always @(posedge clk_100MHz) begin
        if(counter_reg == 49_999_999) begin
            counter_reg <= 0;
            clk_reg <= ~clk_reg;
        end
        else
            counter_reg <= counter_reg + 1;//The counter counts up to 49,999,999 (representing 0.5 seconds) and toggles the output clock.
    end
    
    assign clk_1Hz = clk_reg;
//the output clock (clk_1Hz) toggles every 0.5 seconds, resulting in a full cycle (0 -> 1 -> 0) every 1 second, 
    //which generates a clock signal with a frequency of 1 Hz.    
endmodule
