`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/08 16:27:47
// Design Name: 
// Module Name: music_controller
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


module music_controller(
    input clk,
    input clk_22,
    input [2:0] state,
    input rst,
    input [2:0] bump,
    output pmod_1,
    output pmod_2,
    output pmod_4
    );
    wire [31:0] tone;
    assign pmod_2 = 1'd1;	//no gain(6dB)
    assign pmod_4 = 1'd1;	//turn-on
    Music M1( .clk_22(clk_22), .state(state), .bump(bump), .tone(tone));
    PWM_gen PWMG( .clk(clk), .reset(rst), .freq(tone), .duty(10'd512), .PWM(pmod_1));
    
endmodule
