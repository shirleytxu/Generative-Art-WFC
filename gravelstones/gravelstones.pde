/* 
Date: 7/11/21
Author: Shirley Xu 

Abstract: This is a generative art sketch that imitates "Gravel Stones" by Georg Nees (1966).
See: https://digitalartarchive.siggraph.org/artwork/georg-nees-gravel-stones/ 

  The artwork is comprised of smaller squares, which I create using the Square class. 
  As described on various sources analyzing the work, the orderly squares descend  
  further and further into chaos as they descend down the canvas. I replicated this 
  "chaos" through a random rotation of each square and random x-y coordinate shiftings 
  of a square's center. The range of randomness is incremented further after completing 
  each row, which gives the effect of increased disorder. 
*/ 

// Number of rows and columns present on Nees's original "Gravel Stones" 
int numCols = 12; 
int numRows = 22; 

// Used color picker to extract background and square colors used by Nees 
color bgcolor = color(248, 245, 230);
color squarecolor = color(71, 73, 62);

int squareLength = 30; // Length of square
int margin = squareLength * 3/2; // Margin area (border / padding)

float step = .25; // Incrementation value of rotation per row. Increase for more "chaotic" look.
float sum; // Cumulative sum of rotation range 
float normalize; // Makes x-y shifts and rotations less chaotic 

void setup() { 
  size(520, 820); // Canvas size
  stroke(squarecolor); // All drawn squares will be same color as Nees's work
  fill(bgcolor, 0); // Inside of squares will be transparent
}

void drawSquare(int col, int row, int squareLength, float sum) {
    // Display all Squares
    pushMatrix();
    float rotation = random(-sum, sum); // Randomize amount of rotation 
    translate(margin + col * squareLength - 1/2 * squareLength + normalize, 
              margin + row * squareLength - 1/2 * squareLength + normalize);    
    rotate(radians(rotation)); 
    rect(0, 0, squareLength, squareLength); 
    popMatrix();
  }  


void draw() { 
  background(bgcolor);
  for (int row = 1; row <= numRows; row = row + 1) {
    sum += (step * row); // Increment rotation range sum 
    for (int col = 1; col <= numCols; col = col + 1) {
      drawSquare(col, row, squareLength, sum); // Draw each square                       
    }
  }
  noLoop(); // No need for looped drawing, not animated sketch

}

void mousePressed() {
  
  // Re-initiates cumulative sum for redrawing 
  sum = 0; 
  
   redraw(); 
}
