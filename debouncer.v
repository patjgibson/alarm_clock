`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Patrick Gibson
// 
// Create Date: 12/02/2019 06:30:58 PM
// Module Name: debouncer
// Project Name: Alarm Clock
// Description: Debounces user inputs. Once the input signal is unchanged for
//				what is deemed a stable amount of time, the signal is
//				considered debounced.
// 
//////////////////////////////////////////////////////////////////////////////////


module debouncer(
    output reg debounced,
    input button,
    input clk
    );
    
    reg value1, value2;
    reg [18:0] count;
    
    parameter stableTime = 49999;
    
    initial begin
        value1 = 0;
        value2 = 0;
        debounced = 0;
        count = 0;
    end
    
    always @ (posedge clk) begin
        value1 <= button;
        value2 <= value1;
        
        if (value1 ^ value2)
            count <= 0;
        else
            count <= count + 1;
        
        if (count == stableTime)
            debounced <= value2;
        else
            debounced <= debounced;
        
    end
    
endmodule
