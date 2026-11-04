// Arithmetic unit

module arith (
    input  logic [1:0] op,
    input  logic [3:0] a,
    input  logic [3:0] b,
    output logic [7:0] y
);

    always_comb begin
        y = 8'h00;
        case (op)
            2'b00: y = a + b;
            // write here
            default: y = 8'h00;
        endcase
    end

endmodule
