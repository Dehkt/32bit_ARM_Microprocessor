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
  
logic [31:0] tempPC;
 
always_ff @(posedge clk or posedge rst) begin
    if(rst) begin
    tempPC <= 32'd0;
    end else begin
    tempPC  <= PCin;
    end
end

assign PCout = tempPC;

endmodule
