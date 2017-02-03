
void setup() {
  fill(204);
  fullScreen(P3D, 1);
  initCamera();
}

void draw() {

  lights();
  background(0);
  updateCamera();

  brett();
  aufstellen();
  //zeichneFiguren();

  //coordAxis();
}

void mouseClicked() {
  //saveFrame("Fortschritt-####.png");
}

void aufstellen() {
  fill(72-20);
  turm(1,1);
  springer(2,1);
  laufer(3,1);
  konig(4,1);
  dame(5,1);
  laufer(6,1);
  springer(7,1);
  turm(8,1);
  for (int i=1; i<9; i++) {
    bauer(i, 2);
  }
  fill(253-5);
  turm(1,8);
  springer(2,8);
  laufer(3,8);
  konig(4,8);
  dame(5,8);
  laufer(6,8);
  springer(7,8);
  turm(8,8);
  for (int i=1; i<9; i++) {
    bauer(i, 7);
  }
}