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
  
  int returnSinglePosNum() {
    int posNumCount = 0;
    int _return = 0;
    for (int i=0;i<9;i++) {
      if(possibleNumbers[i]) posNumCount++;
    }
    if(posNumCount == 1) {
      for (int i=0;i<9;i++) {
        if(possibleNumbers[i]) _return = i+1;
      }
    }
    else _return = 0;
    return _return;
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
   int numOfCanidates = 0;
   int canidateNumber = 0;
   for(int x=0;x<9;x++) {
     if (boardSquares[row][x].returnSinglePosNum() != 0) numOfCanidates++;
   }
   if (numOfCanidates == 1) {
     for(int x=0;x<9;x++) {
       if (boardSquares[row][x].returnSinglePosNum() != 0) 
       canidateNumber = boardSquares[row][x].returnSinglePosNum();
     }
   }
   else canidateNumber = 0;
   if (canidateNumber != 0) {
     for (int x=0;x<9;x++) {
           boardSquares[row][x].removePosNum(canidateNumber);
         }
   }
 }
 
  void hiddenSinglesColumn(int column) {
   int numOfCanidates = 0;
   int canidateNumber = 0;
   for(int y=0;y<9;y++) {
     if (boardSquares[y][column].returnSinglePosNum() != 0) numOfCanidates++;
   }
   if (numOfCanidates == 1) {
     for(int y=0;y<9;y++) {
       if (boardSquares[y][column].returnSinglePosNum() != 0) 
       canidateNumber = boardSquares[y][column].returnSinglePosNum();
     }
   }
   else canidateNumber = 0;
   if (canidateNumber != 0) {
     for (int y=0;y<9;y++) {
           boardSquares[y][column].removePosNum(canidateNumber);
         }
   }
 }
 
 void hiddenSinglesBox(int box) {
   int numOfCanidates = 0;
   int canidateNumber = 0;
   for(int y=0;y<9;y++) {
     for(int x=0;x<9;x++) {
       if (boardSquareBoxes[y][x] == box)
       if (boardSquares[y][x].returnSinglePosNum() != 0) numOfCanidates++;
     }
   }
   if (numOfCanidates == 1) {
     for(int y=0;y<9;y++) {
       for(int x=0;x<9;x++) {
         if (boardSquareBoxes[y][x] == box)
         if (boardSquares[y][x].returnSinglePosNum() != 0) 
         canidateNumber = boardSquares[y][x].returnSinglePosNum();
       }
     }
   }
   else canidateNumber = 0;
   if (canidateNumber != 0) {
     for (int x=0;x<9;x++) {
       for(int y=0;y<9;y++) {
         if (boardSquareBoxes[y][x] == box)
         boardSquares[y][x].removePosNum(canidateNumber);
       }
     }
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
   this.checkNumbers();
 }
 
 void iterateTillSolved() {
   boolean solved = false;
   this.iterate();
 }
} 
