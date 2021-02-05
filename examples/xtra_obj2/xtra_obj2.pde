/* 
 xtra2_obj
 render 3D obj
  
 cc P. Sieg 2021
 coordinate data from: http://paulbourke.net/geometry/platonic/
 */
 
import xyscope.*;
XYscope xy;

// minim is required to generate audio
import ddf.minim.*; 

int figure = 0;
int loopcount = 0;
float a,b,c,phi;

public void setup() {
  size(512, 512, P3D);
  // initialize XYscope
  xy = new XYscope(this);
}

public void draw() {
  background(0);

  // modulate freq to make beats out of shapes!?
  if(mousePressed){
    xy.freq(map(mouseX, 0, width, 0, 50));
  }

  // clear XYscope waves
  xy.clearWaves();

  pushMatrix();
  translate(width/2, height/2);
  if (figure == 0) scale(100);
  if (figure == 1) scale(300);
  if (figure == 2) scale(150);
  rotateZ(PI);
  rotateY(radians(frameCount));

  // render vertices in XYscope
  xy.beginShape();
  loopcount++;
  if (loopcount > 1000) {
    figure++;
    loopcount = 0;
  }
  if (figure > 2) figure = 0;
  
  if (figure == 0) {
  /*  
  tetrahedron_points[] = {
  {1, 1, 1}, {-1, 1, -1}, {1, -1, -1},
  {-1, 1, -1}, {-1, -1, 1}, {1, -1, -1},
  {1, 1, 1}, {1, -1, -1}, {-1, -1, 1},
  {1, 1, 1}, {-1, -1, 1}, {-1, 1, -1}};
  */  
  xy.vertex(1, 1, 1); 
  xy.vertex(-1, 1, -1); 
  xy.vertex(1, -1, -1);
  xy.vertex(-1, 1, -1); 
  xy.vertex(-1, -1, 1); 
  xy.vertex(1, -1, -1);
  xy.vertex(1, 1, 1); 
  xy.vertex(1, -1, -1); 
  xy.vertex(-1, -1, 1);
  xy.vertex(1, 1, 1); 
  xy.vertex(-1, -1, 1); 
  xy.vertex(-1, 1, -1);
  }
  
  if (figure == 1) {
  a = (1./(2.*sqrt(2.)));
  b = (1./2.);
  /*
  octahedron_points[] = {
  {-a, 0, a},      {-a, 0, -a},    {0, b, 0},
  {-a,  0, -a},    {a,  0, -a},    {0,  b,  0},
  {a,  0, -a},    {a,  0,  a},    {0,  b,  0},
  ---
  {a,  0,  a},   {-a,  0,  a},    {0,  b,  0},
  {a,  0, -a},   {-a,  0, -a},    {0, -b,  0},
  {-a,  0, -a},   {-a,  0,  a},    {0, -b,  0},
  ---
  {a,  0,  a},    {a,  0, -a},    {0, -b,  0},
  {-a,  0,  a},    {a,  0,  a},    {0, -b,  0}};
  */
  //{-a, 0, a},      {-a, 0, -a},    {0, b, 0},
  xy.vertex(-a, 0, a); 
  xy.vertex(-a, 0, -a); 
  xy.vertex(0, b, 0); 
  //{-a,  0, -a},    {a,  0, -a},    {0,  b,  0},
  xy.vertex(-a, 0, -a); 
  xy.vertex(a, 0, -a); 
  xy.vertex(0, b, 0); 
  //{a,  0, -a},    {a,  0,  a},    {0,  b,  0},
  xy.vertex(a, 0, -a); 
  xy.vertex(a, 0, a); 
  xy.vertex(0, b, 0); 
  //---
  //{a,  0,  a},   {-a,  0,  a},    {0,  b,  0},
  xy.vertex(a, 0, a); 
  xy.vertex(-a, 0, a); 
  xy.vertex(0, b, 0); 
  //{a,  0, -a},   {-a,  0, -a},    {0, -b,  0},
  xy.vertex(a, 0, -a); 
  xy.vertex(-a, 0, -a); 
  xy.vertex(0, -b, 0); 
  //{-a,  0, -a},   {-a,  0,  a},    {0, -b,  0},
  xy.vertex(-a, 0, -a); 
  xy.vertex(-a, 0, a); 
  xy.vertex(0, -b, 0); 
  //---
  //{a,  0,  a},    {a,  0, -a},    {0, -b,  0},
  xy.vertex(a, 0, a); 
  xy.vertex(a, 0, -a); 
  xy.vertex(0, -b, 0); 
  //{-a,  0,  a},    {a,  0,  a},    {0, -b,  0}};
  xy.vertex(-a, 0, a); 
  xy.vertex(a, 0, a); 
  xy.vertex(0, -b, 0); 
  }
  
  if (figure == 2) {
  phi = ((1. + sqrt(5.))/2.);
  b = (1./phi);
  c = (2.-phi);
  /*
  dodecahedron_points[] = {
  #1-{c,  0,  1},  {-c,  0,  1},   {-b,  b,  b},    {0,  1,  c},    {b,  b,  b},
  #2-{-c,  0,  1},   {c,  0,  1},    {b, -b,  b},    {0, -1,  c},   {-b, -b,  b},
  #3-{c,  0, -1},   {-c,  0, -1},   {-b, -b, -b},    {0, -1, -c},    {b, -b, -b},
  #4-{-c,  0, -1},   {c,  0, -1},    {b,  b, -b},    {0,  1, -c},   {-b,  b, -b},
  
  #5-{0,  1, -c},    {0,  1,  c},    {b,  b,  b},    {1,  c,  0},   {b,  b, -b},
  #6-{0,  1,  c},    {0,  1, -c},   {-b,  b, -b},   {-1,  c,  0},   {-b,  b,  b},
  #7-{0, -1, -c},    {0, -1,  c},   {-b, -b,  b},   {-1, -c,  0},   {-b, -b, -b},
  #8-{0, -1,  c},    {0, -1, -c},    {b, -b, -b},    {1, -c,  0},   {b, -b,  b},
  
  #9-{1,  c,  0},    {1, -c,  0},    {b, -b,  b},    {c,  0,  1},    {b,  b,  b},
  #10-{1, -c,  0},    {1,  c,  0},    {b, b, -b},    {c,  0, -1},    {b, -b, -b},
  #11-{-1,  c,  0},   {-1, -c,  0},   {-b, -b, -b},   {-c,  0, -1},   {-b,  b, -b},
  #12-{-1, -c,  0},   {-1,  c,  0},   {-b,  b,  b},   {-c,  0,  1},   {-b, -b,  b}};
  */
  //#1-{c,  0,  1},  {-c,  0,  1},   {-b,  b,  b},    {0,  1,  c},    {b,  b,  b},
  xy.vertex(c, 0, 1); 
  xy.vertex(-c, 0, 1); 
  xy.vertex(-b, b, b); 
  xy.vertex(0, 1, c); 
  xy.vertex(b, b, b); 
  
  //#2-{-c,  0,  1},   {c,  0,  1},    {b, -b,  b},    {0, -1,  c},   {-b, -b,  b},
  xy.vertex(-c, 0, 1); 
  xy.vertex(c, 0, 1); 
  xy.vertex(b, -b, b); 
  xy.vertex(0, -1, c); 
  xy.vertex(-b, -b, b); 
  
  //#3-{c,  0, -1},   {-c,  0, -1},   {-b, -b, -b},    {0, -1, -c},    {b, -b, -b},
  xy.vertex(c, 0, -1); 
  xy.vertex(-c, 0, -1); 
  xy.vertex(-b, -b, -b); 
  xy.vertex(0, -1, -c); 
  xy.vertex(b, -b, -b); 
  
  //#4-{-c,  0, -1},   {c,  0, -1},    {b,  b, -b},    {0,  1, -c},   {-b,  b, -b},
  xy.vertex(-c, 0, -1); 
  xy.vertex(c, 0, -1); 
  xy.vertex(b, b, -b); 
  xy.vertex(0, 1, -c); 
  xy.vertex(-b, b, -b); 
  
  //#5-{0,  1, -c},    {0,  1,  c},    {b,  b,  b},    {1,  c,  0},   {b,  b, -b},
  xy.vertex(0, 1, -c); 
  xy.vertex(0, 1, c); 
  xy.vertex(b, b, b); 
  xy.vertex(1, c, 0); 
  xy.vertex(b, b, -b); 
  
  //#6-{0,  1,  c},    {0,  1, -c},   {-b,  b, -b},   {-1,  c,  0},   {-b,  b,  b},
  xy.vertex(0, 1, c); 
  xy.vertex(0, 1, -c); 
  xy.vertex(-b, b, -b); 
  xy.vertex(-1, c, 0); 
  xy.vertex(-b, b, b); 
  
  //#7-{0, -1, -c},    {0, -1,  c},   {-b, -b,  b},   {-1, -c,  0},   {-b, -b, -b},
  xy.vertex(0, -1, -c); 
  xy.vertex(0, -1, c); 
  xy.vertex(-b, -b, b); 
  xy.vertex(-1, -c, 0); 
  xy.vertex(-b, -b, -b); 
  
  //#8-{0, -1,  c},    {0, -1, -c},    {b, -b, -b},    {1, -c,  0},   {b, -b,  b},
  xy.vertex(0, -1, c); 
  xy.vertex(0, -1, -c); 
  xy.vertex(b, -b, -b); 
  xy.vertex(1, -c, 0); 
  xy.vertex(b, -b, b); 
  
  //#9-{1,  c,  0},    {1, -c,  0},    {b, -b,  b},    {c,  0,  1},    {b,  b,  b},
  xy.vertex(1, c, 0); 
  xy.vertex(1, -c, 0); 
  xy.vertex(b, -b, b); 
  xy.vertex(c, 0, 1); 
  xy.vertex(b, b, b); 
  
  //#10-{1, -c,  0},    {1,  c,  0},    {b, b, -b},    {c,  0, -1},    {b, -b, -b},
  xy.vertex(1, -c, 0); 
  xy.vertex(1, c, 0); 
  xy.vertex(b, b, -b); 
  xy.vertex(c, 0, -1); 
  xy.vertex(b, -b, -b); 
  
  //#11-{-1,  c,  0},   {-1, -c,  0},   {-b, -b, -b},   {-c,  0, -1},   {-b,  b, -b},
  xy.vertex(-1, c, 0); 
  xy.vertex(-1, -c, 0); 
  xy.vertex(-b, -b, -b); 
  xy.vertex(-c, 0, -1); 
  xy.vertex(-b, b, -b); 
  
  //#12-{-1, -c,  0},   {-1,  c,  0},   {-b,  b,  b},   {-c,  0,  1},   {-b, -b,  b}};
  xy.vertex(-1, -c, 0); 
  xy.vertex(-1, c, 0); 
  xy.vertex(-b, b, b); 
  xy.vertex(-c, 0, 1); 
  xy.vertex(-b, -b, b); 


  }
  //xy.vertex(v.x, v.y, v.z);
  xy.endShape();

  // generate waveform
  xy.buildWaves();
  popMatrix();

  // draw waveform + xy simulation
  xy.drawWaveform();
  xy.drawXY();
}
