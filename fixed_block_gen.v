`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/03 16:55:04
// Design Name: 
// Module Name: fixed_block_gen
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

module fixed_block_gen(
    input clk,
    input clk_22,
    input rst,
    input [2:0] state,
    input [2:0] bump,
    input [9:0] movement,
    input hold,
    output reg [15:0] score,
    output reg [9:0] fixed_block_x1, fixed_block_x2, fixed_block_x3, fixed_block_x4, fixed_block_x5, fixed_block_x6, fixed_block_x7, fixed_block_x8, fixed_block_x9, fixed_block_x10, fixed_block_x11, fixed_block_x12, fixed_block_x13, fixed_block_x14, fixed_block_x15,
    output reg [9:0] fixed_block_y1, fixed_block_y2, fixed_block_y3, fixed_block_y4, fixed_block_y5, fixed_block_y6, fixed_block_y7, fixed_block_y8, fixed_block_y9, fixed_block_y10, fixed_block_y11, fixed_block_y12, fixed_block_y13, fixed_block_y14, fixed_block_y15
    );
    wire [9:0] next_y1, next_y2, next_y3, next_y4, next_y5, next_y6, next_y7, next_y8, next_y9, next_y10, next_y11, next_y12, next_y13, next_y14, next_y15;
    wire [7:0] next_x1, next_x2, next_x3, next_x4, next_x5, next_x6, next_x7, next_x8, next_x9, next_x10, next_x11, next_x12, next_x13, next_x14, next_x15;

    reg [9:0] movement_record;
    wire [9:0] next_movement_record;
    wire [15:0] next_score;
    
    
    parameter block_height = 10'd10;
    parameter block_width = 10'd32;
    
    //state
    parameter WAIT = 3'b000;
    parameter INFORMATION = 3'b001;
    parameter GAME = 3'b010;
    parameter WIN = 3'b011;
    parameter LOSE = 3'b100;
    
    //screen
    parameter screen_left_bound = 10'd200;
    parameter screen_right_bound = 10'd440;
    parameter block_bound = screen_right_bound - screen_left_bound - block_width;
    
    LFSR L1(.clk(clk), .rst(rst), .initial_value(8'b10110101), .y(next_y1), .state(state), .output_value(next_x1));
    LFSR L2(.clk(clk), .rst(rst), .initial_value(8'b10100010), .y(next_y2), .state(state), .output_value(next_x2));
    LFSR L3(.clk(clk), .rst(rst), .initial_value(8'b00101101), .y(next_y3), .state(state), .output_value(next_x3));
    LFSR L4(.clk(clk), .rst(rst), .initial_value(8'b10111110), .y(next_y4), .state(state), .output_value(next_x4));
    LFSR L5(.clk(clk), .rst(rst), .initial_value(8'b11000001), .y(next_y5), .state(state), .output_value(next_x5));
    LFSR L6(.clk(clk), .rst(rst), .initial_value(8'b00001100), .y(next_y6), .state(state), .output_value(next_x6));
    LFSR L7(.clk(clk), .rst(rst), .initial_value(8'b01111110), .y(next_y7), .state(state), .output_value(next_x7));
    LFSR L8(.clk(clk), .rst(rst), .initial_value(8'b01001101), .y(next_y8), .state(state), .output_value(next_x8));
    LFSR L9(.clk(clk), .rst(rst), .initial_value(8'b11000001), .y(next_y9), .state(state), .output_value(next_x9));
    LFSR L10(.clk(clk), .rst(rst), .initial_value(8'b00110010), .y(next_y10), .state(state), .output_value(next_x10));
    LFSR L11(.clk(clk), .rst(rst), .initial_value(8'b00000001), .y(next_y11), .state(state), .output_value(next_x11));
    LFSR L12(.clk(clk), .rst(rst), .initial_value(8'b00100011), .y(next_y12), .state(state), .output_value(next_x12));
    LFSR L13(.clk(clk), .rst(rst), .initial_value(8'b00110111), .y(next_y13), .state(state), .output_value(next_x13));
    LFSR L14(.clk(clk), .rst(rst), .initial_value(8'b10110010), .y(next_y14), .state(state), .output_value(next_x14));
    LFSR L15(.clk(clk), .rst(rst), .initial_value(8'b01000110), .y(next_y15), .state(state), .output_value(next_x15));
    
    
    always @(posedge clk_22) begin
        if(state!=GAME) begin
            fixed_block_x1 <= next_x1;
            fixed_block_x2 <= next_x2;
            fixed_block_x3 <= next_x3;
            fixed_block_x4 <= next_x4;
            fixed_block_x5 <= next_x5;
            fixed_block_x6 <= next_x6;
            fixed_block_x7 <= next_x7;
            fixed_block_x8 <= next_x8;
            fixed_block_x9 <= next_x9;
            fixed_block_x10 <= next_x10;
            fixed_block_x11 <= next_x11;
            fixed_block_x12 <= next_x12;
            fixed_block_x13 <= next_x13;
            fixed_block_x14 <= next_x14;
            fixed_block_x15 <= next_x15;
        end
        else begin
            if(next_x1>block_bound)fixed_block_x1<=next_x1-block_bound+screen_left_bound;
            else fixed_block_x1<=next_x1+screen_left_bound;
            if(next_x2>block_bound)fixed_block_x2<=next_x2-block_bound+screen_left_bound;
            else fixed_block_x2<=next_x2+screen_left_bound;
            if(next_x3>block_bound)fixed_block_x3<=next_x3-block_bound+screen_left_bound;
            else fixed_block_x3<=next_x3+screen_left_bound;
            if(next_x4>block_bound)fixed_block_x4<=next_x4-block_bound+screen_left_bound;
            else fixed_block_x4<=next_x4+screen_left_bound;
            if(next_x5>block_bound)fixed_block_x5<=next_x5-block_bound+screen_left_bound;
            else fixed_block_x5<=next_x5+screen_left_bound;
            if(next_x6>block_bound)fixed_block_x6<=next_x6-block_bound+screen_left_bound;
            else fixed_block_x6<=next_x6+screen_left_bound;
            if(next_x7>block_bound)fixed_block_x7<=next_x7-block_bound+screen_left_bound;
            else fixed_block_x7<=next_x7+screen_left_bound;
            if(next_x8>block_bound)fixed_block_x8<=next_x8-block_bound+screen_left_bound;
            else fixed_block_x8<=next_x8+screen_left_bound;
            if(next_x9>block_bound)fixed_block_x9<=next_x9-block_bound+screen_left_bound;
            else fixed_block_x9<=next_x9+screen_left_bound;
            if(next_x10>block_bound)fixed_block_x10<=next_x10-block_bound+screen_left_bound;
            else fixed_block_x10<=next_x10+screen_left_bound;
            if(next_x11>block_bound)fixed_block_x11<=next_x11-block_bound+screen_left_bound;
            else fixed_block_x11<=next_x11+screen_left_bound;
            if(next_x12>block_bound)fixed_block_x12<=next_x12-block_bound+screen_left_bound;
            else fixed_block_x12<=next_x12+screen_left_bound;
            if(next_x13>block_bound)fixed_block_x13<=next_x13-block_bound+screen_left_bound;
            else fixed_block_x13<=next_x13+screen_left_bound;
            if(next_x14>block_bound)fixed_block_x14<=next_x14-block_bound+screen_left_bound;
            else fixed_block_x14<=next_x14+screen_left_bound;
            if(next_x15>block_bound)fixed_block_x15<=next_x15-block_bound+screen_left_bound;
            else fixed_block_x15<=next_x15+screen_left_bound;
        end
    end
    
    always @(posedge clk_22) begin
        if(state==WAIT||state==INFORMATION) begin
            movement_record<=10'd0;
            score<=16'd0;
            fixed_block_y1 <= 10'd16;
            fixed_block_y2 <= 10'd48;
            fixed_block_y3 <= 10'd80;
            fixed_block_y4 <= 10'd112;
            fixed_block_y5 <= 10'd144;
            fixed_block_y6 <= 10'd176;
            fixed_block_y7 <= 10'd208;
            fixed_block_y8 <= 10'd240;
            fixed_block_y9 <= 10'd272;
            fixed_block_y10 <= 10'd304;
            fixed_block_y11 <= 10'd336;
            fixed_block_y12 <= 10'd368;
            fixed_block_y13 <= 10'd400;
            fixed_block_y14 <= 10'd432;
            fixed_block_y15 <= 10'd464;
        end
        else begin
            if(bump!=0) begin
                movement_record<=movement;
            end
            else begin
                movement_record<=next_movement_record;
            end
            score<=next_score;
            if(next_y1>10'd480) fixed_block_y1<=next_y1-10'd480;
            else fixed_block_y1<=next_y1;
            if(next_y2>10'd480) fixed_block_y2<=next_y2-10'd480;
            else fixed_block_y2<=next_y2;
            if(next_y3>10'd480) fixed_block_y3<=next_y3-10'd480;
            else fixed_block_y3<=next_y3;
            if(next_y4>10'd480) fixed_block_y4<=next_y4-10'd480;
            else fixed_block_y4<=next_y4;
            if(next_y5>10'd480) fixed_block_y5<=next_y5-10'd480;
            else fixed_block_y5<=next_y5;
            if(next_y6>10'd480) fixed_block_y6<=next_y6-10'd480;
            else fixed_block_y6<=next_y6;
            if(next_y7>10'd480) fixed_block_y7<=next_y7-10'd480;
            else fixed_block_y7<=next_y7;
            if(next_y8>10'd480) fixed_block_y8<=next_y8-10'd480;
            else fixed_block_y8<=next_y8;
            if(next_y9>10'd480) fixed_block_y9<=next_y9-10'd480;
            else fixed_block_y9<=next_y9;
            if(next_y10>10'd480) fixed_block_y10<=next_y10-10'd480;
            else fixed_block_y10<=next_y10;
            if(next_y11>10'd480) fixed_block_y11<=next_y11-10'd480;
            else fixed_block_y11<=next_y11;
            if(next_y12>10'd480) fixed_block_y12<=next_y12-10'd480;
            else fixed_block_y12<=next_y12;
            if(next_y13>10'd480) fixed_block_y13<=next_y13-10'd480;
            else fixed_block_y13<=next_y13;
            if(next_y14>10'd480) fixed_block_y14<=next_y14-10'd480;
            else fixed_block_y14<=next_y14;
            if(next_y15>10'd480) fixed_block_y15<=next_y15-10'd480;
            else fixed_block_y15<=next_y15;
        end
    end
    parameter scroll_speed = 10'd32;
    assign next_y1=(movement_record>=scroll_speed||hold)?(fixed_block_y1+scroll_speed):(fixed_block_y1+movement_record);
    assign next_y2=(movement_record>=scroll_speed||hold)?(fixed_block_y2+scroll_speed):(fixed_block_y2+movement_record);
    assign next_y3=(movement_record>=scroll_speed||hold)?(fixed_block_y3+scroll_speed):(fixed_block_y3+movement_record);
    assign next_y4=(movement_record>=scroll_speed||hold)?(fixed_block_y4+scroll_speed):(fixed_block_y4+movement_record);
    assign next_y5=(movement_record>=scroll_speed||hold)?(fixed_block_y5+scroll_speed):(fixed_block_y5+movement_record);
    assign next_y6=(movement_record>=scroll_speed||hold)?(fixed_block_y6+scroll_speed):(fixed_block_y6+movement_record);
    assign next_y7=(movement_record>=scroll_speed||hold)?(fixed_block_y7+scroll_speed):(fixed_block_y7+movement_record);
    assign next_y8=(movement_record>=scroll_speed||hold)?(fixed_block_y8+scroll_speed):(fixed_block_y8+movement_record);
    assign next_y9=(movement_record>=scroll_speed||hold)?(fixed_block_y9+scroll_speed):(fixed_block_y9+movement_record);
    assign next_y10=(movement_record>=scroll_speed||hold)?(fixed_block_y10+scroll_speed):(fixed_block_y10+movement_record);
    assign next_y11=(movement_record>=scroll_speed||hold)?(fixed_block_y11+scroll_speed):(fixed_block_y11+movement_record);
    assign next_y12=(movement_record>=scroll_speed||hold)?(fixed_block_y12+scroll_speed):(fixed_block_y12+movement_record);
    assign next_y13=(movement_record>=scroll_speed||hold)?(fixed_block_y13+scroll_speed):(fixed_block_y13+movement_record);
    assign next_y14=(movement_record>=scroll_speed||hold)?(fixed_block_y14+scroll_speed):(fixed_block_y14+movement_record);
    assign next_y15=(movement_record>=scroll_speed||hold)?(fixed_block_y15+scroll_speed):(fixed_block_y15+movement_record);
    assign next_movement_record=(movement_record>=scroll_speed)?movement_record-scroll_speed: 10'd0;
    assign next_score=(movement_record>=scroll_speed||hold)?score+1'b1:score;
endmodule

module LFSR(
    input clk,
    input rst,
    input [7:0] initial_value,
    input [9:0] y,
    input [2:0] state,
    output reg [7:0] output_value
);   
    //state
    parameter WAIT = 3'b000;
    parameter INFORMATION = 3'b001;
    parameter GAME = 3'b010;
    parameter WIN = 3'b011;
    parameter LOSE = 3'b100;
    
    always @(posedge clk) begin
        if(state!=GAME) begin
            output_value <= initial_value;
        end
        else begin
            if(y > 480) output_value <= {output_value[6:0], output_value[7]^output_value[5]^output_value[4]};
            else output_value <= output_value;
        end
    end
 
endmodule

