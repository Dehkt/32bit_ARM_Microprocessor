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


    wire [31:0] PC, PCPrime, Instr, RD1, RD2, ImmExt, SrcA, SrcB, ALUResult, ReadData;
    wire [4:0] A1, A2, A3;
    wire [11:0] Imm;
    wire [1:0] ALUControl;
    wire Zero, WE, PCSrc, WE3;
    

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
        .ImmExt(ImmExt)
    );

    // Register File
    RegFile RegFile_Inst(
        .A1(A1),            // Rn1
        .A2(A2),          // Rn2
        .A3(A3),            // Rd
        .WD3(ReadData),     // ReadData from Data Mem
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
        .Zero(Zero)             // Zero flag
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

    
    Mux1 Mux_Inst(
        .ReadData(ReadData), // Branch target address
        .PC(PC),            // Current PC
        .PCSrc(PCSrc),      // Control signal
        .PCPrime(PCPrime)   // New PC
    );
    
    // Part selecting from Instr
    assign A1 = Instr[19:16];  // Rn
    assign A2 = Instr[15:12];  // Connected to Port 2 and 3
    assign A3 = Instr[15:12];  // Rd
    assign Imm = Instr[11:0];  // Imm, changed to either 11:0 or 7:0 depending on Instr

    // ALU Inputs
    assign SrcA = RD1;       // SrcA (from RD1)
    assign SrcB = ImmExt;    // SrcB (extended immediate)
    
    // Signals
    assign ALUControl = 2'b00;  // ADD operation, handle with combinational logic later
    assign WE = 1'b1; // Write Enable for STR Testing
    assign WE3 = 1'b0;
endmodule
