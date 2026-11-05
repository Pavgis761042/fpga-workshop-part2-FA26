// Testbench for alu_top

module tb_alu();

timeunit 1ns;       // #1 = 1 ns
timeprecision 1ps;

// One signal for every port of alu_top
logic        clk;
logic [3:0]  btn;
logic [15:0] sw;
logic [15:0] led;
logic [7:0]  hex_segA, hex_segB;
logic [3:0]  hex_gridA, hex_gridB;

alu_top dut (.*); //here we copy all of our logic to those in alu_top as they have the same name.

initial begin: CLOCK_INITIALIZATION
    clk = 1'b0;
end

// #5 high, #5 low = 10 ns period = 100 MHz, same as the board
always begin: CLOCK_GENERATION
    #5 clk = ~clk;
end

initial begin: TEST_VECTORS
    // Reset
    btn = 4'b1000;
    sw  <= 16'h0000;
    repeat (6) @(posedge clk);
    btn[3] <= 0;
    repeat (6) @(posedge clk);

    // Load A
    // write here: set A to 0011 and press load A
    repeat (6) @(posedge clk);      // hold the button for the debouncer
    // write here: release load A
    repeat (6) @(posedge clk);

    // Load B
    // write here: set B to 0110 and press load B
    repeat (6) @(posedge clk);
    // write here: release load B
    repeat (6) @(posedge clk);

    // Compute
    // write here: set the opcode to XOR
    repeat (6) @(posedge clk);      // let the switches settle before pressing
    // write here: press compute
    repeat (10) @(posedge clk);     // FSM runs while the button is held
    // write here: release compute
    repeat (10) @(posedge clk);

    // write here: check that the result is 0011 XOR 0110

    $finish();
end

endmodule
