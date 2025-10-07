`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/04 15:52:01
// Design Name: 
// Module Name: Keyboard_controller
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


module Keyboard_Controller(
    input clk,
    inout PS2_CLK,
    inout PS2_DATA,
    output reg RST_N, ENTER, BACKSPACE, SHIFT,
    output [511:0] key_down
    );
    parameter [8:0] KEY_CODES_A = 9'b0_0001_1100; //1C
    parameter [8:0] KEY_CODES_D = 9'b0_0010_0011; //23
    parameter [8:0] KEY_CODES_ESC = 9'b0_0111_0110; //76
    parameter [8:0] KEY_CODES_ENTER = 9'b0_0101_1010; //5A
    parameter [8:0] KEY_CODES_BACKSPACE = 9'b0_0110_0110; //66
    parameter [8:0] KEY_CODES_SHIFT = 9'b0_0101_1001; //59
    
    reg [15:0] nums, next_nums;
    reg [2:0] key_num;
    reg [9:0] last_key;
    
    wire [8:0] last_change;
    wire been_ready;
    
    
    reg rst_n, enter, backspace, shift;
    
    KeyboardDecoder key_de (
            .key_down(key_down),
            .last_change(last_change),
            .key_valid(been_ready),
            .PS2_DATA(PS2_DATA),
            .PS2_CLK(PS2_CLK),
            .rst(0),
            .clk(clk)
        );
    
    always @(posedge clk) begin
        RST_N<=rst_n;
        ENTER<=enter;
        BACKSPACE<=backspace;
        SHIFT<=shift;
    end
    always @(*) begin
        if (been_ready&&key_down[last_change]==1'b1) begin
            if(key_num==3'd1)begin
                rst_n=1'b1;
                enter<=1'b0;
                backspace<=1'b0;
                shift<=1'b0;
            end
            else if(key_num==3'd2)begin
                rst_n=1'b0;
                enter<=1'b1;
                backspace<=1'b0;
                shift<=1'b0;
            end
            else if(key_num==3'd3)begin
                rst_n=1'b0;
                enter<=1'b0;
                backspace<=1'b1;
                shift<=1'b0;
            end
            else if(key_num==3'd4)begin
                rst_n=1'b0;
                enter<=1'b0;
                backspace<=1'b0;
                shift<=1'b1;
            end
            else begin
                rst_n=1'b0;
                enter<=1'b0;
                backspace<=1'b0;
                shift<=1'b0;
            end
        end
        else begin
            rst_n=1'b0;
            enter<=1'b0;
            backspace<=1'b0;
            shift<=1'b0;
        end
    end
    
    always @ (*) begin
        if(last_change == KEY_CODES_ESC) begin
            key_num=3'd1;
        end 
        else if(last_change == KEY_CODES_ENTER) begin
            key_num=3'd2;
        end
        else if(last_change == KEY_CODES_BACKSPACE) begin
            key_num=3'd3;
        end
        else if(last_change == KEY_CODES_SHIFT) begin
            key_num=3'd4;
        end
        else begin
            key_num=3'd0;
        end
    end
endmodule

