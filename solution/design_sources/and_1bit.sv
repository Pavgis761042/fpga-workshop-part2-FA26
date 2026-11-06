// 1-bit AND gate

module and_1bit (
    input  logic a,
    input  logic b,
    output logic y
);
    assign y = a & b;
endmodule
