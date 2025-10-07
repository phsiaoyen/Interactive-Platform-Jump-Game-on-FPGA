`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/02 21:19:31
// Design Name: 
// Module Name: pixel_gen
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


module pixel_gen(
    input clk, //clk22
    input rst,
    input [2:0] state,
    input [9:0] fixed_block_x1, fixed_block_x2, fixed_block_x3, fixed_block_x4, fixed_block_x5, fixed_block_x6, fixed_block_x7, fixed_block_x8, fixed_block_x9, fixed_block_x10, fixed_block_x11, fixed_block_x12, fixed_block_x13, fixed_block_x14, fixed_block_x15,
    input [9:0] fixed_block_y1, fixed_block_y2, fixed_block_y3, fixed_block_y4, fixed_block_y5, fixed_block_y6, fixed_block_y7, fixed_block_y8, fixed_block_y9, fixed_block_y10, fixed_block_y11, fixed_block_y12, fixed_block_y13, fixed_block_y14, fixed_block_y15,
    input [9:0] doodle_x,
    input [9:0] doodle_y,
    input [9:0] v_cnt,
    input [9:0] h_cnt,
    input invincible,
    input doodle_right,
    output reg detect_doodle,
    output reg [2:0] detect,
    output reg [16:0] pixel_addr
    );
    
    parameter block_height = 10'd10;
    parameter block_width = 10'd32;
    parameter doodle_height = 10'd39;
    parameter doodle_width = 10'd39;
    parameter screen_left_bound = 10'd200;
    parameter screen_right_bound = 10'd440;
    reg [16:0] next_pixel_addr;
    parameter pic_width = 10'd480;
    
    //state
    parameter WAIT = 3'b000;
    parameter INFORMATION = 3'b001;
    parameter GAME = 3'b010;
    parameter WIN = 3'b011;
    parameter LOSE = 3'b100;
    
    always @(posedge clk) begin
        if(rst||state!=GAME) begin
            detect <= 3'd5;
        end
        else begin
            if(v_cnt >= fixed_block_y1 && v_cnt <= fixed_block_y1 + block_height && h_cnt >= fixed_block_x1 && h_cnt <= fixed_block_x1 + block_width) begin
                detect<= 3'd3;
            end
            else if(v_cnt >= fixed_block_y2 && v_cnt <= fixed_block_y2 + block_height && h_cnt >= fixed_block_x2 && h_cnt <= fixed_block_x2 + block_width) begin
                detect<= 3'd4;
            end
            else if(v_cnt >= fixed_block_y3 && v_cnt <= fixed_block_y3 + block_height && h_cnt >= fixed_block_x3 && h_cnt <= fixed_block_x3 + block_width) begin
                detect<= 3'd0;
            end
            else if(v_cnt >= fixed_block_y4 && v_cnt <= fixed_block_y4 + block_height && h_cnt >= fixed_block_x4 && h_cnt <= fixed_block_x4 + block_width) begin
                detect<= 3'd1;
            end
            else if(v_cnt >= fixed_block_y5 && v_cnt <= fixed_block_y5 + block_height && h_cnt >= fixed_block_x5 && h_cnt <= fixed_block_x5 + block_width) begin
                detect<= 3'd3;
            end
            else if(v_cnt >= fixed_block_y6 && v_cnt <= fixed_block_y6 + block_height && h_cnt >= fixed_block_x6 && h_cnt <= fixed_block_x6 + block_width) begin
                detect<= 3'd2;
            end
            else if(v_cnt >= fixed_block_y7 && v_cnt <= fixed_block_y7 + block_height && h_cnt >= fixed_block_x7 && h_cnt <= fixed_block_x7 + block_width) begin
                detect<= 3'd4;
            end
            else if(v_cnt >= fixed_block_y8 && v_cnt <= fixed_block_y8 + block_height && h_cnt >= fixed_block_x8 && h_cnt <= fixed_block_x8 + block_width) begin
                detect<= 3'd3;
            end
            else if(v_cnt >= fixed_block_y9 && v_cnt <= fixed_block_y9 + block_height && h_cnt >= fixed_block_x9 && h_cnt <= fixed_block_x9 + block_width) begin
                detect<= 3'd1;
            end
            else if(v_cnt >= fixed_block_y10 && v_cnt <= fixed_block_y10 + block_height && h_cnt >= fixed_block_x10 && h_cnt <= fixed_block_x10 + block_width) begin
                detect<= 3'd3;
            end
            else if(v_cnt >= fixed_block_y11 && v_cnt <= fixed_block_y11 + block_height && h_cnt >= fixed_block_x11 && h_cnt <= fixed_block_x11 + block_width) begin
                detect<= 3'd3;
            end
            else if(v_cnt >= fixed_block_y12 && v_cnt <= fixed_block_y12 + block_height && h_cnt >= fixed_block_x12 && h_cnt <= fixed_block_x12 + block_width) begin
                detect<= 3'd3;
            end
            else if(v_cnt >= fixed_block_y13 && v_cnt <= fixed_block_y13 + block_height && h_cnt >= fixed_block_x13 && h_cnt <= fixed_block_x13 + block_width) begin
                detect<= 3'd3;
            end
            else if(v_cnt >= fixed_block_y14 && v_cnt <= fixed_block_y14 + block_height && h_cnt >= fixed_block_x14 && h_cnt <= fixed_block_x14 + block_width) begin
                detect<= 3'd3;
            end
            else if(v_cnt >= fixed_block_y15 && v_cnt <= fixed_block_y15 + block_height && h_cnt >= fixed_block_x15 && h_cnt <= fixed_block_x15 + block_width) begin
                detect<= 3'd3;
            end
            else begin
                detect <= 3'd5;
            end
        end
    end
    
    always @(posedge clk)begin
        if(state==WAIT) begin
            if(v_cnt >= 100 && v_cnt < 139 && h_cnt >= 230 && h_cnt < 410) begin
                pixel_addr<=(h_cnt - 229) + (v_cnt-100)* pic_width+120;
                detect_doodle<= 1'b1;
            end
            else if(v_cnt >= 368 && v_cnt < 402 && h_cnt >= 230 && h_cnt < 410) begin
                pixel_addr<=(h_cnt - 230) + (v_cnt-368)* pic_width +300;
                detect_doodle<= 1'b1;
            end
            else if(h_cnt >= screen_left_bound && h_cnt <= screen_right_bound) begin
                pixel_addr <= 17'd62400;//black
                detect_doodle<= 1'b0;
            end
            else begin
                pixel_addr <= 17'd115200;//background color
                detect_doodle<= 1'b0;
            end
        end
        else if(state==INFORMATION) begin
            if(v_cnt >= 220 && v_cnt < 378 && h_cnt >= 230 && h_cnt < 410) begin
                pixel_addr<=(h_cnt - 229)+120 + (v_cnt-220)* pic_width + 40*pic_width;
                detect_doodle<= 1'b1;
            end
            else if(v_cnt >= 100 && v_cnt < 139 && h_cnt >= 230 && h_cnt < 350)begin //"Information"
                pixel_addr<=(h_cnt - 230)+300 + (v_cnt-100+1)* pic_width + 110 * pic_width;
                detect_doodle<= 1'b1;
            end
            else if(v_cnt >= 400 && v_cnt < 439 && h_cnt >= 230 && h_cnt < 410)begin
                pixel_addr<=(h_cnt - 229)+300 + (v_cnt-400+3)* pic_width + 150 * pic_width-2;
                detect_doodle<= 1'b1;
            end
            else if(h_cnt >= screen_left_bound && h_cnt <= screen_right_bound) begin
                pixel_addr <= 17'd62400;
                detect_doodle<= 1'b0;
            end
            else pixel_addr <= 17'd115200;
        end
        else if(state==WIN) begin
            if(v_cnt >= 220 && v_cnt < 260 && h_cnt >= 230 && h_cnt < 410) begin
                pixel_addr<=(h_cnt - 230) + (v_cnt-220)* pic_width+300+pic_width*34;
                detect_doodle<= 1'b1;
            end
            else if(h_cnt >= screen_left_bound && h_cnt <= screen_right_bound) begin
                pixel_addr <= 17'd62400;
                detect_doodle<= 1'b0;
            end
            else begin
                pixel_addr <= 17'd115200;
                detect_doodle<= 1'b0;
            end
        end
        else if(state==LOSE) begin
            if(v_cnt >= 220 && v_cnt < 260 && h_cnt >= 230 && h_cnt < 410) begin
                pixel_addr<=(h_cnt - 230) + (v_cnt-220)* pic_width+300+pic_width*73;
                detect_doodle<= 1'b1;
            end
            else if(h_cnt >= screen_left_bound && h_cnt <= screen_right_bound) begin
                pixel_addr <= 17'd62400;
                detect_doodle<= 1'b0;
            end
            else begin
                pixel_addr <= 17'd115200;
                detect_doodle<= 1'b0;
            end
        end
        else begin
            if(h_cnt<screen_left_bound||h_cnt>screen_right_bound) begin
                detect_doodle<= 1'b0;
                pixel_addr <= 17'd115200;//black
            end
            else begin
                if(v_cnt >= doodle_y && v_cnt < doodle_y + doodle_height && h_cnt >= doodle_x && h_cnt < doodle_x + doodle_width) begin
                    detect_doodle<= 1'b1;
                    if(!invincible)begin
                        if(doodle_right) pixel_addr <= (h_cnt - doodle_x) + (v_cnt - doodle_y) * pic_width + pic_width*12*5;
                        else pixel_addr <= (h_cnt - doodle_x) + (v_cnt - doodle_y) * pic_width + pic_width*12*5 + doodle_width*2;
                    end
                    else begin
                        if(doodle_right) pixel_addr <= (h_cnt - doodle_x) + (v_cnt - doodle_y) * pic_width + pic_width*12*5 + doodle_width;
                        else pixel_addr <= (h_cnt - doodle_x) + (v_cnt - doodle_y) * pic_width + pic_width*(12*5-doodle_height) + doodle_width+1;
                    end
                end
                else begin
                    detect_doodle<= 1'b0;
                    if(v_cnt >= fixed_block_y1 && v_cnt <= fixed_block_y1 + block_height && h_cnt >= fixed_block_x1 && h_cnt <= fixed_block_x1 + block_width) begin
                        pixel_addr <= (h_cnt - fixed_block_x1) + (v_cnt - fixed_block_y1) * pic_width + pic_width*12*3;//green
                    end
                    else if(v_cnt >= fixed_block_y2 && v_cnt <= fixed_block_y2 + block_height && h_cnt >= fixed_block_x2 && h_cnt <= fixed_block_x2 + block_width) begin
                        pixel_addr <= (h_cnt - fixed_block_x2) + (v_cnt - fixed_block_y2) * pic_width + pic_width*12*4;//brown
                    end
                    else if(v_cnt >= fixed_block_y3 && v_cnt <= fixed_block_y3 + block_height && h_cnt >= fixed_block_x3 && h_cnt <= fixed_block_x3 + block_width) begin
                        pixel_addr <= (h_cnt - fixed_block_x3) + (v_cnt - fixed_block_y3) * pic_width + pic_width*12*0;//blue
                    end
                    else if(v_cnt >= fixed_block_y4 && v_cnt <= fixed_block_y4 + block_height && h_cnt >= fixed_block_x4 && h_cnt <= fixed_block_x4 + block_width) begin
                        pixel_addr <= (h_cnt - fixed_block_x4) + (v_cnt - fixed_block_y4) * pic_width + pic_width*12*1;//orange
                    end
                    else if(v_cnt >= fixed_block_y5 && v_cnt <= fixed_block_y5 + block_height && h_cnt >= fixed_block_x5 && h_cnt <= fixed_block_x5 + block_width) begin
                        pixel_addr <= (h_cnt - fixed_block_x5) + (v_cnt - fixed_block_y5) * pic_width + pic_width*12*3;//green
                    end
                    else if(v_cnt >= fixed_block_y6 && v_cnt <= fixed_block_y6 + block_height && h_cnt >= fixed_block_x6 && h_cnt <= fixed_block_x6 + block_width) begin
                        pixel_addr <= (h_cnt - fixed_block_x6) + (v_cnt - fixed_block_y6) * pic_width + pic_width*12*2;//yellow
                    end
                    else if(v_cnt >= fixed_block_y7 && v_cnt <= fixed_block_y7 + block_height && h_cnt >= fixed_block_x7 && h_cnt <= fixed_block_x7 + block_width) begin
                        pixel_addr <= (h_cnt - fixed_block_x7) + (v_cnt - fixed_block_y7) * pic_width + pic_width*12*4;//brown
                    end
                    else if(v_cnt >= fixed_block_y8 && v_cnt <= fixed_block_y8 + block_height && h_cnt >= fixed_block_x8 && h_cnt <= fixed_block_x8 + block_width) begin
                        pixel_addr <= (h_cnt - fixed_block_x8) + (v_cnt - fixed_block_y8) * pic_width + pic_width*12*3;//green
                    end
                    else if(v_cnt >= fixed_block_y9 && v_cnt <= fixed_block_y9 + block_height && h_cnt >= fixed_block_x9 && h_cnt <= fixed_block_x9 + block_width) begin
                        pixel_addr <= (h_cnt - fixed_block_x9) + (v_cnt - fixed_block_y9) * pic_width + pic_width*12*1;//orange
                    end
                    else if(v_cnt >= fixed_block_y10 && v_cnt <= fixed_block_y10 + block_height && h_cnt >= fixed_block_x10 && h_cnt <= fixed_block_x10 + block_width) begin
                        pixel_addr <= (h_cnt - fixed_block_x10) + (v_cnt - fixed_block_y10) * pic_width + pic_width*12*3;//green
                    end
                    else if(v_cnt >= fixed_block_y11 && v_cnt <= fixed_block_y11 + block_height && h_cnt >= fixed_block_x11 && h_cnt <= fixed_block_x11 + block_width) begin
                        pixel_addr <= (h_cnt - fixed_block_x11) + (v_cnt - fixed_block_y11) * pic_width + pic_width*12*3;//green
                    end
                    else if(v_cnt >= fixed_block_y12 && v_cnt <= fixed_block_y12 + block_height && h_cnt >= fixed_block_x12 && h_cnt <= fixed_block_x12 + block_width) begin
                        pixel_addr <= (h_cnt - fixed_block_x12) + (v_cnt - fixed_block_y12) * pic_width + pic_width*12*3;//green
                    end
                    else if(v_cnt >= fixed_block_y13 && v_cnt <= fixed_block_y13 + block_height && h_cnt >= fixed_block_x13 && h_cnt <= fixed_block_x13 + block_width) begin
                        pixel_addr <= (h_cnt - fixed_block_x13) + (v_cnt - fixed_block_y13) * pic_width + pic_width*12*3;//green
                    end
                    else if(v_cnt >= fixed_block_y14 && v_cnt <= fixed_block_y14 + block_height && h_cnt >= fixed_block_x14 && h_cnt <= fixed_block_x14 + block_width) begin
                        pixel_addr <= (h_cnt - fixed_block_x14) + (v_cnt - fixed_block_y14) * pic_width + pic_width*12*3;//green
                    end
                    else if(v_cnt >= fixed_block_y15 && v_cnt <= fixed_block_y15 + block_height && h_cnt >= fixed_block_x15 && h_cnt <= fixed_block_x15 + block_width) begin
                        pixel_addr <= (h_cnt - fixed_block_x15) + (v_cnt - fixed_block_y15) * pic_width + pic_width*12*3;//green
                    end
                    else begin
                        pixel_addr <= 17'd62400;//background color
                    end
                end
            end
        end
    end
endmodule
