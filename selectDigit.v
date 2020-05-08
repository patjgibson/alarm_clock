`timescale 1ns / 1ps
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Patrick Gibson
// 
// Create Date: 12/02/2019 06:30:58 PM
// Module Name: selectDigit
// Project Name: Alarm Clock
// Description: Switches between editing either the minutes or the hours.
// 
//////////////////////////////////////////////////////////////////////////////////


module selectDigit(
    output reg selected,
    input editMode,
    input moveLeft,
    input reset
    );
    
    initial begin
        selected = 1;
    end
    
    always @ (posedge moveLeft or posedge reset)
        if (reset)
            selected <= 1;
        else
            selected <= ~selected;
    
endmodule
