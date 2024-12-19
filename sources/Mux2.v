`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2024 02:04:14 AM
// Design Name: 
// Module Name: Mux2
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


module Mux2(
    input      [31:0] ReadData,
    input      [31:0] ALUResult,
    input             MemtoReg,
    output reg [31:0] Result
    );
    
    always @(*) begin
        if (MemtoReg == 0) begin
            Result = ALUResult;
        end else begin
            Result = ReadData;
        end
    end
    
endmodule
