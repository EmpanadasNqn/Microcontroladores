`timescale 1ns / 1ps

module BCD_Count(
    input logic reset,
    input logic en,
    input logic clk,
    input logic D_carry,    // carry in
    output logic Q_carry,   // carry out
    output logic [3:0] Q_count
    );
    
endmodule
