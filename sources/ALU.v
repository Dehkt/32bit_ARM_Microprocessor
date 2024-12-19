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
    output reg Zero,
    output reg Negative, 
    output reg Carry,
    output reg Overflow
    );
    
    parameter ADD = 2'b00;
    parameter SUB = 2'b01;
    parameter AND = 2'b10;
    parameter ORR = 2'b11;
    
    always @(*) begin
        case (ALUControl)
            ADD: begin
                {Carry, ALUResult} = SrcA + SrcB;
                Overflow = (~SrcA[31] & ~SrcB[31] & ALUResult[31]) | (SrcA[31] & SrcB[31] & ~ALUResult[31]);
            end
            
            SUB: begin
                {Carry, ALUResult} = SrcA - SrcB;
                Overflow = (SrcA[31] & ~SrcB[31] & ~ALUResult[31]) | (~SrcA[31] & SrcB[31] & ALUResult[31]);
            end
            
            AND: begin
             ALUResult = SrcA & SrcB;
             Carry = 0;
             Overflow = 0;
            end
           
            ORR: begin
            ALUResult = SrcA | SrcB;
            Carry = 0;
            Overflow = 0;
            end
            
        default: ALUResult = 32'b0;
        endcase
       
        Zero = (ALUResult == 32'b0); // Zero = 1 when Result is equal to zero.
        Negative = ALUResult[31]; // True if MSB is 1 in 2's compliment, using Signed Reg type for RD1 and RD2.
        
       end
       
endmodule
