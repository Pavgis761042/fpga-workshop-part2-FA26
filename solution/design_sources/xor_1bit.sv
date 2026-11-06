// 1-bit XOR gate

module xor_1bit (
    input  logic a,
    input  logic b,
    output logic y
);
    assign y = a ^ b;
endmodule
