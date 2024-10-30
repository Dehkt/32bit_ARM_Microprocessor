`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/02/2024 04:59:12 AM
// Design Name: 
// Module Name: RegisterFile_tb
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


module RegisterFile_tb;

    // Inputs
    logic clk;
    logic rst;
    logic [3:0] A1;
    logic [3:0] A2;
    logic [3:0] A3;
    logic [31:0] WD3;
    logic WE3;
    logic R15;

    // Outputs
    logic [31:0] RD1;
    logic [31:0] RD2;

    // Instruction example: (LDR R2, [R1, #4])
    logic [31:0] instruction;

    // Instantiate the Register File module
    RegisterFile regFile_inst (
        .clk(clk),
        .rst(rst),
        .A1(A1),
        .A2(A2),
        .A3(A3),
        .WD3(WD3),
        .WE3(WE3),
        .R15(R15),
        .RD1(RD1),
        .RD2(RD2)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Testbench
    initial begin
        // Initialize inputs
        clk = 0;
        rst = 1;  // Hold reset high to initialize registers
        instruction = 32'b1110_0101_0001_0010_0000_0000_0000_0100; // LDR R2, [R1, #4]
        WE3 = 1'b0;  // Initially disable write enable
        R15 = 1'b0;
        A2 = 4'b0000; // A2 not used in this test

        // Wait for reset to initialize registers
        #10 rst = 0;

        // Step 1: Write to a register (simulate LDR instruction)
        A1 = instruction[19:16];  // A1 = Source register (R1)
        A3 = instruction[15:12];  // A3 = Destination register (R2)
        WD3 = 32'h12345678;       // Data to be written into R2
        WE3 = 1'b1;               // Enable writing to the register

        // Wait for one clock cycle to perform the write
        #10;

        // Step 2: Disable write enable and read back data from R2
        WE3 = 1'b0;

        // Wait for one clock cycle and read values from registers
        #10;

        // Step 3: Check values in source and destination registers
        $display("Source Register (R1) value: %h", RD1);
        $display("Destination Register (R2) value: %h", RD2);

        // Finish simulation
        #20;
        $finish;
    end

endmodule
