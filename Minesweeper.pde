import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
//static = can refer to a function using constructor
public final static int NUM_ROWS = 5;
public final static int NUM_COLS = 5;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    //fil empty apartments
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r < NUM_ROWS; r++){
      for(int c = 0; c < NUM_COLS; c++){
        buttons[r][c] = new MSButton(r, c);
      }
    }
    
    setMines();
}
public void setMines()
{
    int r = (int)(Math.random()*NUM_ROWS);
    int c = (int)(Math.random()*NUM_COLS);
    //generate a random position
    //if it doesnt have a mine there, place one
    if(!mines.contains(buttons[r][c])){
      mines.add(buttons[r][c]);
    }
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
  for(int i = 0; i < mines.size(); i++){
    if(mines.get(i).flagged == true){
       return true;
    }
  }
  return false;
}
public void displayLosingMessage()
{
  for(int r = 0; r < buttons.length; r++){
    for(int c = 0; c < buttons[r].length; c++){
      buttons[r][c].setLabel("You lost!");
    }
  }
}
public void displayWinningMessage()
{
  for(int r = 0; r < buttons.length; r++){
    for(int c = 0; c < buttons[r].length; c++){
      buttons[r][c].setLabel("You won!");
    }
  }
}
public boolean isValid(int r, int c)
{
   if(r < NUM_ROWS && c < NUM_COLS && r >= 0 && c >= 0){
    return true;
  }else{
    return false;
  }
}
public int countMines(int row, int col)
{
    int numMines = 0;
    //your code here
    if(isValid(row, col+1)){
      if(mines.contains(buttons[row][col+1])){
        numMines++;
      }
    }
    if(isValid(row-1, col+1)){
      if(mines.contains(buttons[row-1][col+1])){
        numMines++;
      }      
    }
    if(isValid(row-1, col)){
      if(mines.contains(buttons[row-1][col])){
        numMines++;
      }
    }
    if(isValid(row-1, col-1)){
      if(mines.contains(buttons[row-1][col-1])){
        numMines++;
      }
    }
    if(isValid(row, col-1)){
      if(mines.contains(buttons[row][col-1])){
        numMines++;
      }
    }
    if(isValid(row+1, col-1)){
      if(mines.contains(buttons[row+1][col-1])){
        numMines++;
      }
    }
    if(isValid(row+1, col)){
      if(mines.contains(buttons[row+1][col])){
        numMines++;
      }
    }
    if(isValid(row+1, col+1)){
      if(mines.contains(buttons[row+1][col+1])){
        numMines++;
      }
    }
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        //your code here
        if(mouseButton == RIGHT){
          if(flagged == true){
            flagged = false;
          }else{
            flagged = true;
            clicked = false;
          }
        }else if(mines.contains(this)){
          displayLosingMessage();
        }else if(countMines(myRow, myCol) > 0){
         setLabel(countMines(myRow, myCol));
        }else{
          if(isValid(myRow, myCol+1) && buttons[myRow][myCol+1].clicked == false){
            buttons[myRow][myCol+1].mousePressed();
          }
          if(isValid(myRow-1, myCol+1) && buttons[myRow-1][myCol+1].clicked == false){
            buttons[myRow-1][myCol+1].mousePressed();
          } 
          if(isValid(myRow-1, myCol) && buttons[myRow-1][myCol].clicked == false){
            buttons[myRow-1][myCol].mousePressed();
          }
          if(isValid(myRow-1, myCol-1) && buttons[myRow-1][myCol-1].clicked == false){
            buttons[myRow-1][myCol-1].mousePressed();
          }
          if(isValid(myRow, myCol-1) && buttons[myRow][myCol-1].clicked == false){
            buttons[myRow][myCol-1].mousePressed();
          }
          if(isValid(myRow+1, myCol-1) && buttons[myRow+1][myCol-1].clicked == false){
            buttons[myRow-1][myCol-1].mousePressed();
          }
          if(isValid(myRow+1, myCol) && buttons[myRow+1][myCol].clicked == false){
            buttons[myRow+1][myCol].mousePressed();
          }
          if(isValid(myRow+1, myCol+1) && buttons[myRow+1][myCol+1].clicked == false){
            buttons[myRow-1][myCol-1].mousePressed();
          }
        }
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if(clicked && mines.contains(this)) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
