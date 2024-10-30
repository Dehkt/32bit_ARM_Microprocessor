`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2024 08:14:35 PM
// Design Name: 
// Module Name: ImmediateExt
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


module ImmediateExt(
                    input  logic [11:0] InputAddr,
                    output logic [31:0] ImmExt
    );
 
always_comb begin
    assign ImmExt = {{20{InputAddr[11]}}, InputAddr};
end

endmodule
