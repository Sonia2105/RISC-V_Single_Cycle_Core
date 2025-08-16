module Single_Cycle_tb();

reg clk=1'b1,rst;
Single_Cycle_top Single_Cycle_top (
    .clk(clk),
    .rst(rst)
);

initial begin
    $dumpfile("Single_Cycle.vcd");
    $dumpvars(0);
end

always
begin
     clk = ~clk;
     #50;
end

initial
begin
    rst <= 1'b0;
    #100;

    rst <= 1'b1;
    #300;
    $finish;
end

endmodule