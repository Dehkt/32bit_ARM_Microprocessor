`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2024 04:44:54 AM
// Design Name: 
// Module Name: InstrMem
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


module InstrMem(
    input [7:0] A,        // 8-bit Address input to select the instruction
    output reg [31:0] RD  // 32-bit Instruction output
);

    // Memory array of 256, 32 bit wide instructions
    reg [31:0] mem [0:255];
    
    always @(*) begin // Combinational logic
        RD = mem[A];
    end

    initial begin // Instruction initialization for TB
        mem[0] = 32'b11100101001100010010000000000100; 
        mem[4] = 32'b11100101001100010010000000000100; 
        mem[8] = 32'b11100101001100010010000000000100; 
    end

endmodule