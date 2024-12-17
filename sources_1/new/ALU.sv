`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2024 04:44:54 AM
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
    input [31:0] SrcA,
    input [31:0] SrcB,
    input [1:0] ALUControl,
    output reg [31:0] ALUResult,
    output reg Zero // may not be reg type
    );
    
    parameter ADD = 2'b00;
    parameter SUB = 2'b01;
    parameter AND = 2'b10;
    parameter ORR = 2'b11;
    
    always @(*) begin
        case (ALUControl)
            ADD:  ALUResult = SrcA + SrcB;
            SUB:  ALUResult = SrcA - SrcB;
            AND:  ALUResult = SrcA & SrcB;
            ORR:  ALUResult = SrcA || SrcB;
        default: ALUResult = 32'b0;
        endcase
        Zero = (ALUResult == 32'b0); // Zero = 1 when Result is equal to zero.
       end
       
endmodule
