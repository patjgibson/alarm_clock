`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Patrick Gibson
// 
// Create Date: 12/02/2019 06:30:58 PM
// Module Name: alarmTrigger
// Project Name: Alarm Clock
// Description: Using inputs indicating the current time and alarm time. This
// 				module determines when to trigger the alarm.
// 
//////////////////////////////////////////////////////////////////////////////////


module alarmTrigger(
    output reg alarmOn,
    input [5:0] clockMinutes,
    input [5:0] clockHours,
    input [5:0] alarmMinutes,
    input [5:0] alarmHours,
    input enable,
    input reset,
    input clk2s,
    input clk5MHz
    );
    
    reg triggered;
    
    initial begin
        triggered = 0;
        alarmOn = 0;
    end
    
    always @ (posedge clk5MHz or posedge reset)
        if (reset) begin
            triggered <= 0;
            alarmOn <= 0;
        end
        else if (enable && (triggered || clockMinutes == alarmMinutes && clockHours == alarmHours)) begin
            triggered <= 1;
            alarmOn <= clk2s;
        end
        else begin
            triggered <= 0;
            alarmOn <= 0;
        end
    
endmodule
