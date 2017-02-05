int scl=100;
float b_fig=scl*0.6;

void brett() {

  pushMatrix();
  translate(0, 0, 10);
  int col;
  noStroke();
  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++)
    {
      if ((i+j)%2==0) {  // Farbbestimmung
        col=72;
      } else {
        col=253;
      }
      fill(col);
      pushMatrix();
      translate(scl*i+scl/2, scl*j+scl/2, -20);
      box(scl, scl, 20);
      popMatrix();
    }
  }
  popMatrix();
}

void turm(float x, float y) {
  x--;
  y--;
  pushMatrix();
  translate(x*scl+scl/2, y*scl+scl/2, b_fig/2);
  box(b_fig, b_fig, b_fig);
  popMatrix();
}

void konig(float x, float y) {
  x--;
  y--;
  pushMatrix();
  translate(x*scl+scl/2, y*scl+scl/2, b_fig/2);
  box(b_fig);
  float h = sqrt((b_fig*b_fig)/2); 
  translate(0, 0, b_fig/2+h/2);
  rotateZ(PI/4);
  box(h);
  popMatrix();
}

void dame(float x, float y) {
  x--;
  y--;
  pushMatrix();
  translate(x*scl+scl/2, y*scl+scl/2, b_fig/2);
  box(b_fig);
  translate(0, 0, b_fig);  
  sphere(b_fig/2);
  popMatrix();
}

void bauer(float x, float y) {
  x--;
  y--;
  pushMatrix();
  translate(x*scl+scl/2, y*scl+scl/2, b_fig*0.8/2);
  box(b_fig*0.8);
  popMatrix();
}

void springer(float x, float y) {
  x--;
  y--;
  pushMatrix();
  translate(x*scl+scl/2, y*scl+scl/2, 0);
  pushMatrix();
  translate(b_fig/4, b_fig/4, b_fig/4);
  box(b_fig/2);
  popMatrix();

  pushMatrix();
  translate(-b_fig/4, b_fig/4, b_fig/4);
  box(b_fig/2);
  popMatrix();

  pushMatrix();
  translate(b_fig/4, -b_fig/4, b_fig/4);
  box(b_fig/2);
  popMatrix();

  pushMatrix();
  translate(b_fig/4, -b_fig/4, b_fig*3/4);
  box(b_fig/2);
  popMatrix();

  pushMatrix();
  translate(-b_fig/4, -b_fig/4, b_fig*3/4);
  box(b_fig/2);
  popMatrix();

  pushMatrix();
  translate(-b_fig/4, b_fig/4, b_fig*3/4);
  box(b_fig/2);
  popMatrix();

  popMatrix();
}

void laufer(float x, float y) {
  x--;
  y--;
  pushMatrix();
  translate(x*scl+scl/2, y*scl+scl/2, b_fig/2);

  pushMatrix();
  float b=sqrt(b_fig*b_fig/8);
  rotateZ(PI/4);  
  box(3*b, b, b_fig);
  box(b, 3*b, b_fig);
  popMatrix();

  pushMatrix();
  translate(b_fig*3/8, b_fig*3/8, 0);
  box(b_fig/4, b_fig/4, b_fig);
  popMatrix();

  pushMatrix();
  translate(-b_fig*3/8, b_fig*3/8, 0);
  box(b_fig/4, b_fig/4, b_fig);
  popMatrix();

  pushMatrix();
  translate(b_fig*3/8, -b_fig*3/8, 0);
  box(b_fig/4, b_fig/4, b_fig);
  popMatrix();

  pushMatrix();
  translate(-b_fig*3/8, -b_fig*3/8, 0);
  box(b_fig/4, b_fig/4, b_fig);
  popMatrix();

  popMatrix();
}


void kreis(float x, float y) {
  x--;
  y--;
  pushMatrix();
  translate(x*scl+scl/2, y*scl+scl/2,1);
  ellipse(0,0,scl/4,scl/4);
  popMatrix();
}
void coordAxis() {
  stroke(255, 0, 0);
  line(0, 0, 0, 100, 0, 0);
  stroke(0, 255, 0);
  line(0, 0, 0, 0, 100, 0);
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, 100);
}