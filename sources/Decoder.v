`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2024 08:08:13 AM
// Design Name: 
// Module Name: Decoder
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


module Decoder(
               input [3:0] Rd,
               input [1:0] Op,
               input [5:0] Funct,
               output reg  RegW, MemW, MemtoReg, ALUSrc, Branch, ALUOp,
               output reg [1:0] FlagW, ImmSrc, RegSrc, ALUControl
    );
    wire Funct5, Funct0;
    assign Funct5 = Funct[5];
    assign Funct0 = Funct[0];
    
    always @(*) begin
    // Default Values
    Branch = 0;
    MemtoReg = 0;
    MemW = 0;
    ALUSrc = 0;
    ImmSrc = 2'b00;
    RegW = 0;
    RegSrc = 2'b00;
    ALUOp = 0;
    
    case (Op)
        2'b00: begin
            casex({Funct5, Funct0})
                2'b0x: begin // DP Reg
                  Branch = 0;
                  MemtoReg = 0;
                  MemW = 0;
                  ALUSrc = 0;
                  ImmSrc = 2'bxx;
                  RegW = 1;
                  RegSrc = 2'b00;
                  ALUOp = 1;
                end
               2'b1x: begin // DP Imm
                  Branch = 0;
                  MemtoReg = 0;
                  MemW = 0;
                  ALUSrc = 1;
                  ImmSrc = 2'b00;
                  RegW = 1;
                  RegSrc = 2'bx0;
                  ALUOp = 1;        
               end
            endcase
          end  
        2'b01: begin 
             casex({Funct5, Funct0})
                2'bx0: begin // STR
                  Branch = 0;
                  MemtoReg = 1'bx;
                  MemW = 1;
                  ALUSrc = 1;
                  ImmSrc = 2'b01;
                  RegW = 0;
                  RegSrc = 2'b10;
                  ALUOp = 0;
                end
               2'bx1: begin // LDR
                  Branch = 0;
                  MemtoReg = 1;
                  MemW = 0;
                  ALUSrc = 1;
                  ImmSrc = 2'b01;
                  RegW = 1;
                  RegSrc = 2'bx0;
                  ALUOp = 0;        
               end
            endcase
        end
        2'b10: begin // B
                  Branch = 1;
                  MemtoReg = 0;
                  MemW = 0;
                  ALUSrc = 1;
                  ImmSrc = 2'b10;
                  RegW = 0;
                  RegSrc = 2'bx1;
                  ALUOp = 0; 
               end
        endcase
 end
    // For PC Logic block input is Rd, output is PCS
    // Main Decoder takes Op and Funct and outputs RegW, MemW, MemtoReg, ALUSrc, RegSrc, ImmSrc.
    // ALUDecoder takes Funct [4:0] and outputs ALUControl and FlagW. 
endmodule

module ALUDecoder(input ALUOp, 
                  input [4:0] Funct,
                  output reg [1:0] ALUControl,
                  output reg [1:0] FlagW
       );
       
    wire Funct41, Funct0;
    assign Funct41 = Funct[4:1];
    assign Funct0 = Funct[0];
    
    always @(*) begin 
    case (ALUOp)
           1'b0: begin // Not DP
                 ALUControl = 2'b00;
                 FlagW = 2'b00;
           end
           1'b1: begin
           casex({Funct41, Funct0})
                 5'b0100_0: begin // ADD
                    ALUControl = 2'b00;
                    FlagW = 2'b00;
                 end
                 
                 5'b0100_1: begin // ADD
                    ALUControl = 2'b00;
                    FlagW = 2'b11;
                 end
                 
                 5'b0010_0: begin // SUB
                    ALUControl = 2'b01;
                    FlagW = 2'b00;
                 end
                 
                 5'b0010_1: begin // SUB
                    ALUControl = 2'b01;
                    FlagW = 2'b11;
                 end
                 
                 5'b0000_0: begin // AND
                    ALUControl = 2'b10;
                    FlagW = 2'b00;
                 end
                 
                 5'b0000_1: begin // AND
                    ALUControl = 2'b10;
                    FlagW = 2'b10;
                 end
                 
                 5'b1100_0: begin // ORR
                    ALUControl = 2'b11;
                    FlagW = 2'b00;
                 end
                 
                 5'b1100_1: begin // ORR
                    ALUControl = 2'b11;
                    FlagW = 2'b10;
                 end
             endcase  
         end
 endcase
 end               

endmodule

module PCLogic (input [3:0] Rd,
                input Branch,
                input RegW,
                output reg PCS
          );
               
    always @(*) begin
        PCS = ((Rd == 15) & RegW) | Branch;
    end
endmodule
