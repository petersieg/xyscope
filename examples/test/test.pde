/* 
  test - dont know why this happens?
  PS
 */

// import and create instance of XYscope
import xyscope.*;
XYscope xy;

// minim is required to generate audio
import ddf.minim.*; 

void setup() {
  size(512, 512);

  // initialize XYscope with default sound out
  xy = new XYscope(this);
}


void draw() {
  background(0);
  //frame
  xy.line(101, 101, 411, 101);
  xy.line(411, 101, 411, 411);
  xy.line(411, 411, 101, 411);
  xy.line(101, 411, 101, 101);

  // build audio from shapes
  xy.buildWaves();

  // draw all analytics
  xy.drawAll();
}
