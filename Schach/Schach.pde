final int schwarz = 0;
final int weiss = 1;
final int feldweiss = 253;    // Farben 
final int feldschwarz = 72;
final int figurweiss = 243;
final int figurschwarz = 82;

final int anzEbenen = 3;
final int startEbene = 2;

final int leer = -1;
final int turm = 1;
final int springer = 2 ;
final int laufer = 3 ;
final int konig = 4 ;
final int dame = 5 ;
final int bauer = 6 ;
final int kreis = 7;


Feld[][][] feld;
int[] geschlagenSchwarz = {} ;
int[] geschlagenWeis = {} ;
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
  setBrettdir(); //findet heraus in welche Richtung die verschiedenen Ebenen verschoben werden

  aktivefigur();

  brett();
  zeichnen();
  //println(frameRate);
  //coordAxis();
}

void mouseClicked() {
  
  if (!bewegung) {          // hier wird erst eine Figur ausgewählt die bewegt wird (Figur ist noch nicht ausgewählt)

    removemoglich(); // alle Möglichen Felder zurücksetzen

    for (int i=1; i<9; i++) 
      for (int j=1; j<9; j++)
        for (int k=1; k<=anzEbenen; k++) {
          if (feld[i][j][k].getpartei()==aktiverSpieler)
            feld[i][j][k].setaktiv(true);

          if (feld[i][j][k].getaktiv()) {      // finde das aktive Feld
            bewegung = findeZugmogl(i, j, k);
          }
        }
  } else {    // umplatzieren der Figur
    int a, b, c;

    a=1; 
    b=1;
    c=1;
    for (int i=1; i<9; i++)                               // speichert die bereits aktive Figur
      for (int j=1; j<9; j++)
        for (int k=1; k<=anzEbenen; k++) {
          if (feld[i][j][k].getaktiv()) {
            a=i; 
            b=j;  
            c=k;
          }
        }

    for (int i=1; i<9; i++) 
      for (int j=1; j<9; j++)
        for (int k=1; k<=anzEbenen; k++) {
          feld[i][j][k].setaktiv(true);
          if (feld[i][j][k].getaktiv()) {                                // finde das aktive Feld  &&feld[i][j].getmoglich()
            if (feld[i][j][k].getmoglich()) {
              if (aktiverSpieler==weiss) {                                // aktiver Spieler wechselt und geschlagene Figur wird gemerkt
                aktiverSpieler=schwarz;
                if (feld[i][j][k].getfigur()!= leer)
                  geschlagenSchwarz = append(geschlagenSchwarz, feld[i][j][k].getfigur());
              } else { 
                aktiverSpieler=weiss;
                if (feld[i][j][k].getfigur()!= leer)
                  geschlagenWeis = append(geschlagenWeis, feld[i][j][k].getfigur());
              }
              feld[i][j][k].setfigur( feld[a][b][c].getfigur());              // Figuren tauschen
              feld[i][j][k].setpartei( feld[a][b][c].getpartei());          
              feld[a][b][c].setfigur(leer);
            } else {
              if ((feld[i][j][k].getfigur()!=leer)&&(feld[i][j][k].getpartei()==aktiverSpieler)) {                        // ansonsten wird neue Figur aktiv
                bewegung=false;
                mouseClicked();
                return;
              }
            }
          }
          feld[i][j][k].setaktiv(false);
          bewegung=false;
        }
    removemoglich();
  }
}

void removemoglich() {

  for (int i=1; i<9; i++) 
    for (int j=1; j<9; j++)
      for (int k=1; k<=anzEbenen; k++) {
        feld[i][j][k].setmoglich(false);
      }
}

void aktivefigur() {              // findet Schnittpunkt des Betrachters mit der Schachfeld Ebene und prüft welches Feld dadurch aktiv ist
  float t, x, y;
  for (int ebene=1; ebene < anzEbenen +1; ebene++) {
    float z = ebenenscl*(ebene-startEbene);
    PVector eye, dir;
    eye = getAuge();
    dir = getRichtung();
    t = (z-eye.z)/dir.z;
    x = eye.x + t*dir.x-brettdirx[ebene];    // offset abziehen der von der Verschiebung der Ebenen kommt
    y = eye.y + t*dir.y-brettdiry[ebene];
    for (int i=1; i<9; i++) 
      for (int j=1; j<9; j++) {
        feld[i][j][ebene].mausaktiv(x, y);
      }
  }
}



void zeichnen() {
  for (int i=1; i<9; i++) 
    for (int j=1; j<9; j++) 
      for (int k=1; k<anzEbenen+1; k++) {
        feld[i][j][k].zeichnen();
      }

  for (int i=0; i<geschlagenSchwarz.length; i++) {
    fill(figurschwarz);
    figursetzen(i+1, -1, startEbene, geschlagenSchwarz[i]);
  }

  for (int i=0; i<geschlagenWeis.length; i++) {
    fill(figurweiss);
    figursetzen(i+1, 10, startEbene, geschlagenWeis[i]);
  }
}