`timescale 1ns / 1ps

module Frequency_meter(
    input logic clk,
    input logic rst,            // Lo asigno a un boton?
    input logic freqIn,         // Yyyy esto ya nose, uno de GPIO?
    output logic [7:0] D0_SEG,
    output logic [3:0] D0_AN,
    output logic [15:0] led
    );
    
    logic tms1;
    // Generador del tick cada 1ms
    BaseTime1ms timer(  .clk(clk),
                        .rst(rst),
                        .tick_out(tms1));
    
    logic cnt_en, cnt_rst, l_en;
    // Controladora contadores y latch
    FSM_Control control(.clk(clk),
                        .rst(rst),
                        .tick_1ms(tms1),
                        .cnt_en(cnt_en),
                        .cnt_rst(cnt_rst),
                        .latch_en(l_en));
    
    logic freq_pulse;
    // Sincroniza la señal a medir, generando un pulso en cada clk
    Edge_Detector edge_det( .clk(clk),
                            .async_in(freqIn),
                            .pulse_out(freq_pulse));
    
    logic [3:0] q_u, q_d, q_c, q_m;
    // Contadores unidad, decimal, centesima, milesima
    BCD_Count_bank count(   .clk(clk),
                            .D_freq(freq_pulse),
                            .D_rst(cnt_rst),
                            .D_en(cnt_en),
                            .Q0_u(q_u),
                            .Q1_d(q_d),
                            .Q2_c(q_c),
                            .Q3_m(q_m));
    
    logic [3:0] d_u, d_d, d_c, d_m;
    // Los "Latch"
    Register reg_u( .clk(clk),
                    .rst(rst),
                    .D_latchEN(l_en),
                    .D(q_u),
                    .Q(d_u));

    Register reg_d( .clk(clk),
                    .rst(rst),
                    .D_latchEN(l_en),
                    .D(q_d),
                    .Q(d_d));

    Register reg_c( .clk(clk),
                    .rst(rst),
                    .D_latchEN(l_en),
                    .D(q_c),
                    .Q(d_c));

    Register reg_m( .clk(clk),
                    .rst(rst),
                    .D_latchEN(l_en),
                    .D(q_m),
                    .Q(d_m));

    logic [13:0] cnt_display = 'b0;
    // Deco de BCD a 7seg
    disp7seg_controller dispA(  .clk(cnt_display[13]),
                                .bcd_dig({d_m, d_c, d_d, d_u}), // Aca se deben conectar los BCD de salida del LATCH
                                .blank_dig(4'b0000),
                                .seg(D0_SEG),
                                .dig_en(D0_AN));

    // El cambio del bit 13 se hace aprox a 1.5kHz
    always @(posedge clk) cnt_display <= cnt_display + 1;

    // Leds moviendose
    leds disp16Leds(.clk(clk),
                    .tick(tms1),
                    .rst(rst),
                    .ledIn(led));

endmodule
