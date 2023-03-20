`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2023 16:41:31
// Design Name: 
// Module Name: Update_display
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Update_display (
    input [3:0] volume_level,
    output reg [8:0] led = 9'b000000000,
    output reg [3:0] an = 4'b1111,
    output reg [6:0] seg = 7'b1111111
    );
    always @ (*)
    begin
        if(volume_level == 0) //volume level 0    
        begin
            led <= 9'b000000000; 
            an <= 4'b1111;
            seg <= 7'b1111111;
        end
        if(volume_level == 1) //volume level 1, display '1' on 7 segment display
        begin
            led <= 9'b000000001;
            an <= 4'b1110;  
            seg <= 7'b1001111;
        end
        if(volume_level == 2) //volume level 2    
        begin
            led <= 9'b000000011;
             an <= 4'b1110;
             seg <= 7'b0100100;
        end
        if(volume_level == 3) //volume level 3    
        begin
            led <= 9'b000000111;
             an <= 4'b1110;
             seg <= 7'b0110000;
        end
        if(volume_level == 4) //volume level 4
        begin
            led <= 9'b000001111;
             an <= 4'b1110;
             seg <= 7'b1100110;
        end  
        if(volume_level == 5) //volume level 5
        begin
            led <= 9'b000011111;
             an <= 4'b1110;
             seg <= 7'b0010010;
        end  
        if(volume_level == 6) //volume level 6  
        begin
            led <= 9'b000111111;
             an <= 4'b1110;
             seg <= 7'b1111101; 
        end  
        if(volume_level == 7) //volume level 7
        begin
           led <= 9'b001111111;
            an <= 4'b1110;
            seg <= 7'b1111000;
        end  
        if(volume_level == 8) //volume level 8 
        begin
            led <= 9'b011111111;
             an <= 4'b1110;
             seg <= 7'b0000000;
        end  
        if(volume_level == 9) //volume level 9
        begin
            led <= 9'b111111111;
             an <= 4'b1110;
             seg <= 7'b0001000;
        end  
    end
endmodule
