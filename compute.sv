// 1-bit logic unit

module compute (
    input  logic [1:0] op,
    input  logic       a,
    input  logic       b,
    output logic       y
);

    logic y_and, y_or, y_xor, y_mystery;

    mystery_1bit g_mystery (
        .a (a),
        .b (b),
        .y (y_mystery)
    );

    // write here

    always_comb begin
        case (op)
            2'b11:   y = y_mystery;
            // write here
            default: y = 1'b0;
        endcase
    end

endmodule
