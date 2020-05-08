`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Patrick Gibson
// 
// Create Date: 12/02/2019 06:30:58 PM
// Module Name: clockDivider
// Project Name: Alarm Clock
// Description: Responsable for dividing the 5 MHz clock into shorter frequency
//				clocks used for the seven segment display and alarm.
// 
//////////////////////////////////////////////////////////////////////////////////


module clockDivider(
    input inc1min,
    input inc1hour,
    output reg clk2s,
    output reg clk3Hz,
    output reg clk500Hz,
    input clk5MHz
    );
    
    reg [22:0] counter2s;
    reg [20:0] counter3Hz;
    reg [12:0] counter500Hz;
    
    initial begin
        counter2s = 0;
        counter3Hz = 0;
        counter500Hz = 0;
        clk2s = 0;
        clk3Hz = 0;
        clk500Hz = 0;
    end
    
    // Counting the 2 s signal and updating it accordingly.
    always @ (posedge clk5MHz)
        if (counter2s == 4999999) begin
            counter2s <= 0;
            clk2s <= ~clk2s;
        end
        else
            counter2s <= counter2s + 1;
    
    // Counting the 3 Hz signal (it's actually 3/2 hertz)
    always @ (posedge clk5MHz)
        if (inc1min || inc1hour) begin
            counter3Hz <= 0;
            clk3Hz <= 0;
        end
        else if (counter3Hz == 1666667) begin
            counter3Hz <= 0;
            clk3Hz <= ~ clk3Hz;
        end
        else
            counter3Hz <= counter3Hz + 1;
    
    // Counting the 500 Hz signal and updating it accordingly.
    always @ (posedge clk5MHz)
        if (counter500Hz == 4999) begin
            counter500Hz <= 0;
            clk500Hz <= ~clk500Hz;
        end
        else
            counter500Hz <= counter500Hz + 1;
    
endmodule
