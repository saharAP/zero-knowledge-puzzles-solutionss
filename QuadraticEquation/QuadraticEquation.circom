pragma circom 2.1.4;

include "../node_modules/circomlib/circuits/comparators.circom";

// Create a Quadratic Equation( ax^2 + bx + c ) verifier using the below data.
// Use comparators.circom lib to compare results if equal

include "../node_modules/circomlib/circuits/comparators.circom";

template QuadraticEquation() {
    signal input x;     // x value
    signal input a;     // coeffecient of x^2
    signal input b;     // coeffecient of x 
    signal input c;     // constant c in equation
    signal input res;   // Expected result of the equation
    signal output out;  // If res is correct , then return 1 , else 0 . 

    
	signal power <== x**2;
	signal ax2 <== a*power;
	signal result<== ax2+b*x+c;	
	
	component isE = IsEqual();
   
   result ==> isE.in[0];
   res ==> isE.in[1];
   
   out <== isE.out;
	
	
}

component main  = QuadraticEquation();



