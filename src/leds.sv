`timescale 1ns / 1ps

module leds(
    input logic clk,
    input logic tick,
    input logic rst,
    output logic [15:0] ledIn = 16'h0003
    );
    
    logic [7:0] ms_count = '0;

    always_ff @(posedge clk) begin
        if (rst) begin
            ms_count <= '0;
            ledIn <= 16'h0003;
        end else if (tick) begin
 
            if (ms_count == 8'd249) begin   // 1/4 de segundo
                ms_count <= '0;
                if (ledIn == 16'b0) begin
                    ledIn <= 16'h0003;    
                end else begin
                    ledIn <= {ledIn[14:0], 1'b0};
                end

            end else begin
                ms_count <= ms_count + 1'b1;
            end
        end
    end

endmodule
