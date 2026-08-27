`timescale 1ns / 1ps

module Frequency_meter(
    input logic clk,
    input logic freqIn,
    output logic [7:0] D0_SEG,
    output logic [3:0] D0_AN
    );
    
    // Generador del TS1
    BaseTime1ms timer();
    
    // Controladora contadores y latch
    FSM_Control control();
    
    // Contadores unidad, decimal, centesima, milesima
    BCD_Count_bank Count();
    
    // El "Latch"
    Register regA();
    
    logic [13:0] cnt_display;
    // Deco de BCD a 7seg
    disp7seg_controller dispA(  .clk(cnt_display[13]),
                                .bcd_dig({XXXX,XXXX,XXXX,XXXX}), // Aca se deben conectar los BCD de salida del LATCH
                                .blank_dig(4'b0000),
                                .seg(D0_seg),
                                .dig_en(D0_a));

    always @(posedge clk) cnt_display <= cnt_display + 1;

endmodule
