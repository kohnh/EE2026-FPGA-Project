`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2023 11:38:53
// Design Name: 
// Module Name: maze_logic
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


module maze_logic(
    input clk100M, 
    input [3:0] state,
    input [6:0] oled_x,oled_y,
    input btnU, btnR, btnD, btnL, btnC,
    output reg [15:0] oled_out = 0,
    output [11:0] audio_out
    );

    parameter [3:0] grp_impr = 4'b0010;
    
    wire U, D, L, R, C;
    button_sensor button_U(clk100M, btnU, U);
    button_sensor button_D(clk100M, btnD, D);
    button_sensor button_L(clk100M, btnL, L);
    button_sensor button_R(clk100M, btnR, R);
    button_sensor button_C(clk100M, btnC, C);
    
    wire u, d, l, r, c;
    assign u = (state == grp_impr) ? U : 0;
    assign d = (state == grp_impr) ? D : 0;
    assign l = (state == grp_impr) ? L : 0;
    assign r = (state == grp_impr) ? R : 0;
    assign c = (state == grp_impr) ? C : 0;

    reg [1:0] game_state = 0;
    parameter game_start = 0;
    parameter game_play = 1;
    parameter game_loss = 2;
    parameter game_win = 3;
    
    wire [15:0] end_lose_sc;
    ftb_end_loss_screen endlsc(clk100M,oled_x,oled_y,end_lose_sc);
    wire [15:0] end_win_sc;
    ftb_end_win_screen endwsc(clk100M,oled_x,oled_y,end_win_sc);
    wire [15:0] start_sc;
    ftb_start_screen startsc(clk100M,oled_x,oled_y,start_sc);
    wire [15:0] maze_sc;
    //maze_display instantiate
    
    
    always @ game_state begin
        case (game_state)
            game_start : oled_out <= start_sc;
            game_play : oled_out <= maze_sc;
            game_loss : oled_out <= end_lose_sc;
            game_win : oled_out <= end_win_sc;
        endcase
    end
    
    wire [30:0] walls;
    wire [4:0] position, bomb;
    wire [1:0] random;
    reg start_game;

    clk_random clk_random(clk100M, random);
    maze_generator maze_generator(clk100M, random, start_game, walls, bomb);
    maze_position maze_position(c, d, u, l, r, walls, start_game, position);
    maze_proximity maze_proximity(clk100M, position, bomb, audio_out);

    always @ (posedge c) begin
        case (game_state)
            game_start : begin
                start_game <= 1;
                game_state <= game_play;
            end
            game_play : begin
                start_game <= 0;
                game_state <= (position == bomb) ? game_win : game_loss;
            end
            game_loss : game_state <= game_start;
            game_win : game_state <= game_start;
        endcase
    end

endmodule
