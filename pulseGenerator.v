`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Patrick Gibson
// 
// Create Date: 12/02/2019 06:30:58 PM
// Module Name: pulseGenerator
// Project Name: Alarm Clock
// Description: Sends out a pulse every minute and hour which will later be counted
//				to track the time.
// 
//////////////////////////////////////////////////////////////////////////////////


module pulseGenerator(
    output reg pulse1min,
    output reg pulse1hour,
    input minutes,
    input clk5MHz,
    input reset
    );
    
    reg [28:0] counter60s;
    reg [5:0] counter60mins;
    
    parameter oneMinute = 4999999;
    
    initial begin
        pulse1min = 0;
        pulse1hour = 0;
        counter60s = 0;
        counter60mins <= 0;
    end
    
    always @ (posedge pulse1min or posedge reset)
        if (reset) begin
            pulse1hour <= 0;
            counter60mins <= 0;
        end
        else
            if (counter60mins == 59) begin
                pulse1hour <= 1;
                counter60mins <= 0;
            end
            else begin
                pulse1hour <= 0;
                counter60mins <= counter60mins + 1;
            end
    
    always @ (posedge clk5MHz or posedge minutes or posedge reset)
        if (reset) begin
            pulse1min <= 0;
            counter60s <= 0;
        end
        else if (minutes) begin
            pulse1min <= 1;
            if (counter60s >= oneMinute) counter60s <= 0;
            else counter60s <= counter60s + 1;
        end
        else
            if (counter60s >= oneMinute) begin
                pulse1min <= 1;
                counter60s <= 0;
            end
            else begin
                pulse1min <= 0;
                counter60s <= counter60s + 1;
            end
    
endmodule
