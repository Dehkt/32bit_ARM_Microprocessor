`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2024 08:14:35 PM
// Design Name: 
// Module Name: RegisterFile
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


module RegisterFile(
                    input logic        clk,
                    input logic        rst,
                    input logic [3:0]  A1,
                    input logic [3:0]  A2,
                    input logic [3:0]  A3,
                    input logic [31:0] WD3,
                    input logic        WE3,
                    input logic        R15,
                    output logic       RD1,
                    output logic       RD2
                    
    );
    
logic [31:0] regfile [0:15]; // R0-R14, R15 is received from PC

always_ff @(posedge clk or posedge rst) begin
if (rst) begin
    for(int i = 0; i < 15; i++) begin
        regfile[i] <= 32'b0;
    end
    // Reset all registers 
end else begin
    if (WE3 && A3 < 15) begin
        regfile[A3] <= WD3;
    end
  end
end
endmodule
