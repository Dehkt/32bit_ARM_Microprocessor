`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2024 04:44:54 AM
// Design Name: 
// Module Name: Extender
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


module Extender(
    input      [23:0] Imm,
    input      [1:0]  ImmSrc,
    output reg [31:0] ImmExt
    );
    
    parameter DataProcessing = 2'b00;
    parameter LDRSTR         = 2'b01;
    parameter B              = 2'b10;
    
    always @(*) begin
        case (ImmSrc)
            DataProcessing: ImmExt = {{24{Imm[7]}}, Imm}; // Data Processing Instructions
            LDRSTR:         ImmExt = {{20{Imm[11]}}, Imm}; // LDR and STR
            B:              ImmExt = {{8{Imm[23]}}, Imm}; // Branch
        endcase
    end
    
endmodule

