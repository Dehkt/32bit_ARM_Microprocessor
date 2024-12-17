`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2024 04:44:54 AM
// Design Name: 
// Module Name: RegFile
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


module RegFile(
                input      [19:16] A1,
                input      [3:0]   A2, // Muxed with [3:0] or [15:12]
                input      [15:12] A3, 
                input      [31:0]  WD3,  // unsure of size yet
                input      [31:0]   PC,
                input              WE3,
                input              clk,
                input              rst,
                output reg [31:0]  RD1,
                output reg [31:0]  RD2
    );

reg [32:0] mem [15:0]; // 16 registers, each is 32 bits wide, R15 is its own input.
integer i;

//task dump_mem(); // Task for Seeing Register File Contents
//    integer j;
//    begin
//        $display("Register file contents:");
//        for (j = 0; j < 16; j = j + 1) begin
//            $display("R%d = %h", j, mem[j]);
//        end
//    end
//endtask

always @(posedge clk or posedge rst) begin
    if (rst) begin
        for (i = 0; i < 16; i = i + 1)
            mem[i] <= 32'b0; 
    end else if (WE3) begin
        mem[A3] <= WD3; // Write WD3 to the register from A3 (Destination Register)
    end
end


always @(*) begin
    if (A1 == 4'b1111) begin // case where R15 is addressed, return PC+8
        RD1 = PC + 8;
    end else begin
        RD1 = mem[A1]; // Otherwise assign Data from A1 address to RD1
    end

    if (A2 == 4'b1111) begin
         RD2 = PC + 8;  // Same operation for RD2, if R15 is addressed then return PC+8
    end else begin
         RD2 = mem[A2];
    end
    
      mem[1] = 4'b0010;
      mem[2] = 4'b1111;
end


endmodule