`timescale 1ns / 1ps

module BCD_Count_bank(
    input logic D_freq,
    input logic D_rst,  // count reset
    input logic D_en,   // count enable
    output logic [3:0] Q0_u, Q1_d, Q2_c, Q3_m
    );
    
    BCD_Count count_u();
    BCD_Count count_d();
    BCD_Count count_c();
    BCD_Count count_m();
    
endmodule
