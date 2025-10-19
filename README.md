# Signed-Multiplier
Parameterized signed multiplier in Verilog supporting two’s complement numbers, generates partial products, applies correction for negatives, and includes an exhaustive testbench.
Authior: Sarthak Kumar

Overview

  This repository contains a parameterized signed multiplier written in Verilog.
  It multiplies two signed numbers of configurable widths using partial products and two’s complement handling for negative numbers. The design is modular, readable, and suitable for FPGA/ASIC implementation or    learning purposes.

**Module: multiplier.v**

**Parameters**

  - M : Width of the signed multiplicand A (default = 3)
  
  - N : Width of the signed multiplier B (default = 2)

**Inputs**

  - A : M-bit signed multiplicand
  
  - B : N-bit signed multiplier

**Outputs**

  - P : (M+N)-bit signed product

**Theory**

Signed multiplication in two’s complement representation requires special handling of the most significant bits (MSBs):

 **Partial Products**
  
  - Each bit of B is ANDed with each bit of A to generate a partial product.
    
  - The MSBs of A and B are adjusted to handle negative numbers correctly.
    
  - Two’s Complement Adjustment:
    
    * In two’s complement, negative numbers have the MSB set to 1.
    
    * During multiplication, partial products involving MSBs are modified:
    
    * If only one operand’s MSB is 1, invert the other operand’s bits.
    
    * If both MSBs are involved, apply correction terms to avoid overflow.
    
    - After summing all partial products, additional correction terms are added to produce the correct signed product.
    
- Final Product:
    
    * The sum of shifted partial products plus correction terms gives the correctly signed result P.
    
    * This ensures that multiplication works for all positive and negative inputs correctly.

**Schematic**

<img width="1891" height="389" alt="signed multiplier" src="https://github.com/user-attachments/assets/6d0b5587-8a9c-458c-813d-e34dac61e29e" />

**Testbench: tb.v**

  The testbench verifies the signed multiplier by exhaustively testing all possible input combinations:
  
  - Loops over all values of A and B (both signed).
  
  - Applies a small delay (#5) between each input combination.
  
  - Monitors and prints the inputs and resulting product.
  
  - Dumps simulation data to a .vcd file for waveform analysis.
  
  - This guarantees correctness for all input combinations of defined widths.

**Example Output**

                   0  |  A =  x  |  B =  x  |  P =   x
                   5  |  A =  0  |  B =  0  |  P =   0
                   
                  10  |  A =  0  |  B =  1  |  P =   0
                  
                  15  |  A =  0  |  B = -2  |  P =   0
                  
                  20  |  A =  0  |  B = -1  |  P =   0
                  
                  25  |  A =  1  |  B =  0  |  P =   0
                  
                  30  |  A =  1  |  B =  1  |  P =   1
                  
                  35  |  A =  1  |  B = -2  |  P =  -2
                  
                  40  |  A =  1  |  B = -1  |  P =  -1
                  
                  45  |  A =  2  |  B =  0  |  P =   0
                  
                  50  |  A =  2  |  B =  1  |  P =   2
                  
                  55  |  A =  2  |  B = -2  |  P =  -4
                  
                  60  |  A =  2  |  B = -1  |  P =  -2
                  
                  65  |  A =  3  |  B =  0  |  P =   0
                  
                  70  |  A =  3  |  B =  1  |  P =   3
                  
                  75  |  A =  3  |  B = -2  |  P =  -6
                  
                  80  |  A =  3  |  B = -1  |  P =  -3
                  
                  85  |  A = -4  |  B =  0  |  P =   0
                  
                  90  |  A = -4  |  B =  1  |  P =  -4
                  
                  95  |  A = -4  |  B = -2  |  P =   8
                  
                 100  |  A = -4  |  B = -1  |  P =   4
                 
                 105  |  A = -3  |  B =  0  |  P =   0
                 
                 110  |  A = -3  |  B =  1  |  P =  -3
                 
                 115  |  A = -3  |  B = -2  |  P =   6
                 
                 120  |  A = -3  |  B = -1  |  P =   3
                 
                 125  |  A = -2  |  B =  0  |  P =   0
                 
                 130  |  A = -2  |  B =  1  |  P =  -2
                 
                 135  |  A = -2  |  B = -2  |  P =   4
                 
                 140  |  A = -2  |  B = -1  |  P =   2
                 
                 145  |  A = -1  |  B =  0  |  P =   0
                 
                 150  |  A = -1  |  B =  1  |  P =  -1
                 
                 155  |  A = -1  |  B = -2  |  P =   2
                 
                 160  |  A = -1  |  B = -1  |  P =   1

**Features**

  - Fully parameterized (adjust M and N).
  
  - Handles signed multiplication using two’s complement.
  
  - Exhaustive testbench for verification.
  
  - Ready for FPGA or ASIC simulation.
                   
