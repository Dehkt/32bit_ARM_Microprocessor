`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2024 04:44:54 AM
// Design Name: 
// Module Name: Mux1
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


module Mux1(
    input      [31:0] ReadData,
    input      [31:0] PC,
    input             PCSrc,
    output reg [31:0] PCPrime
    );
    
    always @(*) begin
        if (PCSrc == 1) begin
            PCPrime = ReadData;
        end else begin
            PCPrime = PC + 4;
        end
    end
    
endmodule