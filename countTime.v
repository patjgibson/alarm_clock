`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Patrick Gibson
// 
// Create Date: 12/02/2019 06:30:58 PM
// Module Name: countTime
// Project Name: Alarm Clock
// Description: Resonsable for counting the minutes and hours.
// 
//////////////////////////////////////////////////////////////////////////////////


module countTime(
    output reg [5:0] minutes,
    output reg [5:0] hours,
    input minute,
    input hour,
    input reset
    );
    
    // Minute Counter
    always @ (posedge minute or posedge reset)
        if (reset)
            minutes <= 0;
        else
            if (minutes == 59) minutes <= 0;
            else minutes <= minutes + 1;
    
    // Hour Counter
    always @ (posedge hour or posedge reset)
        if (reset)
            hours <= 0;
        else
            if (hours == 23) hours <= 0;
            else hours <= hours + 1;
    
endmodule
