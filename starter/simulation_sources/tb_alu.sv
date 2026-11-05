// Testbench for alu_top

module tb_alu();

timeunit 1ns;
timeprecision 1ps;

logic        clk = 1'b0;
logic [3:0]  btn = 4'b0000;
logic [15:0] sw  = 16'h0000;

logic [15:0] led;
logic [7:0]  hex_segA, hex_segB;
logic [3:0]  hex_gridA, hex_gridB;

alu_top dut (.*);

always #5 clk = ~clk;

task automatic press(input int b);
    btn[b] = 1'b1;
    repeat (8) @(posedge clk);
    btn[b] = 1'b0;
endtask

initial begin : TEST_VECTORS

    press(3);
    repeat (10) @(posedge clk);

    // write here: set sw[3:0] to A
    repeat (5) @(posedge clk);
    // write here: press(1)
    repeat (10) @(posedge clk);

    // write here: set sw[3:0] to B
    repeat (5) @(posedge clk);
    // write here: press(2)
    repeat (10) @(posedge clk);

    // write here: set sw[15:13] to the op
    repeat (5) @(posedge clk);
    // write here: press(0)
    repeat (10) @(posedge clk);

    $display("A = %b  B = %b  op = %b  result = %b", dut.A, dut.B, sw[15:13], led[7:0]);

    $finish();
end

endmodule
