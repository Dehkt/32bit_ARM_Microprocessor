`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2024 07:54:17 AM
// Design Name: 
// Module Name: mux1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux1(
    input logic [31:0] readData,
    input logic [31:0] PCout,
    input logic PCSrc,
    output logic [31:0] PCin
);
    always_comb begin
        if (PCSrc) begin
            PCin = readData;
        end else begin
            PCin = PCout + 4; // PCPlus4
        end
    end
    
endmodule
