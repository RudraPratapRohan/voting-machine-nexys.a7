//so fpga has high frequency and if we give input it will take multiple input so avoid that we use frequency divider
//The twoHz_gen module divides a 100 MHz clock signal down to a 2 Hz signal T = 0.5sec

`timescale 1ns / 1ps

module twoHz_gen(
    input clk_100MHz,           
    output clk_2Hz
    );
    
    reg [24:0] counter_reg = 0;
    reg clk_reg = 0;
    
    always @(posedge clk_100MHz) begin
        if(counter_reg == 24_999_999) begin//The counter counts to 24,999,999 (representing 0.25 seconds) and toggles the output clock.
            counter_reg <= 0;
            clk_reg <= ~clk_reg;
        end
        else
            counter_reg <= counter_reg + 1;
    end
    
    assign clk_2Hz = clk_reg;//The output clock (clk_2Hz) toggles every 0.25 seconds,
    //resulting in a full cycle (0 -> 1 -> 0) every 0.5 seconds, creating a clock with a frequency of 2 Hz.
    
endmodule
