`timescale 1ns / 1ps

module Edge_Detector(
    input logic clk,
    input logic async_in,
    output logic pulse_out
    );

    logic [2:0] shift_reg = 3'b000;
    always_ff @(posedge clk) begin
        shift_reg <= {shift_reg[1:0], async_in};
    end
    
    // El pulso se activa solo durante un cilo de reloj
    assign pulse_out = (shift_reg[1] == 1'b1) && (shift_reg[2] == 1'b0);

endmodule
