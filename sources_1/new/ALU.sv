`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2024 08:14:35 PM
// Design Name: 
// Module Name: ALU
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

module ALU(
           input logic   [31:0]  SrcA,
           input logic   [31:0]  SrcB,
           input logic   [1:0]   aluCtrl,
           output logic  [31:0]  aluResult,
           output logic          zero
    );

always_comb begin
    case(aluCtrl)
    2'b00:   aluResult = SrcA + SrcB; // ADD
    2'b01:   aluResult = SrcA - SrcB; // SUB
    2'b10:   aluResult = SrcA & SrcB; // AND
    2'b11:   aluResult = SrcA | SrcB; // OR
    default: aluResult = 32'b0;
    endcase
end

assign zero = (aluResult == 32'b0) ? 1'b1 : 1'b0;

endmodule
