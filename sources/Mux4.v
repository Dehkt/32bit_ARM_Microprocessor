`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2024 05:11:45 AM
// Design Name: 
// Module Name: Mux4
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


module Mux4(
    input      [31:0]  RD2,
    input      [31:0]  ExtImm,
    input              ALUSrc,
    output reg [31:0]  SrcB
    );
    
    always @(*) begin
        if (ALUSrc == 0) begin
            SrcB = RD2;
        end else begin
            SrcB = ExtImm;
        end
    end
    
endmodule