`include "Main_decoder.v"
`include "ALUDecoder.v"

module Control_Unit(
    input [6:0] Op,
    input [2:0] funct3,
    input [6:0] funct7,
    output Branch,
    output RegWrite,
    output MemWrite,
    output ALUSrc,
    output [1:0] ImmSrc,
    output ResultSrc,
    output [2:0] ALUControl
);

    wire [1:0] ALUOp;

    // Instantiate Main_Decoder
    Main_Decoder MD(
        .Op(Op),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .ResultSrc(ResultSrc),
        .Branch(Branch),
        .ALUOp(ALUOp)
    );

    // Instantiate ALUDecoder
    ALUDecoder AD(
        .ALUOp(ALUOp),
        .Op(Op),
        .Funct3(funct3),
        .Funct7(funct7),
        .ALUControl(ALUControl)
    );

endmodule
