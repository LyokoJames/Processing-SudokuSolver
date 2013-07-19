void setup() {
  size(450,450);
  background(#FF8800);
  int[][] initialBoard = 
                  { {0,0,0,0,0,0,8,0,0},
                    {0,0,0,0,0,0,6,0,0},
                    {0,0,0,2,0,0,3,0,0},
                    {0,0,0,0,0,0,2,0,0},
                    {0,0,0,0,0,0,1,0,0},
                    {0,0,0,0,0,0,0,0,0},
                    {0,0,0,0,0,0,0,0,0},
                    {0,0,0,0,0,0,9,0,0},
                    {0,0,0,0,0,0,5,0,7} };
  sudokoBoard board = new sudokoBoard(initialBoard,1);
  board.iterateTillSolved();
  board.display();
}

void draw() {
  
}

class boardSquare {
  int myNumber;
  boolean[] possibleNumbers;
  
  boardSquare(int _number) {
    myNumber = _number;
    possibleNumbers = new boolean[9];
    if (_number != 0) {
      for (int i=0;i<9;i++)  {
        possibleNumbers[i] = false;
      }
      possibleNumbers[_number-1] = true;
    }
    else {
     for (int i=0;i<9;i++)  {
        possibleNumbers[i] = true;
      } 
    }
  }
  
  void checkPossibleNumbers() {
    int posNumNum = 0;
    for (int i=0;i<9;i++) {
      if (possibleNumbers[i] == true) posNumNum++;
    }
    if (posNumNum == 1) {
      for (int i=0;i<9;i++) {
        if (possibleNumbers[i] == true) myNumber = i+1;
      }
    }
  }
  
  void removePosNum(int _number) {
    possibleNumbers[_number-1] = false;
  }
  
}

class sudokoBoard {
 boardSquare[][] boardSquares;
 int[][] boardSquareBoxes = 
                  { {1,1,1,2,2,2,3,3,3},
                    {1,1,1,2,2,2,3,3,3},
                    {1,1,1,2,2,2,3,3,3},
                    {4,4,4,5,5,5,6,6,6},
                    {4,4,4,5,5,5,6,6,6},
                    {4,4,4,5,5,5,6,6,6},
                    {7,7,7,8,8,8,9,9,9},
                    {7,7,7,8,8,8,9,9,9},
                    {7,7,7,8,8,8,9,9,9} };
 int maxIterations;
 int iterations;
 
 sudokoBoard(int[][] _boardSqaures,int _maxIterations) {
   boardSquares = new boardSquare[9][9];
   for (int y=0;y<9;y++) {
     for (int x=0;x<9;x++) {
       boardSquares[y][x] = new boardSquare(_boardSqaures[y][x]);
     }
   }
   maxIterations = _maxIterations;
   iterations = 0;
 }
 void display() {
   rect(width*1/11,height*1/11,width*9/11,height*9/11);
   strokeWeight(1);
   for (int n=1;n<=9;n++) {
     line(width*n/11,height*1/11,width*n/11,height*10/11);
     line(width*1/11,height*n/11,width*10/11,height*n/11);
   }
   strokeWeight(4);
   for (int n=0;n<=4;n++) {
     line(width*(1+3*n)/11,height*1/11,width*(1+3*n)/11,height*10/11);
     line(width*1/11,height*(1+3*n)/11,width*10/11,height*(1+3*n)/11);
   }
   textSize(32);
   fill(0);
   for (int y=0;y<9;y++) {
     for (int x=0;x<9;x++) {
       text(boardSquares[y][x].myNumber,width*(1.25+x)/11,height*(1.75+y)/11);
     }
   }
   fill(255);
 }
 
 void nakedSingles() {
   for (int y=0;y<9;y++) {
     for (int x=0;x<9;x++) {
       if(boardSquares[y][x].myNumber != 0) {
         int num = boardSquares[y][x].myNumber;
         for (int _y=0;_y<9;_y++) {
           boardSquares[_y][x].removePosNum(num);
         }
         for (int _x=0;_x<9;_x++) {
           boardSquares[y][_x].removePosNum(num);
         }
         for (int _y=0;_y<9;_y++) {
           for (int _x=0;_x<9;_x++) {
             if(boardSquareBoxes[_y][_x] == boardSquareBoxes[y][x]) boardSquares[_y][_x].removePosNum(num);
           }
         }
       }
     }
   }
 }
 
 void hiddenSinglesRow(int row) {
   // Insert Correct Function Here
 }
 
  void hiddenSinglesColumn(int column) {
   // Insert Correct Function Here
 }
 
 void hiddenSinglesBox(int box) {
   // Insert Correct Function Here
 }
 
 void hiddenSingles() {
   for (int i=0;i<9;i++) {
     hiddenSinglesRow(i);
     hiddenSinglesColumn(i);
     hiddenSinglesBox(i);
   }
 }
 
 void checkNumbers() {
   for (int y=0;y<9;y++) {
     for (int x=0;x<9;x++) {
       boardSquares[y][x].checkPossibleNumbers();
     }
   }
 }
 
 void iterate() {
   this.nakedSingles();
   this.hiddenSingles();
   this.checkNumbers();
 }
 
 void iterateTillSolved() {
   boolean solved = false;
   this.iterate();
 }
} 
