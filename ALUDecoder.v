module ALUDecoder(ALUOp, Op, Funct3, Funct7, ALUControl);
    // Inputs
    input [1:0] ALUOp;
    input [2:0] Funct3;
    input [6:0] Funct7;
    input [6:0] Op;
    // Outputs
    output reg [2:0] ALUControl;

    always @(*) begin
        case (ALUOp)
            2'b00: ALUControl = 3'b000; // Load/Store
            2'b01: ALUControl = 3'b001; // Branch
            2'b10: begin
                case (Funct3)
                    3'b000: ALUControl = ({Op[5], Funct7[5]} == 2'b11) ? 3'b001 : 3'b000; // ADD/SUB
                    3'b111: ALUControl = 3'b010; // AND
                    3'b110: ALUControl = 3'b011; // OR
                    3'b010: ALUControl = 3'b101; // SLT
                    default: ALUControl = 3'b000;
                endcase
            end
            default: ALUControl = 3'b000;
        endcase
    end
endmodule
