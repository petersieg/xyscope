/* 
 xtra_type
 Let's draw type on the scope! 
 ANYKEY - type out
 DELETE - clear text

 » Requires Geomerative library
 
 cc teddavis.org 2017
 */
/*
"ENERGY"
"PLANET"
"2BE   "
"2DO   "
"2DIE  "
"4ALL  "
"EARTH "
"HOPE  "
"LOVE  "
"PEACE "
"FRIEND"
"GOD   "
"SUN   "
"DO IT "
"THRUTH"
"CELL  "

*/
// import and create instance of XYscope
import xyscope.*;
XYscope xy;

// minim is required to generate audio
import ddf.minim.*; 

// geomerative is required to generate text points
import geomerative.*; 
RShape grp; 
RPoint[][] pointPaths;

// store our text to draw
String txtString = "LOVE";
Integer i = 0, loopcount = 0;

void setup() {
  size(512, 512);

  // initialize XYscope with default/custom sound out
  xy = new XYscope(this, "");

  // initialize Geomerative
  RG.init(this);
}

void draw() {
  background(0);

  // clear waves like refreshing background
  xy.clearWaves(); 

  // render type with Geomerative
  grp = RG.getText(txtString, "FreeSans.ttf", width/2, CENTER); 
  grp.centerIn(g, 30);
  RG.setPolygonizer(RG.UNIFORMSTEP);
  RG.setPolygonizerStep(10);
  pointPaths = grp.getPointsInPaths();

  pushMatrix();
  translate(width/2, height/2); 
  if (pointPaths != null) { // only draw if we have points 
    for (int i = 0; i < pointPaths.length; i++) { 
      xy.beginShape(); 
      for (int j=0; j < pointPaths[i].length; j++) { 
        xy.vertex(pointPaths[i][j].x, pointPaths[i][j].y);
      } 
      xy.endShape();
    }
  } 
  popMatrix();

  // build audio from shapes
  xy.buildWaves();

  // draw Wave + XY analytics
  xy.drawWave();
  xy.drawXY();
  loopcount++;
  if (loopcount > 1000) {
    loopcount = 0;
    i = int(random(1,17));
    if (i == 1) txtString = "ENERGY";
    if (i == 2) txtString = "PLANET";
    if (i == 3) txtString = "2BE";
    if (i == 4) txtString = "2DO";
    if (i == 5) txtString = "2DIE";
    if (i == 6) txtString = "EARTH";
    if (i == 7) txtString = "HOPE";
    if (i == 8) txtString = "LOVE";
    if (i == 9) txtString = "PEACE";
    if (i == 10) txtString = "FRIEND";
    if (i == 11) txtString = "GOD";
    if (i == 12) txtString = "SUN";
    if (i == 13) txtString = "DO IT";
    if (i == 14) txtString = "THRUTH";
    if (i == 15) txtString = "CELL";
    if (i == 16) txtString = "WISDOM";
  }
  xy.clearWaves();
}

void keyPressed() {
  if (keyCode == 8) {
  } 
}
