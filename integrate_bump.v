`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/04 19:48:34
// Design Name: 
// Module Name: integrate_bump
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

module integrate_bump(
        input clk,
        input rst,
        input [9:0] fixed_block_x1, fixed_block_x2, fixed_block_x3, fixed_block_x4, fixed_block_x5, fixed_block_x6, fixed_block_x7, fixed_block_x8, fixed_block_x9, fixed_block_x10, fixed_block_x11, fixed_block_x12, fixed_block_x13, fixed_block_x14, fixed_block_x15,
        input [9:0] fixed_block_y1, fixed_block_y2, fixed_block_y3, fixed_block_y4, fixed_block_y5, fixed_block_y6, fixed_block_y7, fixed_block_y8, fixed_block_y9, fixed_block_y10, fixed_block_y11, fixed_block_y12, fixed_block_y13, fixed_block_y14, fixed_block_y15, 
        input [9:0] doodle_x, doodle_y,
        input [2:0] state,
        input [4:0] speed_y,
        input fly,
        input invincible,
        output reg [2:0] bump,
        output reg [9:0] movement
    );
    wire bump_1, bump_2, bump_3, bump_4, bump_5, bump_6, bump_7, bump_8, bump_9, bump_10, bump_11, bump_12, bump_13, bump_14, bump_15;
    wire [9:0] movement_1, movement_2, movement_3, movement_4, movement_5, movement_6, movement_7, movement_8, movement_9, movement_10, movement_11, movement_12, movement_13, movement_14, movement_15;

    //bump state
    parameter BUMP_NOTHING = 3'b000;
    parameter BUMP_GREEN = 3'b001;
    parameter BUMP_BLUE = 3'b010;
    parameter BUMP_ORANGE = 3'b011;
    parameter BUMP_YELLOW = 3'b100;
    calculate_bump CB1(
    .clk(clk),
    .rst(rst),
    .block_x(fixed_block_x1), .block_y(fixed_block_y1),
    .doodle_x(doodle_x), .doodle_y(doodle_y),
    .speed_y(speed_y),
    .fly(fly),
    .bump(bump_1),
    .movement(movement_1),
    .state(state)
    );
    
    calculate_bump CB2(
    .clk(clk),
    .rst(rst),
    .block_x(fixed_block_x2), .block_y(fixed_block_y2),
    .doodle_x(doodle_x), .doodle_y(doodle_y),
    .speed_y(speed_y),
    .fly(fly),
    .bump(bump_2),
    .movement(movement_2),
    .state(state)
    );
    
    calculate_bump CB3(
    .clk(clk),
    .rst(rst),
    .block_x(fixed_block_x3), .block_y(fixed_block_y3),
    .doodle_x(doodle_x), .doodle_y(doodle_y),
    .speed_y(speed_y),
    .fly(fly),
    .bump(bump_3),
    .movement(movement_3),
    .state(state)
    );
    
    calculate_bump CB4(
    .clk(clk),
    .rst(rst),
    .block_x(fixed_block_x4), .block_y(fixed_block_y4),
    .doodle_x(doodle_x), .doodle_y(doodle_y),
    .speed_y(speed_y),
    .fly(fly),
    .bump(bump_4),
    .movement(movement_4),
    .state(state)
    );
    
    calculate_bump CB5(
    .clk(clk),
    .rst(rst),
    .block_x(fixed_block_x5), .block_y(fixed_block_y5),
    .doodle_x(doodle_x), .doodle_y(doodle_y),
    .speed_y(speed_y),
    .fly(fly),
    .bump(bump_5),
    .movement(movement_5),
    .state(state)
    );
    
    calculate_bump CB6(
    .clk(clk),
    .rst(rst),
    .block_x(fixed_block_x6), .block_y(fixed_block_y6),
    .doodle_x(doodle_x), .doodle_y(doodle_y),
    .speed_y(speed_y),
    .fly(fly),
    .bump(bump_6),
    .movement(movement_6),
    .state(state)
    );
    
    calculate_bump CB7(
    .clk(clk),
    .rst(rst),
    .block_x(fixed_block_x7), .block_y(fixed_block_y7),
    .doodle_x(doodle_x), .doodle_y(doodle_y),
    .speed_y(speed_y),
    .fly(fly),
    .bump(bump_7),
    .movement(movement_7),
    .state(state)
    );
    
    calculate_bump CB8(
    .clk(clk),
    .rst(rst),
    .block_x(fixed_block_x8), .block_y(fixed_block_y8),
    .doodle_x(doodle_x), .doodle_y(doodle_y),
    .speed_y(speed_y),
    .fly(fly),
    .bump(bump_8),
    .movement(movement_8),
    .state(state)
    );
    
    calculate_bump CB9(
    .clk(clk),
    .rst(rst),
    .block_x(fixed_block_x9), .block_y(fixed_block_y9),
    .doodle_x(doodle_x), .doodle_y(doodle_y),
    .speed_y(speed_y),
    .fly(fly),
    .bump(bump_9),
    .movement(movement_9),
    .state(state)
    );
    
    calculate_bump CB10(
    .clk(clk),
    .rst(rst),
    .block_x(fixed_block_x10), .block_y(fixed_block_y10),
    .doodle_x(doodle_x), .doodle_y(doodle_y),
    .speed_y(speed_y),
    .fly(fly),
    .bump(bump_10),
    .movement(movement_10),
    .state(state)
    );
    
    calculate_bump CB11(
    .clk(clk),
    .rst(rst),
    .block_x(fixed_block_x11), .block_y(fixed_block_y11),
    .doodle_x(doodle_x), .doodle_y(doodle_y),
    .speed_y(speed_y),
    .fly(fly),
    .bump(bump_11),
    .movement(movement_11),
    .state(state)
    );
    
    calculate_bump CB12(
    .clk(clk),
    .rst(rst),
    .block_x(fixed_block_x12), .block_y(fixed_block_y12),
    .doodle_x(doodle_x), .doodle_y(doodle_y),
    .speed_y(speed_y),
    .fly(fly),
    .bump(bump_12),
    .movement(movement_12),
    .state(state)
    );
    
    calculate_bump CB13(
    .clk(clk),
    .rst(rst),
    .block_x(fixed_block_x13), .block_y(fixed_block_y13),
    .doodle_x(doodle_x), .doodle_y(doodle_y),
    .speed_y(speed_y),
    .fly(fly),
    .bump(bump_13),
    .movement(movement_13),
    .state(state)
    );
    
    calculate_bump CB14(
    .clk(clk),
    .rst(rst),
    .block_x(fixed_block_x14), .block_y(fixed_block_y14),
    .doodle_x(doodle_x), .doodle_y(doodle_y),
    .speed_y(speed_y),
    .fly(fly),
    .bump(bump_14),
    .movement(movement_14),
    .state(state)
    );
    
    calculate_bump CB15(
    .clk(clk),
    .rst(rst),
    .block_x(fixed_block_x15), .block_y(fixed_block_y15),
    .doodle_x(doodle_x), .doodle_y(doodle_y),
    .speed_y(speed_y),
    .fly(fly),
    .bump(bump_15),
    .movement(movement_15),
    .state(state)
    );
    
    always @(*) begin
        if((bump_1 || bump_5) || (bump_8 || bump_10) || (bump_11 || bump_12) || (bump_13 || bump_14) || bump_15) begin
            bump = BUMP_GREEN;
            movement = movement_1+movement_5+movement_8+movement_10+movement_11+movement_12+movement_13+movement_14+movement_15;
        end
        else begin
            if(bump_2 || bump_7) begin
                if(invincible) begin
                    bump = BUMP_GREEN;
                    movement=movement_2+movement_7;
                end
                else begin
                    bump = BUMP_NOTHING;
                    movement=10'b0;
                end
            end
            else begin
                if(bump_3) begin
                    bump = BUMP_BLUE;
                    movement=movement_3;
                end
                else begin
                    if(bump_6) begin
                        bump = BUMP_YELLOW;
                        movement=movement_6;
                    end
                    else begin
                        if(bump_4 || bump_9) begin
                            bump = BUMP_ORANGE;
                            movement=movement_4+movement_9;
                        end
                        else begin
                            bump = BUMP_NOTHING;
                            movement=10'b0;
                        end
                    end
                end
            end
        end
    end
    
endmodule

