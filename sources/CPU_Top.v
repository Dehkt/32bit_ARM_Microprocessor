`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2024 07:02:25 AM
// Design Name: 
// Module Name: CPU_Top
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


module CPU_Top(
    input clk,
    input rst
);

    wire [31:0] PC, PCPrime, Instr, RD1, RD2, ImmExt, SrcA, SrcB, ALUResult, ReadData, Result;
    wire [3:0] RA1, RA2, Rd, ALUFlags;
    wire [23:0] Imm;
    wire [1:0] ALUControl, RegSrc;
    wire Zero, Negative, Carry, OverFlow, WE, PCSrc, WE3, MemtoReg;
    

    // Program Counter
    ProgramCount PC_Inst(
        .clk(clk),
        .rst(rst),
        .PCPrime(PCPrime),  // Input from Mux1
        .PC(PC)
    );

    InstrMem InstrMem_Inst(
        .A(PC[7:0]),       // Address is in Instruction Encoding
        .RD(Instr)
    );


    // Sign-extend Immediate
    Extender ImmExt_Inst(
        .Imm(Imm),
        .ImmExt(ImmExt),
        .ImmSrc(ImmSrc)
    );

    // Register File
    RegFile RegFile_Inst(
        .A1(RA1),             // Rn
        .A2(RA2),            // Rd
        .A3(Rd),            // Rd
        .WD3(Result),       // Result from Datamem
        .PC(PC),            // Current PC for R15 (special case)
        .WE3(WE3),         // Write enable, handle with combinational logic later
        .clk(clk),
        .rst(rst),
        .RD1(RD1),          // Data from source register 
        .RD2(RD2)           // Data from destination register 
    );


    // ALU
    ALU ALU_Inst(
        .SrcA(SrcA),        // Operand A
        .SrcB(SrcB),        // Operand B
        .ALUControl(ALUControl), // ALU operation type
        .ALUResult(ALUResult),   // ALU result
        .Zero(Zero),
        .Negative(Negative),
        .Carry(Carry),
        .Overflow(Overflow)
    );
    

    // Data Memory
    DataMem DataMem_Inst(
        .clk(clk),
        .rst(rst),
        .WE(WE),         
        .A(ALUResult[7:0]), // Address from ALU result
        .WD(RD2),         
        .RD(ReadData)       // Read data from memory
    );

    // Mux1, Chooses between PCPlus4 and Branch Target Address
    Mux1 Mux1_Inst(
        .ReadData(Result), // Branch target address
        .PC(PC),            // Current PC
        .PCSrc(PCSrc),      // Control signal
        .PCPrime(PCPrime)   // New PC
    );
    
    // Mux2, Chooses between ReadData and ALUResult as Result.
    Mux2 Mux2_Inst(
        .ReadData(ReadData),
        .ALUResult(ALUResult),
        .MemtoReg(MemtoReg),
        .Result(Result)
    );
    
    // Mux3, Chooses between Rm and Rd for input A2 of Register File, used for Register Addressing or Imm Addressing
    Mux3 Mux3_Inst(
    .Rm(Rm),
    .Rd(Rd),
    .RA2(RA2),
    .RegSrc(RegSrc[1])
    );
    
    // Mux4, Chooses between Data from RD2 Line or Extended Immediate for SrcB in ALU.
    Mux4 Mux4_Inst(
    .RD2(RD2),
    .ExtImm(ImmExt),
    .ALUSrc(ALUSrc),
    .SrcB(SrcB)
    );
    
    // Mux5, chooses between Rn and 15 for RA1 Register File A1 input.
    Mux5 Mux5_Inst(
    .Rn(Rn),
    .RegSrc0(RegSrc[0]),
    .RA1(RA1)
    );
    
    ControlUnit ControlUnit_Inst(
    .clk(clk),
    .Flags(Flags), 
    .Cond(Cond),
    .Op(Op),
    .Funct(Funct),
    .Rd(Rd),
    .RegSrc(RegSrc),
    .ALUControl(ALUControl),
    .PCSrc(PCSrc),
    .MemtoReg(MemtoReg),
    .MemWrite(WE),
    .ALUSrc(ALUSrc),
    .ImmSrc(ImmSrc),
    .RegWrite(WE3)
    );
    
    // Combining ALUFlags into one 4-bit signal for Control unit to interperet
    assign Flags = {Zero, Negative, Carry, Overflow};
    
    // Control Unit Inputs
    assign Cond = Instr[31:28];
    assign Op = Instr[27:26];
    assign Funct = Instr[25:20];
    assign Rd = Instr[15:12];
    
   
    // Reg File and Sign Extender Inputs
    assign Rn = Instr[19:16]; 
    assign Rd = Instr[15:12];  
    assign Rm = Instr[3:0];    
    assign Imm = Instr[23:0]; 
    
    // ALU Input
    assign SrcA = RD1; 
   
    
endmodule
