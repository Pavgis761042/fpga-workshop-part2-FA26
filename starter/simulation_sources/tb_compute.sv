// Testbench for compute

module tb_compute();

timeunit 1ns;
timeprecision 1ps;

logic [1:0] op;
logic       a;
logic       b;
logic       y;

compute dut (.*);

initial begin : TEST_VECTORS

    // write here

    $finish();
end

endmodule
