`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2024 07:46:27 AM
// Design Name: 
// Module Name: ControlUnit
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

module ControlUnit(
                   input            clk,
                   input      [3:0] Flags,
                   input      [3:0] Cond,
                   input      [1:0] Op,
                   input      [5:0] Funct,
                   input      [3:0] Rd,
                   output     [1:0] RegSrc, ALUControl, ImmSrc,
                   output           PCSrc,       
                   output           MemtoReg,                   
                   output           MemWrite,  
                   output           ALUSrc,  
                   output           RegWrite
);

wire [1:0] FlagW;
wire PCS, RegW, MemW, Branch, ALUOp;

Decoder Decoder_Inst(
    .Rd(Rd),
    .Op(Op),
    .Funct(Funct),
    .RegW(RegW),
    .MemW(MemW),
    .MemtoReg(MemtoReg),
    .ALUSrc(ALUSrc),
    .Branch(Branch),
    .ALUOp(ALUOp),
    .FlagW(FlagW),
    .ImmSrc(ImmSrc),
    .RegSrc(RegSrc),
    .ALUControl(ALUControl)
);

PCLogic PCLogic_Inst(
    .Rd(Rd),
    .Branch(Branch),
    .RegW(RegW),
    .PCS(PCS)
);
 

ALUDecoder ALUDecoder_Inst(
    .ALUOp(ALUOp),
    .Funct(Funct),
    .ALUControl(ALUControl),
    .FlagW(FlagW)

);

ConditionalLogic ConditionalLogic_Inst(
    .clk(clk),
    .PCS(PCS),
    .RegW(RegW),
    .MemW(MemW),
    .FlagW(FlagW),
    .Cond(Cond),
    .ALUFlags(Flags),
    .PCSrc(PCSrc),
    .RegWrite(RegWrite),
    .MemWrite(MemWrite)
);

assign MemtoReg = MemtoReg;
assign ALUSrc = ALUSrc;
assign ImmSrc = ImmSrc;
assign RegSrc = RegSrc;
assign ALUControl = ALUControl;
assign PCSrc = PCSrc;
assign RegWrite = RegWrite;
assign MemWrite = MemWrite;
                                   
endmodule
