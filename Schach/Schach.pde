final int schwarz = 0;
final int weiss = 1;
final int feldweiss = 253;
final int feldschwarz = 72;
final int figurweiss = 243;
final int figurschwarz = 82;
final int leer = -1;
final int turm = 1;
final int springer = 2 ;
final int laufer = 3 ;
final int konig = 4 ;
final int dame = 5 ;
final int bauer = 6 ;
Feld[][] feld;
boolean bewegung;
int aktiverSpieler;

void setup() {
  fill(204);
  fullScreen(P3D, 1);
  initCamera();
  aufstellen();
  bewegung = false;
  aktiverSpieler = weiss;
}

void draw() {

  lights();
  background(0);
  updateCamera();
  aktivefigur();


  brett();
  zeichnen();


  coordAxis();
}

void mouseClicked() {
  //saveFrame("Fortschritt-####.png");
  if (!bewegung) {          // hier wird erst eine Figur ausgewählt die bewegt wird

    for (int i=1; i<9; i++)   // alle bisher möglichen Felder zurücksetzen
      for (int j=1; j<9; j++) {
        feld[i][j].setmoglich(false);
      }

    for (int i=1; i<9; i++) 
      for (int j=1; j<9; j++) {
        if (feld[i][j].getpartei()==aktiverSpieler)
          feld[i][j].setaktiv(true);
        if (feld[i][j].getaktiv()) {      // finde das aktive Feld
          int figureffekt = feld[i][j].getfigur();
          switch (figureffekt) {          // Bewegungsmöglichkeiten der Figur bestimmen
          case bauer: 
            int figurrichtung;
            if (feld[i][j].getpartei()==weiss) {
              figurrichtung = 1;
            } else {
              figurrichtung = -1;
            }
            if ((j+figurrichtung>0)&&(j+figurrichtung<9)) {                         // Feld vor dem Bauern
              if (feld[i][j+figurrichtung].getfigur()==leer)
                feld[i][j+figurrichtung].setmoglich(true);
            }
            if ((j+figurrichtung>0)&&(j+figurrichtung<9)&&(i+1<9)) {                 // Feld rechts vorn
              if ((feld[i+1][j+figurrichtung].getfigur()!=leer)&&(feld[i+1][j+figurrichtung].getpartei()!=feld[i][j].getpartei()))
                feld[i+1][j+figurrichtung].setmoglich(true);
            }
            if ((j+figurrichtung>0)&&(j+figurrichtung<9)&&(i-1>0)) {                 // Feld links vorn
              if ((feld[i-1][j+figurrichtung].getfigur()!=leer)&&(feld[i-1][j+figurrichtung].getpartei()!=feld[i][j].getpartei()))
                feld[i-1][j+figurrichtung].setmoglich(true);
            }
            if ((j==2)&&(feld[i][j].getpartei()==weiss)) {                           // 2 Felder nach vorn am Start
              if ((feld[i][j+1].getfigur()==leer)&&(feld[i][j+2].getfigur()==leer))
                feld[i][j+2].setmoglich(true);
            }

            if ((j==7)&&(feld[i][j].getpartei()==schwarz)) {                         // 2 Felder nach vorn am Start
              if ((feld[i][j-1].getfigur()==leer)&&(feld[i][j-2].getfigur()==leer))
                feld[i][j-2].setmoglich(true);
            }
            bewegung=true;
            break;
          case springer:
            testeaufmoglich(i, j, 1, 2, false, -1); 
            testeaufmoglich(i, j, -1, 2, false, -1);
            testeaufmoglich(i, j, 1, -2, false, -1);
            testeaufmoglich(i, j, -1, -2, false, -1);
            testeaufmoglich(i, j, 2, 1, false, -1);
            testeaufmoglich(i, j, -2, 1, false, -1);
            testeaufmoglich(i, j, 2, -1, false, -1);
            testeaufmoglich(i, j, -2, -1, false, -1);
            bewegung = true;
            break;
          case turm:
            testeaufmoglich(i, j, 1, 0, true, -1);
            testeaufmoglich(i, j, -1, 0, true, -1);
            testeaufmoglich(i, j, 0, 1, true, -1);
            testeaufmoglich(i, j, 0, -1, true, -1);
            bewegung = true;
            break;
          case laufer:
            testeaufmoglich(i, j, 1, 1, true, -1);
            testeaufmoglich(i, j, 1, -1, true, -1);
            testeaufmoglich(i, j, -1, 1, true, -1);
            testeaufmoglich(i, j, -1, -1, true, -1);
            bewegung = true;
            break;
          case dame:
            testeaufmoglich(i, j, 1, 0, true, -1);
            testeaufmoglich(i, j, -1, 0, true, -1);
            testeaufmoglich(i, j, 0, 1, true, -1);
            testeaufmoglich(i, j, 0, -1, true, -1);
            testeaufmoglich(i, j, 1, 1, true, -1);
            testeaufmoglich(i, j, 1, -1, true, -1);
            testeaufmoglich(i, j, -1, 1, true, -1);
            testeaufmoglich(i, j, -1, -1, true, -1);
            bewegung = true;
            break;
          case konig:
            testeaufmoglich(i, j, 1, 0, false, -1);
            testeaufmoglich(i, j, -1, 0, false, -1);
            testeaufmoglich(i, j, 0, 1, false, -1);
            testeaufmoglich(i, j, 0, -1, false, -1);
            testeaufmoglich(i, j, 1, 1, false, -1);
            testeaufmoglich(i, j, 1, -1, false, -1);
            testeaufmoglich(i, j, -1, 1, false, -1);
            testeaufmoglich(i, j, -1, -1, false, -1);
            bewegung = true;
            break;
          }
        }
      }
  } else {    // umplatzieren der Figur
    int a, b;

    a=1;
    b=1;
    for (int i=1; i<9; i++) 
      for (int j=1; j<9; j++) {
        if (feld[i][j].getaktiv()) {
          a=i; 
          b=j;  // merken des vorher aktiven Feldes
        }
      }
    for (int i=1; i<9; i++) 
      for (int j=1; j<9; j++) {
        feld[i][j].setaktiv(true);
        if (feld[i][j].getaktiv()) {                                // finde das aktive Feld  &&feld[i][j].getmoglich()
          if (feld[i][j].getmoglich()) {
            feld[i][j].setfigur( feld[a][b].getfigur());              // Figuren tauschen
            feld[i][j].setpartei( feld[a][b].getpartei());          
            feld[a][b].setfigur(leer);
            if (aktiverSpieler==weiss)                                // aktiver Spieler wechselt
              aktiverSpieler=schwarz; 
            else 
              aktiverSpieler=weiss;
              
          } else {
            if (feld[i][j].getfigur()!=leer) {                        // ansonsten wird neue Figur aktiv
              bewegung=false;
              mouseClicked();
              return;
            }
          }
        }
        feld[i][j].setaktiv(false);
        bewegung=false;
      }

    for (int i=1; i<9; i++) 
      for (int j=1; j<9; j++) {
        feld[i][j].setmoglich(false);
      }
  }
}
void testeaufmoglich(int i, int j, int hx, int hy, boolean again, int orginalfarbe) {     //vergleicht ob die Figur von Feld i,j auf hx, hy kann 
  int orgpartei;
  if (orginalfarbe==-1) {
    orgpartei = feld[i][j].getpartei();
  } else {
    orgpartei = orginalfarbe;
  }


  if ((i+hx<9)&&(i+hx>0)&&(j+hy<9)&&(j+hy>0))
  {
    if ((feld[i+hx][j+hy].getfigur()!=leer)&&(feld[i+hx][j+hy].getpartei()!=orgpartei))
      feld[i+hx][j+hy].setmoglich(true);
    if (feld[i+hx][j+hy].getfigur()==leer) {
      feld[i+hx][j+hy].setmoglich(true);
      if (again) {
        //println("x: "+i+" y: "+j+" hx: "+hx+" hy: "+hy);
        testeaufmoglich(i+hx, j+hy, hx, hy, true, orgpartei);   // prüft weiter in eine Richtung
      }
    }
  }
}


