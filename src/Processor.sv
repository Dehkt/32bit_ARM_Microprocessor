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
    logic [31:0] instruction;
    logic [31:0] ImmExt;
    logic [31:0] RegData1;
    logic [31:0] RegData2;
    logic [31:0] aluResult;
    logic [31:0] readData; // DataMemory Output
    logic [1:0]  aluCtrl;
    logic        RegWrite;
    
    ProgramCounter PC_inst(
    .clk(clk),
    .rst(rst),
    .PCin(PC + 4),
    .PCout(PC) 
    );
    
    InstructionMemory InstrMem_inst(
    .address(PC),
    .instruction(instruction)
    );
    
    RegisterFile RegFile_inst(
    .clk(clk),
    .rst(rst),
    .A1(instruction[19:16]),
    .A2(), // Not used right now for LDR
    .A3(instruction[15:12]),
    .WD3(readData),
    .WE3(RegWrite),
    .RD1(RegData1), // Data read from the source register A1, should be instruction[19:16]
    .RD2(RegData2)
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
    .writeEn(1'b0),
    .writeData(),
    .readData(readData)
    );
    
    
    ImmediateExt ImmExt_inst(
    .InputAddr(instruction[11:0]),
    .ImmExt(ImmExt)
    );
    
    // Control logic for LDR instruction
    always_comb begin
    aluCtrl = 2'b00;
    RegWrite = 1'b1;
    end
    
endmodule
