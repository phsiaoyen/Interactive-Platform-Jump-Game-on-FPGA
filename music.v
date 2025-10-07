`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/08 01:12:53
// Design Name: 
// Module Name: music
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


`define NM1 32'd466 //bB_freq
`define NM2 32'd523 //C_freq
`define NM3 32'd587 //D_freq
`define NM4 32'd622 //bE_freq
`define NM5 32'd698 //F_freq
`define NM6 32'd784 //G_freq
`define NM7 32'd880 //A_freq
`define NM8 32'd659 //E_freq
`define NM9 32'd830 //bA_freq
`define NM10 32'd740 //bG_freq
`define NM0 32'd20000 //slience (over freq.)

module Music (
    input clk_22,
    input [2:0] state,
	input [2:0] bump,	
	output reg [31:0] tone
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
    reg [2:0] prev_bump;
    reg [6:0] counter;
    reg [3:0] win_counter;
    reg [3:0] lose_counter;
    
    always @(posedge clk_22) begin
        if(state == WAIT || state == INFORMATION) begin
            prev_bump<=3'd0;
            tone<= `NM0;
            counter<=7'b0;
            win_counter<=4'b0;
            lose_counter<=4'b0;
        end
        else if(state == WIN) begin
            counter<=7'b0;
            lose_counter<=4'b0;
            if(win_counter <= 4'd1) tone<=`NM2;
            else if(win_counter <= 4'd3) tone<=`NM3;
            else if(win_counter <= 4'd5) tone<=`NM8;
            else if(win_counter <= 4'd8) tone<=`NM6;
            else if(win_counter <= 4'd10) tone<=`NM8;
            else if(win_counter <= 4'd13) tone<=`NM6;
            else tone<=`NM0;
            
            if(win_counter < 4'd14) win_counter<=win_counter + 1'b1;
            else win_counter <= win_counter;
        end
        else if(state == LOSE) begin
            counter<=7'b0;
            win_counter<=4'b0;
            if(lose_counter <= 4'd1) tone<=`NM7;
            else if(lose_counter <= 4'd3) tone<=`NM9;
            else if(lose_counter <= 4'd5) tone<=`NM6;
            else if(lose_counter <= 4'd9) tone<=`NM10;
            else tone<=`NM0;
            
            if(lose_counter < 4'd10) lose_counter<=lose_counter + 1'b1;
            else lose_counter <= lose_counter;
        end
        else begin
            win_counter <= 4'b0;
            lose_counter <= 4'b0;
            if(bump==BUMP_GREEN)begin
                prev_bump<=3'd1;
                tone<= `NM2;
                counter<=7'd0;
            end
            else if(bump==BUMP_BLUE)begin
                prev_bump<=3'd2;
                tone<= `NM2;
                counter<=7'd0;
            end
            else if(bump==BUMP_ORANGE)begin
                prev_bump<=3'd3;
                tone<= `NM2;
                counter<=7'd0;
            end
            else if(bump==BUMP_YELLOW)begin
                prev_bump<=3'd4;
                tone<= `NM2;
                counter<=7'd0;
            end
            else begin
                if(prev_bump==3'd1) begin
                    if(counter>=7'd2) begin
                        prev_bump<=3'b0;
                        counter<=7'd0;
                        tone<= `NM0;
                    end
                    else begin
                        prev_bump<=prev_bump;
                        counter<=counter+1'b1;
                        tone<= `NM4;
                    end
                end
                else if(prev_bump==3'd2) begin
                    if(counter>=7'd100) begin
                        prev_bump<=3'b0;
                        counter<=7'd0;
                        tone<= `NM0;
                    end
                    else begin
                        if(counter[0]==1'b0)begin
                            tone<= `NM2;
                        end
                        else begin
                            tone<= `NM3;
                        end
                        prev_bump<=prev_bump;
                        counter<=counter+1'b1;
                    end
                end
                else if(prev_bump==3'd3) begin
                    if(counter>=10) begin
                        prev_bump<=3'b0;
                        counter<=7'b0;
                        tone<= `NM0;
                    end
                    else begin
                        prev_bump<=prev_bump;
                        counter<=counter+1'b1;
                        tone<= `NM4;
                    end
                end
                else if(prev_bump==3'd4) begin
                    if(counter>=7'd10) begin
                        prev_bump<=3'd0;
                        counter<=7'd0;
                        tone<= `NM0;
                    end
                    else begin
                        prev_bump<=prev_bump;
                        counter<=counter+1'b1;
                        tone<= `NM2<<1;
                    end
                end
                else begin
                    prev_bump<=prev_bump;
                    counter<=7'b0;
                    tone<= `NM0;
                end
            end
        end
    end
endmodule
