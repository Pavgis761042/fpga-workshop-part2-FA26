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

    and_1bit g_and (.a(a), .b(b), .y(y_and));
    or_1bit  g_or  (.a(a), .b(b), .y(y_or));
    xor_1bit g_xor (.a(a), .b(b), .y(y_xor));

    always_comb begin
        case (op)
            2'b11:   y = y_mystery;
            2'b00:   y = y_and;
            2'b01:   y = y_or;
            2'b10:   y = y_xor;
            default: y = 1'b0;
        endcase
    end

endmodule
