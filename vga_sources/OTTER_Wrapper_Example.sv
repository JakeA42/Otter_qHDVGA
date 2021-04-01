`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: J. Calllenes
//           P. Hummel
//           J. Alt
// 
// Description: Modified OTTER Wrapper for VGA connection demonstration
//              (not for use in synthesis!)
//////////////////////////////////////////////////////////////////////////////////


module OTTER_Wrapper(
    input CLK,
    input BTNL,
    input BTNC,
    input [15:0] SWITCHES,
    output logic [15:0] LEDS,
    output [7:0] CATHODES,
    output [3:0] ANODES,

    // New Ports
    output Hsync,
    output Vsync,
    output [3:0] vgaRed,
    output [3:0] vgaGreen,
    output [3:0] vgaBlue
    );
       
   
    localparam VBLANK_AD    = 32'hffffffff;

    // VRAM START ADDRESS ////////////////////////////////////////////////////
    localparam VRAM = 32'hFFF00000;
     
    logic [31:0] IOBUS_out,IOBUS_in,IOBUS_addr;
    logic IOBUS_wr;
   
    logic vga_vblank;
   
    // Connect Board peripherals (Memory Mapped IO devices) to IOBUS /////////
    always_comb
    begin
        IOBUS_in=32'b0;
        case(IOBUS_addr)
            SWITCHES_AD: IOBUS_in[15:0] = SWITCHES;
            ENC_AD: IOBUS_in[3:0] = enc_val;
            VBLANK_AD: IOBUS_in[0] = vga_vblank; // New line
            default: IOBUS_in=32'b0;
        endcase
    end
    
    // VGA ///////////////////////
    // A buffer is used to prevent data corruption
    logic [15:0] vram_addr_buf;
    logic [31:0] vram_data_buf;
    logic vram_wr_buf;
    always_ff @(posedge sclk) begin
        if (IOBUS_wr && IOBUS_addr >= VRAM) begin
            // Offset bits to get word-aligned addresses
            vram_addr_buf <= IOBUS_addr[17:2];
            vram_data_buf <= IOBUS_out;
            vram_wr_buf <= 1;
        end else vram_wr_buf <= 0;
    end
    
    vgadriver VGA (.clk(CLK),
                   .reset(s_reset),
                   .xaddr(vram_addr_buf[5:0]),
                   .yaddr(vram_addr_buf[15:6]),
                   .data(vram_data_buf),
                   .wen(vram_wr_buf),
                   .vblank(vga_vblank),
                   .hsync(Hsync),
                   .vsync(Vsync),
                   .red(vgaRed),
                   .green(vgaGreen),
                   .blue(vgaBlue));
endmodule