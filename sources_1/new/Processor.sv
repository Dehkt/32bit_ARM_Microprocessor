`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2024 05:31:08 PM
// Design Name: 
// Module Name: Processor
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


module Processor(
                 input logic clk,
                 input logic rst              
    );
    
    logic [31:0] PC;
    logic [31:0] PCPlus4;
    logic [31:0] instruction;
    logic [31:0] ImmExt;
    logic [31:0] RegData1;
    logic [31:0] RegData2;
    logic [31:0] aluResult;
    logic [31:0] readData; // DataMemory Output
    logic [1:0]  aluCtrl;
    logic        RegWrite;
    logic [31:0] PCPlus8;
    logic [31:0] PCin;
    logic PCSrc;
    logic WE;
    
    
    ProgramCounter PC_inst(
    .clk(clk),
    .rst(rst),
    .PCin(PCin),
    .PCout(PC) 
    );
    
    InstructionMemory InstrMem_inst(
    .address(PC),
    .instruction(instruction)
    );
    
    mux1 Mux_Inst(
    .readData(readData),
    .PCout(PC),
    .PCSrc(PCSrc),
    .PCin(PCin)
    );
    
    RegisterFile RegFile_inst(
    .clk(clk),
    .rst(rst),
    .A1(instruction[19:16]),
    .A2(),
    .A3(instruction[15:12]),
    .WD3(readData),
    .WE3(RegWrite),
    .RD1(RegData1),
    .RD2(RegData2),
    .PCout(PC)
    );
    
    
    ALU ALU_inst(
    .SrcA(RegData1),
    .SrcB(ImmExt),
    .aluCtrl(aluCtrl),
    .aluResult(aluResult),
    .zero()
    );


    DataMemory DataMem_inst(
    .clk(clk),
    .rst(rst),
    .address(aluResult),
    .writeEn(WE),
    .writeData(),
    .readData(readData)
    );
    
    
    ImmediateExt ImmExt_inst(
    .InputAddr(instruction[11:0]),
    .ImmExt(ImmExt)
    );



    
endmodule
