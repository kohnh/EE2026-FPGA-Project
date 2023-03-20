`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2023 09:26:36
// Design Name: 
// Module Name: beep_400Hz
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


module beep_400Hz(

     input clock,
    output reg [11:0] signal
    );
    
    always @ (clock) begin
        signal = (clock == 1) ? 12'h800 : 0;
    end
    
endmodule
