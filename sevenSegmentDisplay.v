`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Patrick Gibson
// 
// Create Date: 12/02/2019 06:30:58 PM
// Module Name: sevenSegmentDisplay
// Project Name: Alarm Clock
// Description: Illuminates one by one each number at a rate of 500 Hz.
// 
//////////////////////////////////////////////////////////////////////////////////


module sevenSegmentDisplay(
    output pm,
    output [6:0] seg,
    output reg [7:0] an,
    output reg decimal,
    input [5:0] clockMinutes,
    input [5:0] clockHours,
    input [5:0] alarmMinutes,
    input [5:0] alarmHours,
    input displayAlarm,
    input set24hours,
    input editMode,
    input selected,
    input clk3Hz,
    input clk500Hz
    );
    
    reg [5:0] minutes, hours;
    reg [5:0] number;
    reg [1:0] toggledDisplay;
    reg tens, hoursPlace;
    
    
    always @ (displayAlarm)
        if (displayAlarm) begin
            minutes = alarmMinutes;
            hours = alarmHours;
        end
        else begin
            minutes = clockMinutes;
            hours = clockHours;
        end
    
    initial begin
        number = 0;
        toggledDisplay = 0;
        tens = 0;
    end
    
    displayDriver display(seg, number, tens, hoursPlace, set24hours);
    
    assign pm = (hours >= 12) && ~set24hours;
    
    always @ (posedge clk500Hz) begin
        an[0] <= 1;
        an[1] <= 1;
        an[2] <= 1;
        an[3] <= 1;
        an[4] <= 1;
        an[5] <= 1;
        an[6] <= 1;
        an[7] <= 1;
        decimal <= 1;
        hoursPlace <= 0;
        case (toggledDisplay)
            0: begin
                number <= minutes;
                tens <= 0;
                if (editMode && selected == 0)
                    an[0] <= clk3Hz;
                else
                    an[0] <= 0;
            end
            1: begin
                number <= minutes;
                tens <= 1;
                if (editMode && selected == 0)
                    an[1] <= clk3Hz;
                else
                    an[1] <= 0;
            end
            2: begin
                number <= hours;
                hoursPlace <= 1;
                tens <= 0;
                decimal <= 0; // turning off the number also turns off the digit.
                if (editMode && selected == 1)
                    an[2] <= clk3Hz;
                else
                    an[2] <= 0;
            end
            3: begin
                number <= hours;
                hoursPlace <= 1;
                tens <= 1;
                if (editMode && selected == 1)
                    an[3] <= clk3Hz;
                else
                    an[3] <= 0;
            end
            default: begin
                number <= 0;
                tens <= 0;
            end
        endcase
        toggledDisplay <= toggledDisplay + 1;
    end
    
endmodule
