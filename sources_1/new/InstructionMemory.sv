`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2024 08:24:25 PM
// Design Name: 
// Module Name: InstructionMemory
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


module InstructionMemory(
                         input  logic [31:0] address,
                         output logic [31:0] instruction             
    );
   
logic [31:0] mem [0:255];

always_comb begin
    instruction = mem[address >> 2];
end

initial begin
   mem[0] = 32'b1110_0101_0001_0001_0011_0000_0000_0100;
   mem[3] = 32'b1110_0101_0001_1111_0011_0000_0000_0100;
   mem[2] = 32'b1110_0101_0001_0001_0011_0000_0000_0100;
   mem[1] = 32'b1110_0101_0001_0001_0011_0000_0000_0100;
   mem[4] = 32'b1110_0101_0001_0001_0011_0000_0000_0100;
end

endmodule
