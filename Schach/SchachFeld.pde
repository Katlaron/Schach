class Feld {

  int x, y, col, figur, partei;
  boolean mausaktiv, aktiv, moglich;


  Feld(int xrichtung, int yrichtung, int par, int  fig)
  {
    x = xrichtung;
    y = yrichtung;
    if (partei==weiss) {
      col = figurweiss;
    } else {
      col= figurschwarz;
    }
    partei= par;
    figur = fig;
    aktiv = false;
    mausaktiv = false;
    moglich = false;
  }

  void zeichnen() {
    if (aktiv) {
      fill(0, 255, 0);
    } else {
      if (partei==weiss) {
        col = figurweiss;
      } else {
        col= figurschwarz;
      }
      fill(col);
      if (mausaktiv) fill( 255/2);
    }
    
    if (moglich) fill(255, 0, 0);
    
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
    }
    if ((figur == leer)&&(moglich))
      kreis(x, y);
  }

  void setmoglich(boolean m) {
    moglich = m;
  }

  boolean getmoglich() {
    return moglich;
  }

  void setaktiv(boolean a) {

    if (mausaktiv&&a) {
      aktiv = true;
    } else aktiv = false;
  }


  boolean getaktiv() {
    return aktiv;
  }

  void setfigur(int f) {
    figur =f;
  }

  int getfigur() {
    return figur;
  }

  void setpartei(int p) {
    partei = p;
  }

  int getpartei() {
    return partei;
  }

  void mausaktiv(float xmaus, float ymaus) {
    if ((abs(xmaus-x*scl+scl/2)<scl/2)&&((abs(ymaus-y*scl+scl/2)<scl/2))) {
      mausaktiv = true;
    } else {
      if (partei==weiss) {
        col = figurweiss;
      } else {
        col= figurschwarz;
      }
      mausaktiv = false;
    }
  }
}