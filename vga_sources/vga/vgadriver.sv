`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Jake Alt
// 
// Create Date: 02/25/2021 09:42:30 AM
// Module Name: vgadriver
// Description: 960x540 memory-mapped vga driver for the OTTER.
// Dependencies: vga_clk_wiz, blk_mem_gen_0
// Revision: Revision 1.0
//////////////////////////////////////////////////////////////////////////////////


module vgadriver(
    input clk,
    input reset,
    input [5:0] xaddr,
    input [9:0] yaddr,
    input [31:0] data,
    input wen,
    output vblank,
    output hsync,
    output vsync,
    output logic [3:0] red,
    output logic [3:0] green,
    output logic [3:0] blue
    );
    
    logic vgaclk;
    logic [11:0] hcount;
    logic [10:0] vcount;
    logic [19:0] pixel_addr;
    logic [1:0] pixel, pixel_raw;
    
    // Change this to adjust the colors
    // (you can try using a case statement for more advanced options)
    assign red = {2{pixel}};
    assign green = {2{pixel}};
    assign blue = {2{pixel}};
    
    assign pixel_addr = {vcount[10:1],hcount[10:1]};
    
    vga_clk_wiz clk_gen(.reset(reset),
                        .clk_in1(clk),
                        .clk_out1(vgaclk));
    
    blk_mem_gen_0 vram (.clka(clk),
                        .addra({yaddr,xaddr}),
                        .dina(data),
                        .ena(1),
                        .wea(wen & ({yaddr,xaddr} < 16'd34561)),
                        .clkb(vgaclk),
                        .addrb(pixel_addr),
                        .doutb(pixel_raw),
                        .enb(1));
    
    always_ff @(posedge vgaclk, posedge reset) begin
        if (reset) begin
            hcount <= 0;
            vcount <= 0;
        end else begin
            if (hcount == 2052) begin
                if (vcount == 1124) vcount <= 0;
                else vcount <= vcount + 1;
            end
            if (hcount == 2199) begin
                hcount <= 0;
            end else
                hcount <= hcount + 1;
        end
    end
    
    assign pixel = (hcount < 1921 && vcount < 1080 && hcount > 1) ? pixel_raw : 0;
    assign vsync = (vcount > 1083 && vcount < 1089);
    assign hsync = (hcount > 2008 && hcount < 2053);
    assign vblank = vcount > 1079;
endmodule
