`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2024 08:14:35 PM
// Design Name: 
// Module Name: DataMemory
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


module DataMemory(
                  input logic         clk,
                  input logic         rst,
                  input logic         writeEn,
                  input logic  [31:0] address,
                  input logic  [31:0] writeData,
                  output logic [31:0] readData
    );
logic [31:0] mem [0:255];

always_ff @(posedge clk or posedge rst) begin
    if(rst) begin
    for(int i = 0; i < 256; i++) begin
        mem[i] <= 32'b0;
    end
   end else begin
   if(writeEn) begin
       mem[address[7:0]] <= writeData;
   end
 end
end

always_comb begin
    readData = mem[address[7:0]];
end

endmodule
