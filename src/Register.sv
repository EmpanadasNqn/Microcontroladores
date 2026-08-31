`timescale 1ns / 1ps

module Register(
    input logic clk,
    input logic rst,
    input logic D_latchEN,
    input logic [3:0] D,
    output logic [3:0] Q
    );
    
    always_ff @(posedge clk) begin
        if (rst) Q <= 4'b0000;
        else if (D_latchEN) Q <= D;
    end

endmodule
