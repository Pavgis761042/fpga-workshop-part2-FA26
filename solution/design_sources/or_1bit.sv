// 1-bit OR gate

module or_1bit (
    input  logic a,
    input  logic b,
    output logic y
);
    assign y = a | b;
endmodule
