`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2024 04:44:54 AM
// Design Name: 
// Module Name: DataMem
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


module DataMem(
    input clk,
    input rst,
    input WE,
    input [7:0] A,
    input [31:0] WD,
    output reg [31:0] RD
);

    
    reg [31:0] mem [0:255]; // Memory array of 256 locations, each 32 bits wide
    integer i;

    always @(posedge clk) begin
        if (WE) begin
            mem[A] <= WD;
        end
    end
    
    always @(posedge clk or posedge rst) begin
    if(rst) begin
        for (i = 0; i<256; i = i + 1)
            mem[i] <= 32'b0;
        end else if (WE) begin
            mem[A] <= WD;
        end
     end

    always @(*) begin
        RD <= mem[A];
//        mem[6] <= 8'b0011; // For Testing
    end
    

endmodule
