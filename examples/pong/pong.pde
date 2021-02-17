/*
  simple pong game; move paddle with keys left/right. restart with key delete.
  PS 2021
*/

// import and create instance of XYscope
import xyscope.*;
XYscope xy;

// minim is required to generate audio
import ddf.minim.*; 

int stop = 0; //if collision = 1
int x=235, y=450; //initial paddle pos
int x1 = 0, y1 = 1; //ball pos; 0 = inactive
int xm = 1,ym = 1;
int obsize = 10; //ball size
int pdsize = 30; //paddle size
int score = 0;
int speed = 1;

void setup() {
  size(512, 512);

  // initialize XYscope with default sound out
  xy = new XYscope(this);
}

void draw() {
  background(0);

  // clear waves like refreshing background
  xy.clearWaves();

  xy.clearWaves();
  
  //frame
  xy.rect(1, 1, 500, 500);
  
  //paddle
  xy.rect(x, y, pdsize, 10);
  
  if (stop == 0) {
  //ball
  if (x1 > 0) { //active; move
    y1 = y1 + ym * speed;
    x1 = x1 + xm * speed;
    if (y1 > 500-obsize) {
      y1 = 1;
      x1 = 0; //set inactive to start again
    }
  }
  if (x1 == 0) { //inactive
    x1 = int(random(1,500-obsize));
    y1 = 1;
    xm = int(random(3));
    if (xm == 2) xm = -1;
    if (xm == 0) xm =  1;
    ym = int(random(3));
    if (ym == 2) ym = -1;
    if (ym == 0) ym =  1;
  }
  xy.rect(x1, y1, obsize, obsize);
  
  }
  
  //collison detection
  //ball wall collision
  //left
  if (x1 < obsize) {
    if (xm < 0) xm = 1;
  }
  //right
  if (x1 > 500-obsize) {
    if (xm < 0) xm = 1;
    if (xm > 0) xm = -1;
  }
  //top
  if (y1 < 1) {
    if (ym < 0) ym = 1;
  }
  
  //ball paddle collision
  if ((x1 > x-obsize) && (x1 < x+pdsize) && (y1 > 450-obsize)) {
    if (ym > 0) ym = -1;
    score++;
    if (score > 10) speed = 2;
    if (score > 30) speed = 3;
    if (score > 50) speed = 4;
  } 
  
  //ball reaches ground - game stop
  if (y1 > 450+obsize) {
    if (stop == 0) println("score = ",score);
    stop = 1;
  }
    
  // build audio from shapes
  xy.buildWaves();

  // draw all analytics
  xy.drawAll();
}

void keyPressed() {
  if (keyCode == 8) { // DELETE
    stop = 0; //rerun
    x=235; y=450; //inital paddle pos
    x1 = 0; y1 = 1; //obtacle_1 pos; 0 = inactive
    xm = 1; ym = 1;
    speed = 1;
    score = 0;
    xy.clearWaves();    
  }
  if ((keyCode == 37) && (stop == 0)) { // left
    if (x > 2) x=x-2*speed;
  }
  if ((keyCode == 39) && (stop == 0)) { // right
    if (x < 500-pdsize) x=x+2*speed;
  }
}
