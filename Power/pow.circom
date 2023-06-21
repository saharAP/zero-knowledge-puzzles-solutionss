pragma circom 2.1.4;

// Create a circuit which takes an input 'a',(array of length 2 ) , then  implement power modulo 
// and return it using output 'c'.

// HINT: Non Quadratic constraints are not allowed. 
include "../node_modules/circomlib/circuits/comparators.circom";

template Pow() {
   
   signal input a[2];
   signal output c;
   
  var maximumPow=255;
   component eq[maximumPow];
   signal pow[maximumPow];
   signal prod[maximumPow];
   

   for (var i=0; i<maximumPow; i++) {
      eq[i] = IsEqual();
      i==> eq[i].in[0];
      a[1]==> eq[i].in[1];
   }
   pow[0]<==1;
   for (var i=1; i<maximumPow; i++) {
      pow[i] <== pow[i-1]* a[0];
         
   }

   for (var i=0; i<maximumPow; i++) {
      prod[i] <== pow[i]* eq[i].out;
         
   }
   var result=0;
   for (var i=0; i<maximumPow; i++) {
      
      result+=prod[i];
         
   }
   c<== result;
}

component main = Pow();

