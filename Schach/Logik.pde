boolean findeZugmogl(int i, int j, int k) {
  bewegung = false;
  int figureffekt = feld[i][j][k].getfigur();
  switch (figureffekt) {          // Bewegungsmöglichkeiten der Figur bestimmen und damit Felder als möglich markieren
  case bauer: 
    int figurrichtung;
    if (feld[i][j][k].getpartei()==weiss) {
      figurrichtung = 1;
    } else {
      figurrichtung = -1;
    }
    for (int c=-1; c<=1; c++) {
      testeaufmoglichbauer(i, j, k, 0, figurrichtung, c);    // normales nach vorne gehen
      testeaufmoglichbauer(i, j, k, 1, figurrichtung, c);   // zur Seite schlagen
      testeaufmoglichbauer(i, j, k, -1, figurrichtung, c);
    }
    if ((j==2)&&(feld[i][j][k].getpartei()==weiss)) {                           // 2 Felder nach vorn am Start
      if ((feld[i][j+1][k].getfigur()==leer)&&(feld[i][j+2][k].getfigur()==leer))
        feld[i][j+2][k].setmoglich(true);
    }

    if ((j==7)&&(feld[i][j][k].getpartei()==schwarz)) {                         // 2 Felder nach vorn am Start
      if ((feld[i][j-1][k].getfigur()==leer)&&(feld[i][j-2][k].getfigur()==leer))
        feld[i][j-2][k].setmoglich(true);
    }


    /*
    if ((j+figurrichtung>0)&&(j+figurrichtung<9)) {                         // Feld vor dem Bauern
     if (feld[i][j+figurrichtung][k].getfigur()==leer)
     feld[i][j+figurrichtung][k].setmoglich(true);
     }
     if ((j+figurrichtung>0)&&(j+figurrichtung<9)&&(i+1<9)) {                 // Feld rechts vorn
     if ((feld[i+1][j+figurrichtung][k].getfigur()!=leer)&&(feld[i+1][j+figurrichtung][k].getpartei()!=feld[i][j][k].getpartei()))
     feld[i+1][j+figurrichtung][k].setmoglich(true);
     }
     if ((j+figurrichtung>0)&&(j+figurrichtung<9)&&(i-1>0)) {                 // Feld links vorn
     if ((feld[i-1][j+figurrichtung][k].getfigur()!=leer)&&(feld[i-1][j+figurrichtung][k].getpartei()!=feld[i][j][k].getpartei()))
     feld[i-1][j+figurrichtung][k].setmoglich(true);
     }
     if ((j==2)&&(feld[i][j][k].getpartei()==weiss)) {                           // 2 Felder nach vorn am Start
     if ((feld[i][j+1][k].getfigur()==leer)&&(feld[i][j+2][k].getfigur()==leer))
     feld[i][j+2][k].setmoglich(true);
     }
     
     if ((j==7)&&(feld[i][j][k].getpartei()==schwarz)) {                         // 2 Felder nach vorn am Start
     if ((feld[i][j-1][k].getfigur()==leer)&&(feld[i][j-2][k].getfigur()==leer))
     feld[i][j-2][k].setmoglich(true);
     }*/
    bewegung=true;
    break;
  case springer:
    for (int a=-2; a<=2; a++)
      for (int b=-2; b<=2; b++)
        for (int c=-2; c<=2; c++)
          if ((abs(a)+abs(b)+abs(c)==3)&&(a*b*c==0)) 
            testeaufmoglich(i, j, k, a, b, c, false, -1); 
    bewegung = true;
    break;
  case turm:
    for (int a=-1; a<=1; a++)
      for (int b=-1; b<=1; b++)
        for (int c=-1; c<=1; c++)
          if (abs(a)+abs(b)+abs(c)==1)      
            testeaufmoglich(i, j, k, a, b, c, true, -1);
    bewegung = true;
    break;
  case laufer : 
    for (int a=-1; a<=1; a++)
      for (int b=-1; b<=1; b++)
        for (int c=-1; c<=1; c++)
          if (a*b!=0)      
            testeaufmoglich(i, j, k, a, b, c, true, -1);

    bewegung = true;
    break;
  case dame:
    for (int a=-1; a<=1; a++)
      for (int b=-1; b<=1; b++)
        for (int c=-1; c<=1; c++)
          if (!((a==0)&&(b==0)&&(c==0)))
            testeaufmoglich(i, j, k, a, b, c, true, -1);

    bewegung = true;
    break;
  case konig:

    for (int a=-1; a<=1; a++)
      for (int b=-1; b<=1; b++)
        for (int c=-1; c<=1; c++)
          if (!((a==0)&&(b==0)&&(c==0)))
            testeaufmoglich(i, j, k, a, b, c, false, -1);

    bewegung = true;
    break;
  }
  return bewegung;
}

void testeaufmoglich(int i, int j, int k, int hx, int hy, int hz, boolean again, int orginalfarbe) {     //vergleicht ob die Figur von Feld i,j auf hx, hy kann 
  int orgpartei;
  if (orginalfarbe==-1) {
    orgpartei = feld[i][j][k].getpartei();
  } else {
    orgpartei = orginalfarbe;
  }


  if ((i+hx<9)&&(i+hx>0)&&(j+hy<9)&&(j+hy>0)&&(k+hz>0)&&(k+hz<anzEbenen+1)) // überprüft ob die Felder existieren
  {
    if ((feld[i+hx][j+hy][k+hz].getfigur()!=leer)&&(feld[i+hx][j+hy][k+hz].getpartei()!=orgpartei))
      feld[i+hx][j+hy][k+hz].setmoglich(true);
    if (feld[i+hx][j+hy][k+hz].getfigur()==leer) {
      feld[i+hx][j+hy][k+hz].setmoglich(true);
      if (again) {
        //println("x: "+i+" y: "+j+" hx: "+hx+" hy: "+hy);
        testeaufmoglich(i+hx, j+hy, k+hz, hx, hy, hz, true, orgpartei);   // prüft weiter in eine Richtung
      }
    }
  }
}

void testeaufmoglichbauer(int i, int j, int k, int hx, int hy, int hz) {
  if ((i+hx<9)&&(i+hx>0)&&(j+hy<9)&&(j+hy>0)&&(k+hz>0)&&(k+hz<anzEbenen+1)) // überprüft ob die Felder existieren
  {
    if ((hx==0)&&(feld[i+hx][j+hy][k+hz].getfigur()==leer)) {    // wenn der Bauer nur nach vorne geht
      feld[i+hx][j+hy][k+hz].setmoglich(true);
    }
    if ((hx!=0)&&(feld[i+hx][j+hy][k+hz].getfigur()!=leer)&&(feld[i+hx][j+hy][k+hz].getpartei()!=feld[i][j][k].getpartei())) {    // wenn der Bauer diagonalschlagen will
      feld[i+hx][j+hy][k+hz].setmoglich(true);
    }
  }
}