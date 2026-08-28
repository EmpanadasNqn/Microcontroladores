`timescale 1ns / 1ps

module BCD_Count_bank(
    input logic clk,
    input logic D_freq,
    input logic D_rst,  // count reset
    input logic D_en,   // count enable
    output logic [3:0] Q0_u, Q1_d, Q2_c, Q3_m
    );
    
    logic carryA, carryB, carryC;
    BCD_Count count_u(  .rst(D_rst),
                        .en(D_en),
                        .clk(clk),
                        .D_carry(D_freq),
                        .Q_carry(carryA),
                        .Q_count(Q0_u));

    BCD_Count count_d(  .rst(D_rst),
                        .en(D_en),
                        .clk(clk),
                        .D_carry(carryA),
                        .Q_carry(carryB),
                        .Q_count(Q1_d));

    BCD_Count count_c(  .rst(D_rst),
                        .en(D_en),
                        .clk(clk),
                        .D_carry(carryB),
                        .Q_carry(carryC),
                        .Q_count(Q2_c));

    BCD_Count count_m(  .rst(D_rst),
                        .en(D_en),
                        .clk(clk),
                        .D_carry(carryC),
                        .Q_carry(),
                        .Q_count(Q3_m));

endmodule
