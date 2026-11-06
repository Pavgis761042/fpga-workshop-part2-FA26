// 8-bit output register

module reg_8 (
    input  logic       Clk,
    input  logic       Reset,
    input  logic       Load,
    input  logic [7:0] D,

    output logic [7:0] Data_Out
);

    always_ff @(posedge Clk) begin
        if (Reset)
            Data_Out <= 8'h00;
        else if (Load)
            Data_Out <= D;
    end

endmodule
