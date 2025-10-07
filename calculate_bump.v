`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/03 04:52:17
// Design Name: 
// Module Name: calculate_bump
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


module calculate_bump(
    input clk,
    input rst,
    input [9:0] block_x, block_y,
    input [9:0] doodle_x, doodle_y,
    input [2:0] state,
    input [4:0] speed_y,
    input fly,
    output reg bump,
    output reg [9:0] movement
    );
    parameter block_height = 10'd10;
    parameter block_width = 10'd32;
    parameter doodle_height = 10'd39;
    parameter doodle_width = 10'd39;
    
    always @(*) begin
         if(doodle_y+doodle_height<=block_y && doodle_y+doodle_height+speed_y>block_y && fly==0) begin
            if(doodle_x>=block_x-35 && doodle_x<=block_x+block_width-15)begin
                bump<=1'b1;
                movement<=10'd464-block_y;
            end
            else begin
                bump<=1'b0;
                movement<=10'b0;
            end
        end
        else begin
            bump<=1'b0;
            movement<=10'b0;
        end
    end
    
endmodule
