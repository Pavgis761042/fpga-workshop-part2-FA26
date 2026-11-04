// 4-bit shift register

module reg_4 (
    input  logic       Clk,
    input  logic       Reset,
    input  logic       Shift_In,
    input  logic       Load,
    input  logic       Shift_En,
    input  logic [3:0] D,

    output logic       Shift_Out,
    output logic [3:0] Data_Out
);

    logic [3:0] Data_Out_d;

    always_comb begin
        if (Load)
            Data_Out_d = D;
        else if (Shift_En)
            Data_Out_d = {Shift_In, Data_Out[3:1]};
        else
            Data_Out_d = Data_Out;
    end

    always_ff @(posedge Clk) begin
        if (Reset)
            Data_Out <= 4'h0;
        else
            Data_Out <= Data_Out_d;
    end

    assign Shift_Out = Data_Out[0];

endmodule
