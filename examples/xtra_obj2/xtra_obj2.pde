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
  scale(100);
  rotateZ(PI);
  rotateY(radians(frameCount));

  // render vertices in XYscope
  xy.beginShape();
  
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
  //xy.vertex(v.x, v.y, v.z);
  xy.endShape();

  // generate waveform
  xy.buildWaves();
  popMatrix();

  // draw waveform + xy simulation
  xy.drawWaveform();
  xy.drawXY();
}
