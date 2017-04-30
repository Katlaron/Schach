int scl=100;
int ebenenscl = 5*scl;
float b_fig=scl*0.6;
float[] brettdirx = new float[anzEbenen+1];
float[] brettdiry = new float[anzEbenen+1];

void brett() {

  for (int lvl=1; lvl<=anzEbenen; lvl++) {
    pushMatrix();
    translate(brettdirx[lvl], brettdiry[lvl], (lvl-startEbene)*ebenenscl);
    int col;
    noStroke();
    for (int i=0; i<8; i++) {
      for (int j=0; j<8; j++)
      {
        if ((i+j)%2==0) {  // Farbbestimmung
          col=feldschwarz;
        } else {
          col=feldweiss;
        }
        fill(col);
        pushMatrix();
        translate(scl*i+scl/2, scl*j+scl/2, -10);
        box(scl, scl, 20);
        popMatrix();
      }
    }
    popMatrix();
  }
}

void setBrettdir() {      //findet heraus in welche Richtung die verschiedenen Ebenen verschoben werden
  PVector eye, brettmid, dir, zv;     // findet den Ofset der verschiedenen Ebenen heraus
  eye = getAuge();
  eye = new PVector(eye.x, eye.y);
  brettmid = new PVector(4*scl, 4*scl);
  dir = brettmid.sub(eye);
  dir.normalize();
  for (int i=1; i<= anzEbenen; i++) {
    zv = dir.copy();
    zv.mult(ebenenscl*(i-startEbene));
    brettdirx[i] = zv.x;
    brettdiry[i] = zv.y;
  }
}

void aufstellen() {
  feld = new Feld[9][9][anzEbenen+1];


  feld[1][1][startEbene] = new Feld(1, 1, startEbene, weiss, turm);
  feld[2][1][startEbene] = new Feld(2, 1, startEbene, weiss, springer);
  feld[3][1][startEbene] = new Feld(3, 1, startEbene, weiss, laufer);
  feld[4][1][startEbene] = new Feld(4, 1, startEbene, weiss, dame);
  feld[5][1][startEbene] = new Feld(5, 1, startEbene, weiss, konig);
  feld[6][1][startEbene] = new Feld(6, 1, startEbene, weiss, laufer);
  feld[7][1][startEbene] = new Feld(7, 1, startEbene, weiss, springer);
  feld[8][1][startEbene] = new Feld(8, 1, startEbene, weiss, turm);

  feld[1][8][startEbene] = new Feld(1, 8, startEbene, schwarz, turm);
  feld[2][8][startEbene] = new Feld(2, 8, startEbene, schwarz, springer);
  feld[3][8][startEbene] = new Feld(3, 8, startEbene, schwarz, laufer);
  feld[4][8][startEbene] = new Feld(4, 8, startEbene, schwarz, dame);
  feld[5][8][startEbene] = new Feld(5, 8, startEbene, schwarz, konig);
  feld[6][8][startEbene] = new Feld(6, 8, startEbene, schwarz, laufer);
  feld[7][8][startEbene] = new Feld(7, 8, startEbene, schwarz, springer);
  feld[8][8][startEbene] = new Feld(8, 8, startEbene, schwarz, turm);

  for (int i=1; i<9; i++) {
    feld[i][2][startEbene] = new Feld(i, 2, startEbene, weiss, bauer);
    feld[i][7][startEbene] = new Feld(i, 7, startEbene, schwarz, bauer);

    for (int j=3; j<7; j++) {
      feld[i][j][startEbene] = new Feld(i, j, startEbene, schwarz, leer);
    }
  }

  for (int k=1; k<anzEbenen+1; k++) {      // initialiesiert alle anderen Ebenen mit leeren Plätzen
    if (k != startEbene) {
      for (int i=1; i<9; i++) 
        for (int j=1; j<9; j++)
          feld[i][j][k] = new Feld(i, j, k, schwarz, leer);
    }
  }
  feld[4][6][1] = new Feld(4, 6, 1, schwarz, bauer);
  feld[5][1][1] = new Feld(5, 1, 1, weiss, bauer);
  feld[4][6][3] = new Feld(4, 6, 3, schwarz, bauer);
  feld[5][6][3] = new Feld(5, 6, 3, weiss, bauer);
}



void figursetzen(float x, float y, int z, int figur) {
  x--;
  y--;

  pushMatrix();
  translate(brettdirx[z], brettdiry[z], (z-startEbene)*500);

  switch (figur) {
  case 1: 
    turm(x, y); 
    break;
  case 2: 
    springer(x, y); 
    break;
  case 3: 
    laufer(x, y); 
    break;
  case 4: 
    konig(x, y); 
    break;
  case 5: 
    dame(x, y); 
    break;
  case 6: 
    bauer(x, y); 
    break;
  case 7:
    kreis(x, y);
    break;
  }
  popMatrix();
}

void turm(float x, float y) {

  pushMatrix();
  translate(x*scl+scl/2, y*scl+scl/2, b_fig/2);
  box(b_fig, b_fig, b_fig);
  popMatrix();
}

void konig(float x, float y) {

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

  pushMatrix();
  translate(x*scl+scl/2, y*scl+scl/2, b_fig/2);
  box(b_fig);
  translate(0, 0, b_fig);  
  sphere(b_fig/2);
  popMatrix();
}

void bauer(float x, float y) {

  pushMatrix();
  translate(x*scl+scl/2, y*scl+scl/2, b_fig*0.8/2);
  box(b_fig*0.8);
  popMatrix();
}

void springer(float x, float y) {

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

  pushMatrix();
  translate(x*scl+scl/2, y*scl+scl/2, 1);
  ellipse(0, 0, scl/4, scl/4);
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