`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2024 04:44:54 AM
// Design Name: 
// Module Name: ProgramCount
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


module ProgramCount(
    input clk,
    input rst, 
    input [31:0] PCPrime,
    output reg [31:0] PC
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            PC <= 32'b0;
        end else begin
            PC <= PCPrime;
        end
    end

endmodule