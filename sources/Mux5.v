`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2024 05:29:35 AM
// Design Name: 
// Module Name: Mux5
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


module Mux5(
    input      [3:0]  Rn,
    input             RegSrc0,
    output reg [3:0]  RA1
    );
    
    always @(*) begin
        if (RegSrc0 == 1) begin
            RA1 = 4'b1111;
        end else begin
            RA1 = Rn;
        end
    end
    
endmodule