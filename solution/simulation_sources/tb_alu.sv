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

alu_top dut (.*);

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

    // Load A = 0011
    sw[3:0] <= 4'b0011;
    btn[1]  <= 1;
    repeat (6) @(posedge clk);      // hold the button for the debouncer
    btn[1]  <= 0;
    repeat (6) @(posedge clk);

    // Load B = 0110
    sw[3:0] <= 4'b0110;
    btn[2]  <= 1;
    repeat (6) @(posedge clk);
    btn[2]  <= 0;
    repeat (6) @(posedge clk);

    // A XOR B: 4 shift states fill R, then done loads it into the output
    sw[15:13] <= 3'b110;
    repeat (6) @(posedge clk);      // let the switches settle before pressing
    btn[0]  <= 1;
    repeat (10) @(posedge clk);     // FSM runs while the button is held
    btn[0]  <= 0;
    repeat (10) @(posedge clk);

    assert (led[7:0] == 8'b0000_0101) else $error("XOR ERROR: led is %b", led[7:0]);

    $finish();
end

endmodule
