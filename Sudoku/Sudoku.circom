pragma circom 2.1.4;

include "../node_modules/circomlib/circuits/comparators.circom";


/*
    Given a 4x4 sudoku board with array signal input "question" and "solution", check if the solution is correct.

    "question" is a 16 length array. Example: [0,4,0,0,0,0,1,0,0,0,0,3,2,0,0,0] == [0, 4, 0, 0]
                                                                                   [0, 0, 1, 0]
                                                                                   [0, 0, 0, 3]
                                                                                   [2, 0, 0, 0]

    "solution" is a 16 length array. Example: [1,4,3,2,3,2,1,4,4,1,2,3,2,3,4,1] == [1, 4, 3, 2]
                                                                                   [3, 2, 1, 4]
                                                                                   [4, 1, 2, 3]
                                                                                   [2, 3, 4, 1]

    "out" is the signal output of the circuit. "out" is 1 if the solution is correct, otherwise 0.                                                                               
*/


template Sudoku () {
    // Question Setup 
    signal input  question[16];
    signal input solution[16];
    signal output out;
    
    // Checking if the question is valid
    for(var v = 0; v < 16; v++){
        log(solution[v],question[v]);
        assert(question[v] == solution[v] || question[v] == 0);
    }
    
    var m = 0 ;
    component row1[4];
    for(var q = 0; q < 4; q++){
        row1[m] = IsEqual();
        row1[m].in[0]  <== question[q];
        row1[m].in[1] <== 0;
        m++;
    }
    3 === row1[3].out + row1[2].out + row1[1].out + row1[0].out;

    m = 0;
    component row2[4];
    for(var q = 4; q < 8; q++){
        row2[m] = IsEqual();
        row2[m].in[0]  <== question[q];
        row2[m].in[1] <== 0;
        m++;
    }
    3 === row2[3].out + row2[2].out + row2[1].out + row2[0].out; 

    m = 0;
    component row3[4];
    for(var q = 8; q < 12; q++){
        row3[m] = IsEqual();
        row3[m].in[0]  <== question[q];
        row3[m].in[1] <== 0;
        m++;
    }
    3 === row3[3].out + row3[2].out + row3[1].out + row3[0].out; 

    m = 0;
    component row4[4];
    for(var q = 12; q < 16; q++){
        row4[m] = IsEqual();
        row4[m].in[0]  <== question[q];
        row4[m].in[1] <== 0;
        m++;
    }
    3 === row4[3].out + row4[2].out + row4[1].out + row4[0].out; 
    
	// Write your solution from here.. Good Luck!
	
    // The sum of each columns elements must equal to 10

    signal col[4];
    signal row[4];

    component coleq[4];
    component roweq[4];
    
    for(var q=0; q<4; q++){

        var sum = 0;
        
        for(var w=0; w<4; w++){
			sum += solution[q+4*w];
			
        }

        col[q] <== sum;
        coleq[q] = IsEqual();
        coleq[q].in[0] <== col[q];
        coleq[q].in[1] <== 10;
    }
	 // The sum of each rows elements must equal to 10
	for(var q=0; q<4; q++){

		var sum = 0;
        
        for(var w=0; w<4; w++){

            sum += solution[4*q+w];

        }

        row[q] <== sum;
        roweq[q] = IsEqual();
        roweq[q].in[0] <== row[q];
        roweq[q].in[1] <== 10;
    }

    signal sum <== coleq[0].out + coleq[1].out + coleq[2].out + coleq[3].out + roweq[0].out + roweq[1].out + roweq[2].out + roweq[3].out;

    component iseq_sum = IsEqual();
    iseq_sum.in[0] <== sum;
    iseq_sum.in[1] <== 8;
	
	// compare first element of each column to not equal to other elements in the same column
	signal notEqual_cols[4];
	
    component notEqual_col0[3];
    for(var q = 0; q < 3; q++){
        notEqual_col0[q] = IsEqual();
        notEqual_col0[q].in[0]  <== solution[0];
        notEqual_col0[q].in[1] <== solution[4*(q+1)];
    }
    notEqual_cols[0] <== notEqual_col0[2].out + notEqual_col0[1].out + notEqual_col0[0].out; 
	
	component notEqual_col1[3];
    for(var q = 0; q < 3; q++){
        notEqual_col1[q] = IsEqual();
        notEqual_col1[q].in[0]  <== solution[1];
        notEqual_col1[q].in[1] <== solution[4*(q+1)+1];
    }
    notEqual_cols[1] <== notEqual_col1[2].out + notEqual_col1[1].out + notEqual_col1[0].out; 
	
	component notEqual_col2[3];
    for(var q = 0; q < 3; q++){
        notEqual_col2[q] = IsEqual();
        notEqual_col2[q].in[0]  <== solution[2];
        notEqual_col2[q].in[1] <== solution[4*(q+1)+2];
    }
    notEqual_cols[2] <== notEqual_col2[2].out + notEqual_col2[1].out + notEqual_col2[0].out;
	
	component notEqual_col3[3];
    for(var q = 0; q < 3; q++){
        notEqual_col3[q] = IsEqual();
        notEqual_col3[q].in[0]  <== solution[3];
        notEqual_col3[q].in[1] <== solution[4*(q+1)+3];
    }
    notEqual_cols[3] <== notEqual_col3[2].out + notEqual_col3[1].out + notEqual_col3[0].out;
	
	// compare first element of each row to not equal to other elements in the same row
	signal notEqual_rows[4];
	
	
	  component notEqual_row0[3];
    for(var q = 0; q < 3; q++){
        notEqual_row0[q] = IsEqual();
        notEqual_row0[q].in[0]  <== solution[0];
        notEqual_row0[q].in[1] <== solution[q+1];
    }
    notEqual_rows[0] <== notEqual_row0[2].out + notEqual_row0[1].out + notEqual_row0[0].out; 
	
	component notEqual_row1[3];
    for(var q = 0; q < 3; q++){
        notEqual_row1[q] = IsEqual();
        notEqual_row1[q].in[0]  <== solution[4];
        notEqual_row1[q].in[1] <== solution[4+q+1];
    }
    notEqual_rows[1] <== notEqual_row1[2].out + notEqual_row1[1].out + notEqual_row1[0].out; 
	
	component notEqual_row2[3];
    for(var q = 0; q < 3; q++){
        notEqual_row2[q] = IsEqual();
        notEqual_row2[q].in[0]  <== solution[8];
        notEqual_row2[q].in[1] <== solution[8+q+1];
    }
    notEqual_rows[2] <== notEqual_row2[2].out + notEqual_row2[1].out + notEqual_row2[0].out;
	
	component notEqual_row3[3];
    for(var q = 0; q < 3; q++){
        notEqual_row3[q] = IsEqual();
        notEqual_row3[q].in[0]  <== solution[12];
        notEqual_row3[q].in[1] <== solution[12+q+1];
    }

    notEqual_rows[3] <== notEqual_row3[2].out + notEqual_row3[1].out + notEqual_row3[0].out;
	//check for the rows 
	component isZ_rows = IsZero();
	
	isZ_rows.in<== notEqual_rows[0]+notEqual_rows[1]+notEqual_rows[2]+notEqual_rows[3]; 
	
	//check if for the columns 
	component isZ_cols = IsZero();
	
	isZ_cols.in<== notEqual_cols[0]+notEqual_cols[1]+notEqual_cols[2]+notEqual_cols[3]; 
	
    //

	//check all the requirements
	  component iseq_final = IsEqual();
	   iseq_final.in[0] <== iseq_sum.out+ isZ_cols.out + isZ_rows.out;
	   iseq_final.in[1] <== 3;
	   
    out <== iseq_final.out;
   
}


component main = Sudoku();
