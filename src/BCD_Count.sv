`timescale 1ns / 1ps

module BCD_Count(
    input logic rst,
    input logic en,
    input logic clk,
    input logic D_carry,    // carry in
    output logic Q_carry,   // carry out
    output logic [3:0] Q_count
    );

    assign Q_carry = (Q_count >= 4'b1001) && (en && D_carry);
    
    always_ff @(posedge clk) begin
        if (rst) Q_count <= 4'b0000;
        else if (en && D_carry) begin
            if (Q_count >= 4'b1001) Q_count <= 4'b0000;
            else Q_count <= Q_count + 4'b0001;
        end
    end

endmodule
