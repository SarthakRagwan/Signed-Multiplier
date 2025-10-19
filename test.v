// ================================================================
// Testbench for Signed Multiplier Module
// Description: Exhaustively tests the parameterized signed multiplier
//              by iterating through all possible combinations of A and B.
// ================================================================

`timescale 10ns/1ns
`include "main.v"

module tb;
  // Parameters matching the signed multiplier
  parameter M = 3;
  parameter N = 2;

  // Testbench signals
  reg signed [M-1:0] A;           // Signed multiplicand
  reg signed [N-1:0] B;           // Signed multiplier
  wire signed [M+N-1:0] P;        // Signed product

  // Instantiate the signed multiplier module
  multiplier dut(A, B, P);

  initial begin
    // VCD dump for waveform viewing
    $dumpfile("file.vcd");
    $dumpvars(0, tb);

    // Monitor to print simulation values in console
    $monitor($time, "  |  A = %d  |  B = %d  |  P = %d", A, B, P);

    // Exhaustive test: iterate through all signed input combinations
    for (integer i = 0; i < (1 << M); i = i + 1) begin
      for (integer j = 0; j < (1 << N); j = j + 1) begin
        #5;         // Wait 5 time units before applying inputs
        A = i;      // Apply signed multiplicand
        B = j;      // Apply signed multiplier
      end
    end

    #5 $finish;    // End simulation after all tests
  end
endmodule