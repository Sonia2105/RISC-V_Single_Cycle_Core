`include "Instruction_Memory.v"
`include "Sign_Extend.v"
`include "ALU1.v"
`include "Control_Unit.v"
`include "Data_Memory.v"
`include "PC_Adder.v"
`include "Register_File.v"
`include "PC.v"

module Single_Cycle_top(clk, rst);

input clk, rst;

    // Wires
    wire [31:0] PC_Top, RD_Instr, RD1_Top, Imm_Ext_Top, ALUResult, ReadData, PCPlus4, RD2_Top, SrcB, Result;
    wire RegWrite, MemWrite, ALUSrc, ResultSrc;
    wire [1:0] ImmSrc;
    wire [2:0] ALUControl_Top;

    // Program Counter
    PC PC_inst(
        .clk(clk),
        .rst(rst),
        .PC(PC_Top),
        .PC_Next(PCPlus4)
    );

    // PC Adder
    PC_Adder PCAdder_inst(
        .a(PC_Top),
        .b(32'd4),
        .c(PCPlus4)
    );
    
    // Instruction Memory
    Instr_Mem InstrMem_inst(
        .rst(rst),
        .A(PC_Top),
        .RD(RD_Instr)
    );

    // Register File
    Reg_file RegFile_inst(
        .clk(clk),
        .rst(rst),
        .WE3(RegWrite),
        .WD3(ReadData),
        .A1(RD_Instr[19:15]),
        .A2(RD_Instr[24:20]),
        .A3(RD_Instr[11:7]),
        .RD1(RD1_Top),
        .RD2(RD2_Top)
    );

    // Sign Extend
    Sign_Extend SignExt_inst(
        .In(RD_Instr),
        .Imm_Ext(Imm_Ext_Top)
    );



    // ALU
    ALU ALU_inst(
        .A(RD1_Top),
        .B(Imm_Ext_Top),
        .Result(ALUResult),
        .ALUControl(ALUControl_Top),
        .OverFlow(),
        .Carry(),
        .Zero(),
        .Negative()
    );

    // Control Unit
    Control_Unit CU_inst(
        .Op(RD_Instr[6:0]),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .Branch(),
        .funct3(RD_Instr[14:12]),
        .funct7(RD_Instr[6:0]),
        .ALUControl(ALUControl_Top)
    );

    // Data Memory
    Data_Memory DM_inst(
        .clk(clk),
        .rst(rst),
        .WE(MemWrite),
        .WD(RD2_Top),
        .A(ALUResult),
        .RD(ReadData)
    );

    

endmodule
