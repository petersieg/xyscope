/*
  simple game; avoid obstacles; move paddle with keys left/right. restart with key delete.
  PS 2021
*/

// import and create instance of XYscope
import xyscope.*;
XYscope xy;

// minim is required to generate audio
import ddf.minim.*; 

int stop = 0; //if collision = 1
int x=235, y=450; //initial paddle pos
int x1 = 0, y1 = 1; //obtacle_1 pos; 0 = inactive
int x2 = 0, y2 = 1; //obtacle_2 pos; 0 = inactive
int x3 = 0, y3 = 1; //obtacle_2 pos; 0 = inactive
int obsize = 50; //obstacle & paddle size

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
  xy.rect(x, y, obsize, 10);
  
  if (stop == 0) {
  //obstacle_1
  if (x1 > 0) { //active; move down
    y1++;
    if (y1 > 500-obsize) {
      y1 = 1;
      x1 = 0; //set inactive to start again
    }
  }
  if (x1 == 0) { //inactive
    x1 = int(random(1,500-obsize));
    y1 = 1;
  }
  xy.rect(x1, y1, obsize, obsize);
  
  //obstacle_2
  if (x2 > 0) { //active; move down
    y2+=2;
    if (y2 > 500-obsize) {
      y2 = 1;
      x2 = 0; //set inactive to start again
    }
  }
  if (x2 == 0) { //inactive
    x2 = int(random(1,500-obsize));
    y2 = 1;
  }
  xy.rect(x2, y2, obsize, obsize);

  //obstacle_3
  if (x3 > 0) { //active; move down
    y3+=3;
    if (y3 > 500-obsize) {
      y3 = 1;
      x3 = 0; //set inactive to start again
    }
  }
  if (x3 == 0) { //inactive
    x3 = int(random(1,500-obsize));
    y3 = 1;
  }
  xy.rect(x3, y3, obsize, obsize);
  }
  
  //collison detection
  /*debug
  print("x =",x); print(" - y =",y); println(" - stop=",stop);
  print("x1=",x1); println(" - y1=",y1);
  print("x2=",x2); println(" - y2=",y2);
  print("x3=",x3); println(" - y3=",y3);
  */
  if ((x1 > x-obsize) && (x1 < x+obsize) && (y1 > 450-obsize)) stop = 1;
  if ((x2 > x-obsize) && (x2 < x+obsize) && (y2 > 450-obsize)) stop = 1;
  if ((x3 > x-obsize) && (x3 < x+obsize) && (y3 > 450-obsize)) stop = 1;
  
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
    x2 = 0; y2 = 1; //obtacle_2 pos; 0 = inactive
    x3 = 0; y3 = 1; //obtacle_2 pos; 0 = inactive
    xy.clearWaves();    
  }
  if ((keyCode == 37) && (stop == 0)) { // left
    if (x > 2) x-=2;
  }
  if ((keyCode == 39) && (stop == 0)) { // right
    if (x < 500-obsize) x+=2;
  }
}
