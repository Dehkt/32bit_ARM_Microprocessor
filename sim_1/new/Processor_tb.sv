`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2024 06:35:55 PM
// Design Name: 
// Module Name: Processor_tb
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


module Processor_tb;
    logic clk;
    logic rst;

    Processor dut(
        .clk(clk),
        .rst(rst)
    );

    logic [31:0] PC;
    logic [31:0] PCPlus4;
    logic [31:0] instruction;
    logic [31:0] ImmExt;
    logic [31:0] RegData1;
    logic [31:0] RegData2;
    logic [31:0] aluResult;
    logic [31:0] readData;
    logic [1:0]  aluCtrl;
    logic        RegWrite;
    logic [31:0] PCPlus8;
    logic [31:0] PCin;
    logic PCSrc;
    logic RegWrite;
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
    
    RegisterFile regFile_inst(
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


    DataMemory dataMem_inst(
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

    // Clock generation
    initial begin
        clk = 0;
        forever #15 clk = ~clk;
    end

    // Test procedure
    initial begin
        // Reset the processor
        rst = 1;
        #15;
        rst = 0;
       RegWrite = 1'b1;
       WE = 1'b0;
       PCSrc = 1'b1;
       aluCtrl = 2'b00;
        //instrMem_inst.mem[4] = 32'b1110_0101_0001_0001_0011_0000_0000_0100; // LDR R3, [R1, #4]
        // R1 Is read as the starting address, #4 is added to it, the data is read from R1 + #4, and then stored in R2.
        // R3 is register 3, R1 is Register 1. 15:12 is destination register
        regFile_inst.regfile[1] = 4'b1111; // R1
        
        // Result of Addition of Register value (15) and 4 should be 19.
        dataMem_inst.mem[19] = 8'b11111111; //Loaded value at mem[19]

        // Monitor signals
        $monitor("Time: %0t | PC: %0h | Instruction: %0h | RegData1: %0h | ImmExt: %0h | aluResult: %0h | readData: %0h",
                 $time, PC, instruction[19:16], RegData1, ImmExt, aluResult, regFile_inst.regfile[3]);
        
        #30;
        PCSrc = 1'b0;
        // Execute first instruction
        #10;  // Wait for 1 clock cycle
        // Execute second instruction
        #10;  // Wait for 1 clock cycle
           
        // Finish the simulation
        #50;
        for (int i = 0; i < 16; i++) begin
            $display("Element [%0d]: %0d", i, regFile_inst.regfile[i]);
        end
        #20;
        $finish;
    end
endmodule
