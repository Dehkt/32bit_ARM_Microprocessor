`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2024 08:14:35 PM
// Design Name: 
// Module Name: ProgramCounter
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


module ProgramCounter(
                      input  logic        clk,
                      input  logic        rst,
                      input  logic [31:0] PCin, 
                      output logic [31:0] PCout
  );
  
always_ff @(posedge clk or posedge rst) begin
    if(rst) begin
    PCout <= 32'd0;
    end else begin
    PCout <= PCin;
    end
end

endmodule
