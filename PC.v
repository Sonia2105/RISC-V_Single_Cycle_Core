module PC(PC_Next, PC, rst, clk);
input [31:0] PC_Next;
input rst, clk;
output reg [31:0] PC;

always @(posedge clk ) begin
    if (rst== 1'b0) begin
        PC <= 32'h00000000;
    end 
    else 
    begin
        PC <= PC_Next;
    end
end
endmodule