pragma circom 2.1.4;

// Input 3 values using 'a'(array of length 3) and check if they all are equal.
// Return using signal 'c'.

include "../node_modules/circomlib/circuits/comparators.circom";

template Equality() {
   signal input a[3];
   signal output c;
  
   var d= a[0]-a[1];
   var e= a[1]-a[2];
   
   component isZ_d = IsZero();
   component isZ_e = IsZero();
   
   d ==> isZ_d.in;
   e ==> isZ_e.in;

   c <== isZ_d.out * isZ_e.out; 

}


component main = Equality();