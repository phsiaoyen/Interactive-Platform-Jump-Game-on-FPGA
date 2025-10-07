`timescale 1ns / 1ps
module top(
   input clk,
   inout PS2_DATA,
   inout PS2_CLK, 
   output reg [3:0] vgaRed,
   output reg [3:0] vgaGreen,
   output reg [3:0] vgaBlue,
   output hsync,
   output vsync,
   output pmod_1,
   output pmod_2,
   output pmod_4,
   output wire [6:0] seg,
   output wire [3:0] an
    );
    
    wire [15:0] score;
    
    //state
    parameter WAIT = 3'b000;
    parameter INFORMATION = 3'b001;
    parameter GAME = 3'b010;
    parameter WIN = 3'b011;
    parameter LOSE = 3'b100;
    
    reg [2:0] state, next_state;
    
    wire [11:0] data;
    wire clk_25MHz;
    wire clk_22;
    wire [11:0] pixel;
    wire valid;
    wire [9:0] h_cnt; //640
    wire [9:0] v_cnt;  //480
    wire [9:0] fixed_block_x1, fixed_block_x2, fixed_block_x3, fixed_block_x4, fixed_block_x5, fixed_block_x6, fixed_block_x7, fixed_block_x8, fixed_block_x9, fixed_block_x10, fixed_block_x11, fixed_block_x12, fixed_block_x13, fixed_block_x14, fixed_block_x15;
    wire [9:0] fixed_block_y1, fixed_block_y2, fixed_block_y3, fixed_block_y4, fixed_block_y5, fixed_block_y6, fixed_block_y7, fixed_block_y8, fixed_block_y9, fixed_block_y10, fixed_block_y11, fixed_block_y12, fixed_block_y13, fixed_block_y14, fixed_block_y15;
    wire [9:0] doodle_x; // the x coordinate of doodle
    wire [9:0] doodle_y; // the y coordinate of doodle
    wire detect_doodle; // detect whether there is doodle at the current position 
    wire [2:0] detect; // detect which color to show when the doodle's background need to be removed
    wire [16:0] pixel_addr;
    wire invincible; //invincible = 1 when doodle is in invincible mode
    wire doodle_right;// detect the direction of doodle to change the image of it
    wire enter, leave, inform;// output of keyboard, to control the state transition
    wire [511:0] key_down;
    
    wire [2:0] Bump;// check which color of block that doodle bumpped on
    
    wire fly;// fly = 1 when doodle is moving upward
    wire [4:0] speed_y;// the speed that doodle moving on y coordinate
    
    wire [9:0] movement;//the distance of blocks' movement
    wire hold;// when doodle bump on the blue or orange block, it need to be hold for a while
    
    assign LEFT=key_down[8'b0001_1100];
    assign RIGHT=key_down[8'b0010_0011];
   
    
    always @(posedge clk) begin
        if(rst) begin
            state<=WAIT;
        end
        else begin
            state<=next_state;
        end
    end
    
    always @(*) begin
        case(state)
        WAIT: begin
            if(enter) begin
                next_state=GAME;
            end
            else if(inform)begin
                next_state=INFORMATION;
            end
            else begin
                next_state=state;
            end
        end
        INFORMATION: begin
            if(leave) begin
                next_state=WAIT;
            end
            else begin
                next_state=state;
            end
        end
        GAME: begin
            if(score>=16'd3000) begin
                next_state=WIN;
            end
            else if(doodle_y>=10'd485)begin//doodle is dropped out of the screen
                next_state=LOSE;
            end
            else begin
                next_state=state;
            end
        end
        WIN: begin
            if(enter) begin
                next_state=WAIT;
            end
            else begin
                next_state=state;
            end
        end
        default: begin
            if(enter) begin
                next_state=WAIT;
            end
            else begin
                next_state=state;
            end
        end
        endcase
    end
    
    //generate pixel address
    pixel_gen PG(
        clk, 
        rst,
        state,
        fixed_block_x1, fixed_block_x2, fixed_block_x3, fixed_block_x4, fixed_block_x5, fixed_block_x6, fixed_block_x7, fixed_block_x8, fixed_block_x9, fixed_block_x10, fixed_block_x11, fixed_block_x12, fixed_block_x13, fixed_block_x14, fixed_block_x15,
        fixed_block_y1, fixed_block_y2, fixed_block_y3, fixed_block_y4, fixed_block_y5, fixed_block_y6, fixed_block_y7, fixed_block_y8, fixed_block_y9, fixed_block_y10, fixed_block_y11, fixed_block_y12, fixed_block_y13, fixed_block_y14, fixed_block_y15,
        doodle_x,
        doodle_y,
        v_cnt,
        h_cnt,
        invincible,
        doodle_right,
        detect_doodle,
        detect,
        pixel_addr
    );
    
    //check which block the doodle is jumping on
    integrate_bump IB(
        clk,
        rst,
        fixed_block_x1, fixed_block_x2, fixed_block_x3, fixed_block_x4, fixed_block_x5, fixed_block_x6, fixed_block_x7, fixed_block_x8, fixed_block_x9, fixed_block_x10, fixed_block_x11, fixed_block_x12, fixed_block_x13, fixed_block_x14, fixed_block_x15,
        fixed_block_y1, fixed_block_y2, fixed_block_y3, fixed_block_y4, fixed_block_y5, fixed_block_y6, fixed_block_y7, fixed_block_y8, fixed_block_y9, fixed_block_y10, fixed_block_y11, fixed_block_y12, fixed_block_y13, fixed_block_y14, fixed_block_y15,
        doodle_x, doodle_y,
        state,
        speed_y,
        fly,
        invincible,
        Bump,
        movement
    );
    
    //generate the position of blocks
    fixed_block_gen FB(
        clk,
        clk_22,
        rst,
        state,
        Bump,
        movement,
        hold,
        score,
        fixed_block_x1, fixed_block_x2, fixed_block_x3, fixed_block_x4, fixed_block_x5, fixed_block_x6, fixed_block_x7, fixed_block_x8, fixed_block_x9, fixed_block_x10, fixed_block_x11, fixed_block_x12, fixed_block_x13, fixed_block_x14, fixed_block_x15,
        fixed_block_y1, fixed_block_y2, fixed_block_y3, fixed_block_y4, fixed_block_y5, fixed_block_y6, fixed_block_y7, fixed_block_y8, fixed_block_y9, fixed_block_y10, fixed_block_y11, fixed_block_y12, fixed_block_y13, fixed_block_y14, fixed_block_y15
    );
    
     clock_divisor clk_wiz_0_inst(
        .clk(clk),
        .clk1(clk_25MHz),
        .clk22(clk_22)
    );
    
    //control the position of doodle
    doodle_move DM(
        .clk_22(clk_22),
        .rst(rst),
        .state(state),
        .left(LEFT), 
        .right(RIGHT),
        .bump(Bump),
        .doodle_x(doodle_x),
        .doodle_y(doodle_y),
        .speed_y(speed_y),
        .fly(fly),
        .invincible(invincible),
        .hold(hold),
        .doodle_right(doodle_right)
    );
    
 
    blk_mem_gen_0 blk_mem_gen_0_inst(
        .clka(clk_25MHz),
        .wea(0),
        .addra(pixel_addr),
        .dina(data[11:0]),
        .douta(pixel)
    ); 
    
    Keyboard_Controller KC( 
        .clk(clk),
        .PS2_CLK(PS2_CLK),
        .PS2_DATA(PS2_DATA),
        .RST_N(rst), .ENTER(enter), .BACKSPACE(leave), .SHIFT(inform),
        .key_down(key_down)
    );

    vga_controller   vga_inst(
        .pclk(clk_25MHz),
        .reset(rst),
        .hsync(hsync),
        .vsync(vsync),
        .valid(valid),
        .h_cnt(h_cnt),
        .v_cnt(v_cnt)
    );
    
    music_controller MC(
        .clk(clk),
        .clk_22(clk_22),
        .state(state),
        .rst(rst),
        .bump(Bump),
        .pmod_1(pmod_1),
        .pmod_2(pmod_2),
        .pmod_4(pmod_4)
    );
    
    SevenSegment SS(
        .display(seg),
        .digit(an),
        .nums(score),
        .rst(rst),
        .clk(clk)
    );
    
    always @(posedge clk) begin
        if(valid) begin
            if(detect_doodle) begin
                if(pixel == 12'hfff) begin // if the background need to be removed
                    if(detect == 3'd0) begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'h0AE; //blue block
                    end
                    else if(detect == 3'd1) begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'hF72; //orange block
                    end
                    else if(detect == 3'd2) begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'hFF0; //yellow block
                    end
                    else if(detect == 3'd3) begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'h2B4; //green block
                    end
                    else if(detect == 3'd4) begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'hB75; //brown block
                    end
                    else begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'hFFD; //background color
                    end
                end
                else begin
                    {vgaRed, vgaGreen, vgaBlue} = pixel; // show doodle's color
                end
            end
            else begin
                {vgaRed, vgaGreen, vgaBlue} = pixel;
            end
        end
        else begin
            {vgaRed, vgaGreen, vgaBlue} = 12'b0;
        end
    end
endmodule
