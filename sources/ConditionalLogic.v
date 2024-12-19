`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2024 08:08:13 AM
// Design Name: 
// Module Name: ConditionalLogic
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


module ConditionalLogic(input clk,
                        input PCS,
                        input RegW,
                        input MemW,
                        input [1:0] FlagW,
                        input [3:0] Cond,
                        input [3:0] ALUFlags,
                        output reg PCSrc,
                        output reg RegWrite,
                        output reg MemWrite
    );
    reg CondEx;
    reg [3:0] Flags;

    // Sample the ALUFlags if FlagWrite is asserted
    always @(posedge clk) begin
        if (FlagW[1]) Flags[3:2] <= ALUFlags[3:2]; // Update N, Z flags
        if (FlagW[0]) Flags[1:0] <= ALUFlags[1:0]; // Update C, V flags
    end

    // Combinational logic to compute CondEx based on ARM Architecture
    always @(*) begin
        case (Cond)
            4'b0000: CondEx = Flags[2];                           // EQ: Z == 1
            4'b0001: CondEx = ~Flags[2];                          // NE: Z == 0
            4'b0010: CondEx = Flags[1];                           // CS/HS: C == 1
            4'b0011: CondEx = ~Flags[1];                          // CC/LO: C == 0
            4'b0100: CondEx = Flags[3];                           // MI: N == 1
            4'b0101: CondEx = ~Flags[3];                          // PL: N == 0
            4'b0110: CondEx = Flags[0];                           // VS: V == 1
            4'b0111: CondEx = ~Flags[0];                          // VC: V == 0
            4'b1000: CondEx = Flags[1] & ~Flags[2];               // HI: C == 1 and Z == 0
            4'b1001: CondEx = ~Flags[1] | Flags[2];               // LS: C == 0 or Z == 1
            4'b1010: CondEx = ~(Flags[3] ^ Flags[0]);             // GE: N == V
            4'b1011: CondEx = Flags[3] ^ Flags[0];                // LT: N != V
            4'b1100: CondEx = ~Flags[2] & ~(Flags[3] ^ Flags[0]); // GT: Z == 0 and N == V
            4'b1101: CondEx = Flags[2] | (Flags[3] ^ Flags[0]);   // LE: Z == 1 or N != V
            4'b1110: CondEx = 1;                                  // AL: Always
            default: CondEx = 0;                                  // Unpredictable condition
        endcase
    end

    always @(*) begin
        PCSrc = (PCS & CondEx);
        RegWrite = (RegW & CondEx);
        MemWrite = (MemW & CondEx);
    end
endmodule
