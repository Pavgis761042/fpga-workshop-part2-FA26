// Mystery gate

module mystery_1bit (
    input  logic a,
    input  logic b,
    output logic y
);
    assign y = (a & b) | (~a & ~b);
endmodule
