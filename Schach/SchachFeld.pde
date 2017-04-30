class Feld {

  int x, y, z, col, figur, partei;
  boolean mausaktiv, aktiv, moglich;


  Feld(int xrichtung, int yrichtung, int zrichtung, int par, int  fig)
  {
    x = xrichtung;
    y = yrichtung;
    z = zrichtung;
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
    if (aktiv) {                        // Farbbesttimmung
      fill(0, 255, 0);
    } else {
      if (partei==weiss) {
        col = figurweiss;
      } else {
        col= figurschwarz;
      }
      if (mausaktiv)  {
        if (partei==weiss) {
          col = figurweiss-60;
        } else {
          col= figurschwarz+60;
        }
      }
      fill(col);
    }    
    if (moglich) fill(255, 0, 0);
    
    if (figur != leer){                // Figur setzen
      figursetzen(x,y,z,figur);
    }else{
      if (moglich)
        figursetzen(x,y,z,kreis);
    }
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