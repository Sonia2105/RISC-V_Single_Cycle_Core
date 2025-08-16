module Reg_file(
    input [4:0] A1, A2, A3,
    input [31:0] WD3,
    input WE3, clk, rst,
    output reg [31:0] RD1, RD2
);

    reg [31:0] Registers [31:0];

    // Combinational read
    always @(*) begin
        if (!rst) begin
            RD1 = 32'h00000000;
            RD2 = 32'h00000000;
        end else begin
            RD1 = Registers[A1];
            RD2 = Registers[A2];
        end
    end

    // Sequential write
    always @(posedge clk) begin
        if (!rst) begin
            Registers[0] <= 32'h00000000; // optional: reset x0
        end else begin
            if (WE3) begin
                Registers[A3] <= WD3;
            end
        end
    end
    initial begin
        Registers[9] = 32'h00000020;
    end
    

endmodule