void aktivefigur() {
  float t, x, y;
  float z = 0;
  PVector eye, dir;
  eye = getAuge();
  dir = getRichtung();
  t = (z-eye.z)/dir.z;
  x = eye.x + t*dir.x;
  y = eye.y + t*dir.y;
  for (int i=1; i<9; i++) 
    for (int j=1; j<9; j++) {
      feld[i][j].mausaktiv(x, y);
    }
}

void aufstellen() {
  feld = new Feld[9][9];
  feld[1][1] = new Feld(1, 1, weiss, turm);
  feld[2][1] = new Feld(2, 1, weiss, springer);
  feld[3][1] = new Feld(3, 1, weiss, laufer);
  feld[4][1] = new Feld(4, 1, weiss, dame);
  feld[5][1] = new Feld(5, 1, weiss, konig);
  feld[6][1] = new Feld(6, 1, weiss, laufer);
  feld[7][1] = new Feld(7, 1, weiss, springer);
  feld[8][1] = new Feld(8, 1, weiss, turm);

  feld[1][8] = new Feld(1, 8, schwarz, turm);
  feld[2][8] = new Feld(2, 8, schwarz, springer);
  feld[3][8] = new Feld(3, 8, schwarz, laufer);
  feld[4][8] = new Feld(4, 8, schwarz, dame);
  feld[5][8] = new Feld(5, 8, schwarz, konig);
  feld[6][8] = new Feld(6, 8, schwarz, laufer);
  feld[7][8] = new Feld(7, 8, schwarz, springer);
  feld[8][8] = new Feld(8, 8, schwarz, turm);

  for (int i=1; i<9; i++) {
    feld[i][2] = new Feld(i, 2, weiss, bauer);
    feld[i][7] = new Feld(i, 7, schwarz, bauer);

    for (int j=3; j<7; j++) {
      feld[i][j] = new Feld(i, j, schwarz, leer);
    }
  }
}

void zeichnen() {
  for (int i=1; i<9; i++) 
    for (int j=1; j<9; j++) {
      feld[i][j].zeichnen();
    }
}