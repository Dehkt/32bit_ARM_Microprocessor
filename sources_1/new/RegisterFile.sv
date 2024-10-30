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
                    input logic [31:0] PCout,
                    output logic [31:0] RD1,
                    output logic [31:0] RD2 
    );
    
    logic [31:0] regfile [0:15]; // R0-R15 registers

    always_comb begin
        RD1 = (A1 == 4'd15) ? (PCout + 4) : regfile[A1]; // R15 returns PC + 8
        RD2 = (A2 == 4'd15) ? (PCout + 4) : regfile[A2]; // R15 returns PC + 8
    end

    // Write logic
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            for(int i = 0; i < 16; i++) begin 
                regfile[i] <= 32'b0;
            end
        end else begin
            if (WE3 && (A3 < 16)) begin 
                if (A3 == 4'd15) begin
                    regfile[15] <= PCout + 4;
                end else begin
                    regfile[A3] <= WD3;
                end
            end
        end
    end

endmodule
