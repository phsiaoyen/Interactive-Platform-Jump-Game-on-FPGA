`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/03 16:55:04
// Design Name: 
// Module Name: doodle_move
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


module doodle_move(
    input clk_22,
    input rst,
    input [2:0] state,
    input left, right,
    input [2:0] bump,
    output reg [9:0] doodle_x,
    output reg [9:0] doodle_y,
    output reg [4:0] speed_y,
    output reg fly,
    output reg invincible,
    output reg hold,
    output reg doodle_right
    );
    
    //state
    parameter WAIT = 3'b000;
    parameter INFORMATION = 3'b001;
    parameter GAME = 3'b010;
    parameter WIN = 3'b011;
    parameter LOSE = 3'b100;
    
    //bump state
    parameter BUMP_NOTHING = 3'b000;
    parameter BUMP_GREEN = 3'b001;
    parameter BUMP_BLUE = 3'b010;
    parameter BUMP_ORANGE = 3'b011;
    parameter BUMP_YELLOW = 3'b100;
    
    //doodle
    parameter doodle_height = 10'd39;
    parameter doodle_width = 10'd39;
    
    //screen
    parameter screen_left_bound = 10'd200;
    parameter screen_right_bound = 10'd440;
    
    reg [9:0] counter, aircraft_counter;
    //counter counts for the time of invincible, aircraft_counter counts for the aircraft and spring 
    reg aircraft;
    reg spring;
    always @(posedge clk_22) begin
        if(rst || state != GAME) begin
            doodle_x<=10'd235;
            doodle_y<=10'd415;
            speed_y<=5'd11;
            fly <= 1'b1;
            hold<=1'b0;
            aircraft<=1'b0;
            aircraft_counter<=10'b0;
            doodle_right<=1'b1;
            invincible<=1'b0;
            counter<=10'b0;
        end
        else begin
            //assign doodle_x
            if(left) begin
                doodle_right<=1'b0;
                if(doodle_x + doodle_width < screen_left_bound) doodle_x <= screen_right_bound - 3'd5;
                else doodle_x <= doodle_x - 3'd5;
            end
            else if (right) begin
                doodle_right<=1'b1;
                if(doodle_x > screen_right_bound) doodle_x <= screen_left_bound-doodle_width + 3'd5;
                else doodle_x <= doodle_x + 3'd5;
            end
            else begin
                doodle_x <= doodle_x;
                doodle_right<=doodle_right;
            end
           //assign doodle_y
            if (bump!=0) begin
                doodle_y <= doodle_y-speed_y;
            end else begin
                if (fly) begin
                    doodle_y <= doodle_y-speed_y;
                end else begin
                    doodle_y <= doodle_y+speed_y;
                end
            end
            
            //assign speed_y
            if(bump == BUMP_YELLOW) begin
                invincible <= 1'b1;
                fly <= 1'b1;
                hold<=1'b0;
                aircraft<=1'b0;
                spring<=1'b0;
                aircraft_counter<=10'b0;
                if(doodle_y>=10'd350)speed_y <= 5'd11;
                else speed_y <= 5'd8;
                counter <= 10'b0;
            end
            else begin
                counter <= counter + 1'b1;
                if (counter >= 10'd300) invincible <= 1'b0;
                else invincible <= invincible;
                
                if(bump == BUMP_BLUE) begin
                    fly <= 1'b1;
                    hold<=1'b0;
                    aircraft<=1'b1;
                    spring<=1'b0;
                    aircraft_counter<=10'b0;
                    if(doodle_y>=10'd420)speed_y <= 5'd24;
                    else if(doodle_y>=10'd390)speed_y <= 5'd22;
                    else if(doodle_y>=10'd355)speed_y <= 5'd20;
                    else if(doodle_y>=10'd320)speed_y <= 5'd18;
                    else if(doodle_y>=10'd250)speed_y <= 5'd16;
                    else speed_y <= 5'd14;
                end
                else begin
                    if(bump == BUMP_ORANGE) begin
                        fly <= 1'b1;
                        hold<=1'b0;
                        aircraft<=1'b0;
                        spring<=1'b1;
                        aircraft_counter<=10'b0;
                        if(doodle_y>=10'd420)speed_y <= 5'd24;
                        else if(doodle_y>=10'd390)speed_y <= 5'd22;
                        else if(doodle_y>=10'd355)speed_y <= 5'd20;
                        else if(doodle_y>=10'd320)speed_y <= 5'd18;
                        else if(doodle_y>=10'd250)speed_y <= 5'd16;
                        else speed_y <= 5'd14;
                    end
                    else begin
                        if(bump == BUMP_GREEN) begin
                            fly <= 1'b1;
                            hold<=1'b0;
                            aircraft<=1'b0;
                            spring<=1'b0;
                            aircraft_counter<=10'b0;
                            if(doodle_y>=10'd350)speed_y <= 5'd11;
                            else speed_y <= 5'd8;
                        end
                        else begin
                            if (fly) begin
                                if (speed_y==5'b0) begin
                                    if(aircraft==1'b1) begin
                                        if(aircraft_counter>=10'd100)begin
                                            fly<=fly;
                                            speed_y<=5'b0;
                                            hold<=1'b0;
                                            aircraft<=1'b0;
                                            spring<=1'b0;
                                            aircraft_counter<=1'b0;
                                        end
                                        else begin
                                            fly<=fly;
                                            speed_y<=5'b0;
                                            hold<=1'b1;
                                            aircraft<=aircraft;
                                            spring<=spring;
                                            aircraft_counter<=aircraft_counter+1'b1;
                                        end
                                    end
                                    else if(spring) begin
                                        if(aircraft_counter>=10'd10)begin
                                            fly<=fly;
                                            speed_y<=5'b0;
                                            hold<=1'b0;
                                            aircraft<=1'b0;
                                            spring<=1'b0;
                                            aircraft_counter<=1'b0;
                                        end
                                        else begin
                                            fly<=fly;
                                            speed_y<=5'b0;
                                            hold<=1'b1;
                                            aircraft<=aircraft;
                                            spring<=spring;
                                            aircraft_counter<=aircraft_counter + 1'b1;
                                        end
                                    end
                                    else begin
                                        fly<=1'b0;
                                        hold<=1'b0;
                                        speed_y <= speed_y + 1'b1;
                                        aircraft<=aircraft;
                                        spring<=spring;
                                        aircraft_counter<=aircraft_counter;
                                    end
                                end
                                else if(doodle_y<=10'd240)begin
                                    if(aircraft) begin
                                        fly<=fly;
                                        hold<=1'b1;
                                        speed_y<=5'b0;
                                        aircraft<=aircraft;
                                        spring<=spring;
                                        aircraft_counter<=10'b0;
                                    end
                                    else if(spring) begin
                                        fly<=fly;
                                        hold<=1'b1;
                                        speed_y<=5'b0;
                                        aircraft<=aircraft;
                                        spring<=spring;
                                        aircraft_counter<=10'b0;
                                    end
                                    else begin
                                        fly<=fly;
                                        hold<=1'b0;
                                        speed_y<=5'b0;
                                        aircraft<=aircraft;
                                        spring<=spring;
                                        aircraft_counter<=aircraft_counter;
                                    end
                                end
                                else begin
                                    fly<=fly;
                                    hold<=1'b0;
                                    speed_y<=speed_y - 1'b1;
                                    aircraft<=aircraft;
                                    spring<=spring;
                                    aircraft_counter<=aircraft_counter;
                                end
                            end
                            else begin
                                fly<=fly;
                                hold<=1'b0;
                                speed_y <= speed_y + 1'b1;
                                aircraft<=aircraft;
                                spring<=spring;
                                aircraft_counter<=aircraft_counter;
                            end
                        end
                    end
                end
            end   
        end
    end
endmodule


