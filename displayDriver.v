`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Patrick Gibson
// 
// Create Date: 12/02/2019 06:30:58 PM
// Module Name: displayDriver
// Project Name: Alarm Clock
// Description: This module decodes the input number and is used to drive the
//				drive the seven segment display. (This could have been done
//				more easily, but I was on a time crunch and panicking)
// 
//////////////////////////////////////////////////////////////////////////////////


module displayDriver(
    output reg [6:0] seg,
    input [5:0] number,
    input tens,
    input hoursPlace,
    input set24hours
    );
    
    reg [3:0] onesValue, tensValue;
    reg [5:0] tempNumb;
    
    always @ (tens) begin
        seg[0] = 1;
        seg[1] = 1;
        seg[2] = 1;
        seg[3] = 1;
        seg[4] = 1;
        seg[5] = 1;
        seg[6] = 1;
        seg[7] = 1;
        
        if(!tens)
            case(onesValue)
                0: begin
                    seg[0] = 0;
                    seg[1] = 0;
                    seg[2] = 0;
                    seg[3] = 0;
                    seg[4] = 0;
                    seg[5] = 0;
                end
                1: begin
                    seg[1] = 0;
                    seg[2] = 0;
                end
                2: begin
                    seg[0] = 0;
                    seg[1] = 0;
                    seg[3] = 0;
                    seg[4] = 0;
                    seg[6] = 0;
                end
                3: begin
                    seg[0] = 0;
                    seg[1] = 0;
                    seg[2] = 0;
                    seg[3] = 0;
                    seg[6] = 0;
                end
                4: begin
                    seg[1] = 0;
                    seg[2] = 0;
                    seg[5] = 0;
                    seg[6] = 0;
                end
                5: begin
                    seg[0] = 0;
                    seg[2] = 0;
                    seg[3] = 0;
                    seg[5] = 0;
                    seg[6] = 0;
                end
                6: begin
                    seg[0] = 0;
                    seg[2] = 0;
                    seg[3] = 0;
                    seg[4] = 0;
                    seg[5] = 0;
                    seg[6] = 0;
                end
                7: begin
                    seg[0] = 0;
                    seg[1] = 0;
                    seg[2] = 0;
                end
                8: begin
                    seg[0] = 0;
                    seg[1] = 0;
                    seg[2] = 0;
                    seg[3] = 0;
                    seg[4] = 0;
                    seg[5] = 0;
                    seg[6] = 0;
                end
                9: begin
                    seg[0] = 0;
                    seg[1] = 0;
                    seg[2] = 0;
                    seg[3] = 0;
                    seg[5] = 0;
                    seg[6] = 0;
                end
            endcase
        else
            case(tensValue)
            0: begin
                    seg[0] = 0;
                    seg[1] = 0;
                    seg[2] = 0;
                    seg[3] = 0;
                    seg[4] = 0;
                    seg[5] = 0;
                end
                1: begin
                    seg[1] = 0;
                    seg[2] = 0;
                end
                2: begin
                    seg[0] = 0;
                    seg[1] = 0;
                    seg[3] = 0;
                    seg[4] = 0;
                    seg[6] = 0;
                end
                3: begin
                    seg[0] = 0;
                    seg[1] = 0;
                    seg[2] = 0;
                    seg[3] = 0;
                    seg[6] = 0;
                end
                4: begin
                    seg[1] = 0;
                    seg[2] = 0;
                    seg[5] = 0;
                    seg[6] = 0;
                end
                5: begin
                    seg[0] = 0;
                    seg[2] = 0;
                    seg[3] = 0;
                    seg[5] = 0;
                    seg[6] = 0;
                end
                6: begin
                    seg[0] = 0;
                    seg[2] = 0;
                    seg[3] = 0;
                    seg[4] = 0;
                    seg[5] = 0;
                    seg[6] = 0;
                end
                7: begin
                    seg[0] = 0;
                    seg[1] = 0;
                    seg[2] = 0;
                    seg[3] = 0;
                end
                8: begin
                    seg[0] = 0;
                    seg[1] = 0;
                    seg[2] = 0;
                    seg[3] = 0;
                    seg[4] = 0;
                    seg[5] = 0;
                    seg[6] = 0;
                end
                9: begin
                    seg[0] = 0;
                    seg[1] = 0;
                    seg[2] = 0;
                    seg[3] = 0;
                    seg[5] = 0;
                    seg[6] = 0;
                end
            endcase
        end
            
    always @ (number) begin
        if (~set24hours && hoursPlace && number > 12)
            tempNumb = number - 12;
        else if (number == 24 && set24hours)
            tempNumb = 0;
        else
            tempNumb = number;
            
        case(tempNumb)
            0: begin
                if (~set24hours && hoursPlace) begin
                    tensValue = 1;
                    onesValue = 2;
                end
                else begin
                    tensValue = 0;
                    onesValue = 0;
                end
            end
            1: begin
                tensValue = 0; 
                onesValue = 1;
            end
            2: begin
                tensValue = 0; 
                onesValue = 2;
            end
            3: begin
                tensValue = 0; 
                onesValue = 3;
            end
            4: begin
                tensValue = 0; 
                onesValue = 4;
            end
            5: begin
                tensValue = 0; 
                onesValue = 5;
            end
            6: begin
                tensValue = 0; 
                onesValue = 6;
            end
            7: begin
                tensValue = 0; 
                onesValue = 7;
            end
            8: begin
                tensValue = 0; 
                onesValue = 8;
            end
            9: begin
                tensValue = 0; 
                onesValue = 9;
            end
            10: begin
                tensValue = 1; 
                onesValue = 0;
            end
            11: begin
                tensValue = 1; 
                onesValue = 1;
            end
            12: begin
                tensValue = 1; 
                onesValue = 2;
            end
            13: begin
                tensValue = 1; 
                onesValue = 3;
            end
            14: begin
                tensValue = 1; 
                onesValue = 4;
            end
            15: begin
                tensValue = 1; 
                onesValue = 5;
            end
            16: begin
                tensValue = 1; 
                onesValue = 6;
            end
            17: begin
                tensValue = 1;
                onesValue = 7;
            end
            18: begin
                tensValue = 1; 
                onesValue = 8;
            end
            19: begin
                tensValue = 1; 
                onesValue = 9;
            end
            20: begin
                tensValue = 2; 
                onesValue = 0;
            end
            21: begin
                tensValue = 2; 
                onesValue = 1;
            end
            22: begin
                tensValue = 2; 
                onesValue = 2;
            end
            23: begin
                tensValue = 2; 
                onesValue = 3;
            end
            24: begin
                tensValue = 2; 
                onesValue = 4;
            end
            25: begin
                tensValue = 2; 
                onesValue = 5;
            end
            26: begin
                tensValue = 2; 
                onesValue = 6;
            end
            27: begin
                tensValue = 2; 
                onesValue = 7;
            end
            28: begin
                tensValue = 2; 
                onesValue = 8;
            end
            29: begin
                tensValue = 2; 
                onesValue = 9;
            end
            30: begin
                tensValue = 3; 
                onesValue = 0;
            end
            31: begin
                tensValue = 3; 
                onesValue = 1;
            end
            32: begin
                tensValue = 3; 
                onesValue = 2;
            end
            33: begin
                tensValue = 3; 
                onesValue = 3;
            end
            34: begin
                tensValue = 3; 
                onesValue = 4;
            end
            35: begin
                tensValue = 3; 
                onesValue = 5;
            end
            36: begin
                tensValue = 3; 
                onesValue = 6;
            end
            37: begin
                tensValue = 3; 
                onesValue = 7;
            end
            38: begin
                tensValue = 3; 
                onesValue = 8;
            end
            39: begin
                tensValue = 3; 
                onesValue = 9;
            end
            40: begin
                tensValue = 4; 
                onesValue = 0;
            end
            41: begin
                tensValue = 4; 
                onesValue = 1;
            end
            42: begin
                tensValue = 4; 
                onesValue = 2;
            end
            43: begin
                tensValue = 4; 
                onesValue = 3;
            end
            44: begin
                tensValue = 4; 
                onesValue = 4;
            end
            45: begin
                tensValue = 4; 
                onesValue = 5;
            end
            46: begin
                tensValue = 4; 
                onesValue = 6;
            end
            47: begin
                tensValue = 4; 
                onesValue = 7;
            end
            48: begin
                tensValue = 4; 
                onesValue = 8;
            end
            49: begin
                tensValue = 4; 
                onesValue = 9;
            end
            50: begin
                tensValue = 5; 
                onesValue = 0;
            end
            51: begin
                tensValue = 5; 
                onesValue = 1;
            end
            52: begin
                tensValue = 5; 
                onesValue = 2;
            end
            53: begin
                tensValue = 5; 
                onesValue = 3;
            end
            54: begin
                tensValue = 5; 
                onesValue = 4;
            end
            55: begin
                tensValue = 5; 
                onesValue = 5;
            end
            56: begin
                tensValue = 5; 
                onesValue = 6;
            end
            57: begin
                tensValue = 5; 
                onesValue = 7;
            end
            58: begin
                tensValue = 5; 
                onesValue = 8;
            end
            59: begin
                tensValue = 5; 
                onesValue = 9;
            end
            default: begin
                tensValue = 0;
                onesValue = 0;
            end
        endcase
    end
endmodule
