`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/08 13:11:47
// Design Name: 
// Module Name: SevenSegment
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

module SevenSegment(
    output reg [6:0] display,
    output reg [3:0] digit,
    input wire [15:0] nums,
    input wire rst,
    input wire clk
    );
    
    reg [3:0] display_num;
    reg [9:0] next_100;//the  second digit
    reg [6:0] next_10;//the third digit
    reg [3:0] next_1;//the fourth digit
    reg [16:0] digit_timer;//counter for changing the display digit of seven segment
    reg [1:0] digit_select;//selecter for the display digit of seven segment
    
    always @(posedge clk)begin
        if(rst) begin
            digit_timer<=17'b0;
            digit_select<=2'b0;
        end
        else begin
            if(digit_timer==17'd99999)begin
                if(digit_select==2'd3)digit_select<=2'b0;
                else digit_select<=digit_select + 1'b1;
                digit_timer<=17'd0;
            end
            else digit_timer<=digit_timer+1'b1;
        end
    end
    
    always @ (digit_select) begin
        case (digit_select)
            2'b00 : begin
                display_num<=next_1;
                digit <= 4'b1110;
            end
            2'b01 : begin
                if(next_10>=7'd90)display_num<=4'd9;
                else if(next_10>=7'd80)display_num<=4'd8;
                else if(next_10>=7'd70)display_num<=4'd7;
                else if(next_10>=7'd60)display_num<=4'd6;
                else if(next_10>=7'd50)display_num<=4'd5;
                else if(next_10>=7'd40)display_num<=4'd4;
                else if(next_10>=7'd30)display_num<=4'd3;
                else if(next_10>=7'd20)display_num<=4'd2;
                else if(next_10>=7'd10)display_num<=4'd1;
                else display_num<=4'd0;
                digit <= 4'b1101;
            end
            2'b10 : begin
                if(next_100>=10'd900)display_num<=4'd9;
                else if(next_100>=10'd800)display_num<=4'd8;
                else if(next_100>=10'd700)display_num<=4'd7;
                else if(next_100>=10'd600)display_num<=4'd6;
                else if(next_100>=10'd500)display_num<=4'd5;
                else if(next_100>=10'd400)display_num<=4'd4;
                else if(next_100>=10'd300)display_num<=4'd3;
                else if(next_100>=10'd200)display_num<=4'd2;
                else if(next_100>=10'd100)display_num<=4'd1;
                else display_num<=4'd0;
                digit <= 4'b1011;
            end
            default : begin
                if(nums>=16'd9000)display_num<=4'd9;
                else if(nums>=16'd8000)display_num<=4'd8;
                else if(nums>=16'd7000)display_num<=4'd7;
                else if(nums>=16'd6000)display_num<=4'd6;
                else if(nums>=16'd5000)display_num<=4'd5;
                else if(nums>=16'd4000)display_num<=4'd4;
                else if(nums>=16'd3000)display_num<=4'd3;
                else if(nums>=16'd2000)display_num<=4'd2;
                else if(nums>=16'd1000)display_num<=4'd1;
                else display_num<=4'd0;
                digit <= 4'b0111;
            end	
        endcase
    end
    
    always @ (*) begin
        case (display_num)
            4'd0 : display = 7'b1000000;	//0000
            4'd1 : display = 7'b1111001;   //0001                                                
            4'd2 : display = 7'b0100100;   //0010                                                
            4'd3 : display = 7'b0110000;   //0011                                             
            4'd4 : display = 7'b0011001;   //0100                                               
            4'd5 : display = 7'b0010010;   //0101                                               
            4'd6 : display = 7'b0000010;   //0110
            4'd7 : display = 7'b1111000;   //0111
            4'd8 : display = 7'b0000000;   //1000
            4'd9 : display = 7'b0010000;	//1001
            default : display = 7'b1111111;
        endcase
    end
    
    //determine each  digit
    always @(*) begin
        if(rst)next_100=16'd0;
        else if(nums>=16'd9000)next_100=nums-16'd9000;
        else if(nums>=16'd8000)next_100=nums-16'd8000;
        else if(nums>=16'd7000)next_100=nums-16'd7000;
        else if(nums>=16'd6000)next_100=nums-16'd6000;
        else if(nums>=16'd5000)next_100=nums-16'd5000;
        else if(nums>=16'd4000)next_100=nums-16'd4000;
        else if(nums>=16'd3000)next_100=nums-16'd3000;
        else if(nums>=16'd2000)next_100=nums-16'd2000;
        else if(nums>=16'd1000)next_100=nums-16'd1000;
        else next_100=nums;
    end
    
    always @(*) begin
        if(rst)next_10=10'd0;
        else if(next_100>=10'd900)next_10=next_100-10'd900;
        else if(next_100>=10'd800)next_10=next_100-10'd800;
        else if(next_100>=10'd700)next_10=next_100-10'd700;
        else if(next_100>=10'd600)next_10=next_100-10'd600;
        else if(next_100>=10'd500)next_10=next_100-10'd500;
        else if(next_100>=10'd400)next_10=next_100-10'd400;
        else if(next_100>=10'd300)next_10=next_100-10'd300;
        else if(next_100>=10'd200)next_10=next_100-10'd200;
        else if(next_100>=10'd100)next_10=next_100-10'd100;
        else next_10=next_100;
    end
    
    always @(*) begin
        if(rst)next_1=7'd0;
        else if(next_10>=7'd90)next_1=next_10-7'd90;
        else if(next_10>=7'd80)next_1=next_10-7'd80;
        else if(next_10>=7'd70)next_1=next_10-7'd70;
        else if(next_10>=7'd60)next_1=next_10-7'd60;
        else if(next_10>=7'd50)next_1=next_10-7'd50;
        else if(next_10>=7'd40)next_1=next_10-7'd40;
        else if(next_10>=7'd30)next_1=next_10-7'd30;
        else if(next_10>=7'd20)next_1=next_10-7'd20;
        else if(next_10>=7'd10)next_1=next_10-7'd10;
        else next_1=next_10;
    end
endmodule

