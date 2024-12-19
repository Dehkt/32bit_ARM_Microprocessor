`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2024 05:11:32 AM
// Design Name: 
// Module Name: Mux3
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


module Mux3(
    input      [3:0]  Rm,
    input      [4:0]  Rd,
    input             RegSrc,
    output reg [4:0]  RA2
    );
    
    always @(*) begin
        if (RegSrc == 0) begin
            RA2 = Rm;
        end else begin
            RA2 = Rd;
        end
    end
    
endmodule
