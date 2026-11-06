// 4-bit ALU top level

module alu_top (
    input  logic        clk,
    input  logic [3:0]  btn,
    input  logic [15:0] sw,

    output logic [15:0] led,
    output logic [7:0]  hex_segA,
    output logic [3:0]  hex_gridA,
    output logic [7:0]  hex_segB,
    output logic [3:0]  hex_gridB
);

    logic       Reset_SH, LoadA_SH, LoadB_SH, Execute_SH;
    logic [3:0] Din_S;
    logic [2:0] op_S;

    logic Ld_A, Ld_B, Shift_En, Ld_Out;

    logic [3:0] A, B, R;
    logic       A_bit, B_bit, gate_bit;
    logic [7:0] arith_y;
    logic [7:0] result;

    sync_debounce button_sync [3:0] (
        .Clk (clk),
        .d   (btn),
        .q   ({Reset_SH, LoadB_SH, LoadA_SH, Execute_SH})
    );

    sync_debounce din_sync [3:0] (
        .Clk (clk),
        .d   (sw[3:0]),
        .q   (Din_S)
    );

    sync_debounce op_sync [2:0] (
        .Clk (clk),
        .d   (sw[15:13]),
        .q   (op_S)
    );

    control control_unit (
        .Clk      (clk),
        .Reset    (Reset_SH),
        .LoadA    (LoadA_SH),
        .LoadB    (LoadB_SH),
        .Execute  (Execute_SH),
        .op       (op_S),
        .Ld_A     (Ld_A),
        .Ld_B     (Ld_B),
        .Shift_En (Shift_En),
        .Ld_Out   (Ld_Out)
    );

    register_unit reg_unit (
        .Clk      (clk),
        .Reset    (Reset_SH),
        .Ld_A     (Ld_A),
        .Ld_B     (Ld_B),
        .Shift_En (Shift_En),
        .D        (Din_S),
        .A_out    (A_bit),
        .B_out    (B_bit),
        .A        (A),
        .B        (B)
    );

    compute compute_unit (
        .op (op_S[1:0]),
        .a  (A_bit),
        .b  (B_bit),
        .y  (gate_bit)
    );

    reg_4 reg_R (
        .Clk       (clk),
        .Reset     (Reset_SH),
        .Shift_In  (gate_bit),
        .Load      (1'b0),
        .Shift_En  (Shift_En),
        .D         (4'h0),
        .Shift_Out (),
        .Data_Out  (R)
    );

    arith arith_unit (
        .op (op_S[1:0]),
        .a  (A),
        .b  (B),
        .y  (arith_y)
    );

    reg_8 reg_out (
        .Clk      (clk),
        .Reset    (Reset_SH),
        .Load     (Ld_Out),
        .D        (op_S[2] ? {4'h0, R} : arith_y),
        .Data_Out (result)
    );

    assign led = {8'h00, result};

    HexDriver hex_A (
        .clk      (clk),
        .reset    (Reset_SH),
        .in       ('{{3'b0, A[0]}, {3'b0, A[1]}, {3'b0, A[2]}, {3'b0, A[3]}}),
        .hex_seg  (hex_segA),
        .hex_grid (hex_gridA)
    );

    HexDriver hex_B (
        .clk      (clk),
        .reset    (Reset_SH),
        .in       ('{{3'b0, B[0]}, {3'b0, B[1]}, {3'b0, B[2]}, {3'b0, B[3]}}),
        .hex_seg  (hex_segB),
        .hex_grid (hex_gridB)
    );

endmodule
