// ================================================================
// Module Name   : multiplier (Signed Version)
// Description   : Parameterized signed multiplier in Verilog
//                 Multiplies an M-bit signed number 'A' with an
//                 N-bit signed number 'B' using partial products
//                 and two's complement adjustment for negative numbers.
// Parameters    : 
//     M : Width of input A (default 3)
//     N : Width of input B (default 2)
// Inputs        : 
//     A : M-bit signed multiplicand
//     B : N-bit signed multiplier
// Outputs       : 
//     P : (M+N)-bit signed product
// ================================================================

module multiplier(A, B, P);
  // Parameter declarations
  parameter M = 3;
  parameter N = 2;

  // Inputs
  input signed [M-1:0] A;
  input signed [N-1:0] B;

  // Partial products
  wire [M-1:0] pp [N-1:0];

  // Output
  output reg signed [M+N-1:0] P;

  // Generate partial products with signed bit adjustment
  genvar i,j;
  generate 
    for (i = 0; i < N; i = i + 1) begin : row
      for (j = 0; j < M; j = j + 1) begin : col
        // Adjust MSB for two's complement multiplication
        if (j == (M-1) && i != (N-1)) 
          assign pp[i][j] = A[j] & (~B[i]);
        else if (j != (M-1) && i == (N-1)) 
          assign pp[i][j] = (~A[j]) & B[i];
        else 
          assign pp[i][j] = A[j] & B[i];
      end
    end
  endgenerate

  // Sum partial products and apply two's complement adjustment
  integer k;
  always @(*) begin
    P = 0;
    for (k = 0; k < N; k = k + 1) begin
      P = P + (pp[k] << k);
    end
    // Correction for signed numbers (two's complement)
    P = P + (A[M-1] << (M-1)) + (B[N-1] << (N-1))
          + ((~A[M-1]) << (M+N-2)) + ((~B[N-1]) << (M+N-2))
          + (1 << (M+N-1));
  end
endmodule