`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Patrick Gibson
// 
// Create Date: 12/02/2019 06:30:58 PM
// Module Name: masterController
// Project Name: Alarm Clock
// Description: Main module containing all submodules.
// 
//////////////////////////////////////////////////////////////////////////////////


module masterController(
    input clk100MHz,
    input enable,
    input reset,
    input editMode,
    input displayAlarm,
    input set24hours,
    input increaseBounced,
    input decreaseBounced,
    input shiftBounced,
    output alarmEnabled,
    output alarmOn,
    output enabled24hours,
    output pm,
    output [6:0]seg,
    output [7:0]an,
    output decimal
    );
    
	// Initializing wires
    wire selected, pulse1min, pulse1hour, clk2s, clk3Hz, clk500Hz, clk5MHz;
    wire [5:0] clockMinutes, alarmMinutes, clockHours, alarmHours;
    reg [5:0] minutes, hours;
    
	// Debouncing inputs which are used for increasing the current time. The "shift" deboucner is used to alter between hours and minutes
    debouncer increaseDebouncer(increase, increaseBounced, clk5MHz);
    debouncer shiftDebouncer(shift, shiftBounced, clk5MHz);
    
	// Once debouned, pulses can then be sent.
    manualPulses manualpulses(incMinClock, incHourClock, incMinAlarm, incHourAlarm, displayAlarm, editMode, increase, selected);
    
	// Setting up the clock and sending pulses to increment counts every 60 s and 1 hour.
    clk100MHz_5MHz divideTo5MHz(clk5MHz, clk100MHz);
    clockDivider divider(incMinClock, incHourClock, clk2s, clk3Hz, clk500Hz, clk5MHz);
    pulseGenerator generator(pulse1min, pulse1hour, incMinClock, clk5MHz, reset);
    
	// Modules to count the seconds and hours. Responds to internal clock and when manually told to increment.
    countTime clockTime(clockMinutes, clockHours, pulse1min, pulse1hour || incHourClock, reset);
    countTime alarmTime(alarmMinutes, alarmHours, incMinAlarm, incHourAlarm, reset);
    
	// Flashes minutes or hours place depending on what is being edited by the user.
    selectDigit select(selected, editMode, shift, reset); //Bootleg, but fixes a weird problem where only one movement control would work.
    
	// Seven-segment display driver.
    sevenSegmentDisplay display(pm, seg, an, decimal, clockMinutes, clockHours, alarmMinutes, alarmHours, displayAlarm, set24hours, editMode, selected, clk3Hz, clk500Hz);
    
	// Triggering the alarm.
    alarmTrigger alarmTrigger(alarmOn, clockMinutes, clockHours, alarmMinutes, alarmHours, enable, reset, clk2s, clk5MHz);
    
	// A few other inputs which can be set by the user.
    assign alarmEnabled = enable;
    assign enabled24hours = set24hours;
    
endmodule
