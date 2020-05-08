`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Patrick Gibson
// 
// Create Date: 12/02/2019 06:30:58 PM
// Module Name: manualPulses
// Project Name: Alarm Clock
// Description: This module sends out pulses when instructed to by the user.
// 
//////////////////////////////////////////////////////////////////////////////////


module manualPulses(
    output incMinClock,
    output incHourClock,
    output incMinAlarm,
    output incHourAlarm,
    input displayAlarm,
    input editMode,
    input increase,
    input selected
    );
    
    assign incMinClock = ~displayAlarm && editMode && increase && selected == 0;
    assign incHourClock = ~displayAlarm && editMode && increase && selected == 1;
    assign incMinAlarm = displayAlarm && editMode && increase && selected == 0;
    assign incHourAlarm = displayAlarm && editMode && increase && selected == 1;
    
endmodule
