PVector[][] atoms = new PVector[5][4]; // Matrice pentru pozițiile atomilor 
float[] moleculeDiameters = {50, 50, 50, 50, 50}; // Diametrele moleculelor (în aceeași ordine în care sunt definite)
 
// Vectori de transformare pentru fiecare moleculă
PVector[] moleculeScale = new PVector[5];
PVector[] moleculeTranslation = new PVector[5];
PVector[] moleculeRotation = new PVector[5];
 
float rotationX = 0;
float rotationY = 0;
float rotationZ = 0;
 
int selectedMolecule = 0; // Indexul moleculei selectate în prezent
 
String [] moleculeNames = {"H2O","CO2","NH3","CH4","NaNO3"};//Vector cu numele moleculelor

int buttonWidth = 140; // Dimensiune mai mare
int buttonHeight = 50; // Dimensiune mai mare
int buttonSpacing = 20; // Spațiere mai mare

void setup() {
  size(1200,1000, P3D);
  noFill();
  stroke(0);
  // Inițializarea vectorilor de transformare pentru fiecare moleculă
  for (int i = 0; i < 5; i++) {
    moleculeScale[i] = new PVector(1, 1, 1);
    moleculeTranslation[i] = new PVector(0, 0, 0);
    moleculeRotation[i] = new PVector(0, 0, 0);
  }
  // Apa (H2O)
  atoms[0][0] = new PVector(0, 0, 0); // Oxigen
  atoms[0][1] = new PVector(50, 50, 0); // Hidrogen 1
  atoms[0][2] = new PVector(-50, 50, 0); // Hidrogen 2
  // Dioxid de carbon (CO2)
  atoms[1][0] = new PVector(0, 0, 0); // Carbon
  atoms[1][1] = new PVector(50, 0, 0); // Oxigen 1
  atoms[1][2] = new PVector(-50, 0, 0); // Oxigen 2
  // Amoniac (NH3)
  atoms[2][0] = new PVector(0, 0, 0); // Azot
  atoms[2][1] = new PVector(50, 50, 0); // Hidrogen 1
  atoms[2][2] = new PVector(-50, 50, 0); // Hidrogen 2
  atoms[2][3] = new PVector(0, -50, 0); // Hidrogen 3
  // Metan (CH4)
  atoms[3][0] = new PVector(0, 0, 0); // Carbon
  atoms[3][1] = new PVector(50, 0, 50); // Hidrogen 1
  atoms[3][2] = new PVector(-50, 0, -50); // Hidrogen 2
  // Nitrat de sodiu (NaNO3)
  atoms[4][0] = new PVector(0, 0, 0); // Azot
  atoms[4][1] = new PVector(50, 0, 0); // Oxigen 1
  atoms[4][2] = new PVector(-50, 0, 0); // Oxigen 2
  atoms[4][3] = new PVector(0, 50, 0); // Sodiu
  // Crearea butoanelor pentru selecția moleculei și transformări
}
 
void draw() {
  background(255, 255, 0); // Fundal galben
  lights();
  createButtons();
  // Desenarea moleculelor
  translate(width/2, height/2, 0);
  rotateX(rotationX);
  rotateY(rotationY);
  rotateZ(rotationZ);
  for (int j = 0; j < atoms[selectedMolecule].length; j++) {
    if (selectedMolecule == 0) {
      if (j == 0) {
        fill(255, 0, 0); // Roșu pentru oxigen în H2O
      } else {
        fill(255); // Alb pentru hidrogen în H2O
      }
    } else if (selectedMolecule == 1) {
      if (j == 0) {
        fill(0, 255, 0); // Verde pentru carbon în CO2
      } else {
        fill(255, 0, 0); // Alb pentru oxigen în CO2
      }
    } else if (selectedMolecule == 2) {
      if (j == 0) {
        fill(0, 0, 255); // Albastru pentru azot în NH3
      } else {
        fill(255); // Alb pentru hidrogen în NH3
      }
    } else if (selectedMolecule == 3) {
      if (j == 0) {
        fill(0, 255, 0); // Verde pentru carbon în CH4
      } else {
        fill(255); // Alb pentru hidrogen în CH4
      }
    } else if (selectedMolecule == 4) {
      if (j == 0) {
        fill(0, 0, 255); // Albastru pentru azot în NaNO3
      } else if (j == 3) {
        fill(255, 165, 0); // Portocaliu pentru sodiu în NaNO3
      } else {
        fill(255, 0, 0); // Alb pentru oxigen în NaNO3
      }
    }
    // Aplicarea transformărilor
    pushMatrix();
    translate(moleculeTranslation[selectedMolecule].x, moleculeTranslation[selectedMolecule].y, moleculeTranslation[selectedMolecule].z);
    rotateX(moleculeRotation[selectedMolecule].x);
    rotateY(moleculeRotation[selectedMolecule].y);
    rotateZ(moleculeRotation[selectedMolecule].z);
    scale(moleculeScale[selectedMolecule].x, moleculeScale[selectedMolecule].y, moleculeScale[selectedMolecule].z);
    drawAtom(atoms[selectedMolecule][j], moleculeDiameters[selectedMolecule]);
    popMatrix();
  }
  // Desenarea butoanelor și etichetelor
  drawButtons();
}
 
void drawAtom(PVector pos, float diameter) {
  if (pos != null) {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    sphere(diameter);
    popMatrix();
  } else {
    println("");
  }
}
 
void keyPressed() {
  if (key == 'x') {
    rotationX += PI/8;     // rotatie in jurul axei X
  }else if (key == 'y') { 
    rotationY += PI/8;     // rotatie in jurul axei Y
  }else if (key == 'z') {
    rotationZ += PI/8;     // rotatie in jurul axei Z
  }else if (key == '+') {
    zoomIn();              // scalare in plus
  }else if (key == '-') {
    zoomOut();             //scalare in minus
  }else if (key == 'w') {
    moveUp();              //translatie in sus
  }else if (key == 's') {
    moveDown();            //translatie in jos
  }else if (key == 'a') {
    moveLeft();            //translatie in stanga 
  }else if (key == 'd') {
    moveRight();           //translatin in dreapta
  }else if (key == '1') {
    selectedMolecule = 0;  // H2O
  } else if (key == '2') {
    selectedMolecule = 1;  // CO2
  } else if (key == '3') {
    selectedMolecule = 2;  // NH3
  } else if (key == '4') {
    selectedMolecule = 3;  // CH4
  } else if (key == '5') {
    selectedMolecule = 4;  // NaNO3
  }
}
 
void createButtons() {
  // Definirea proprietăților butonului
  textSize(20); // Dimensiunea textului mai mare

  // Butoanele pentru transformarea moleculei
  fill(255);
  rect(20, 20, buttonWidth, buttonHeight);
  fill(0);
  textAlign(CENTER, CENTER);
  text("Rotate (x, y, z)", 20 + buttonWidth / 2, 20 + buttonHeight / 2);

  fill(255);
  rect(20, 80, buttonWidth, buttonHeight);
  fill(0);
  textAlign(CENTER, CENTER);
  text("Translate", 20 + buttonWidth / 2, 80 + buttonHeight / 2);

  // Butoanele de zoom
  fill(255);
  rect(20, 140, buttonWidth, buttonHeight);
  fill(0);
  textAlign(CENTER, CENTER);
  text("Scale", 20 + buttonWidth / 2, 140 + buttonHeight / 2);

  fill(255);
  rect(20, 200, buttonWidth / 2, buttonHeight / 2); // Butonul "+"
  rect(90, 200, buttonWidth / 2, buttonHeight / 2); // Butonul "-"
  fill(0);
  textAlign(CENTER, CENTER);
  text("+", 20 + buttonWidth / 4, 200 + buttonHeight / 4);
  text("-", 90 + buttonWidth / 4, 200 + buttonHeight / 4);

  // Butoanele de deplasare
  fill(255);
  rect(20, 260, buttonWidth + 20, buttonHeight);
  fill(0);
  textAlign(CENTER, CENTER);
  text("Translate Controls", 30 + buttonWidth / 2, 260 + buttonHeight / 2);

  fill(255);
  rect(20, 320, buttonWidth / 2, buttonHeight / 2); // Sus
  rect(90, 320, buttonWidth / 2, buttonHeight / 2); // Jos
  rect(20, 360, buttonWidth / 2, buttonHeight / 2); // Stanga
  rect(90, 360, buttonWidth / 2, buttonHeight / 2); // Dreapta
  fill(0);
  textAlign(CENTER, CENTER);
  text("↑(W)", 20 + buttonWidth / 4, 320 + buttonHeight / 4);
  text("↓(S)", 90 + buttonWidth / 4, 320 + buttonHeight / 4);
  text("←(A)", 20 + buttonWidth / 4, 360 + buttonHeight / 4);
  text("→(D)", 90 + buttonWidth / 4, 360 + buttonHeight / 4);

  // Butoanele de selecție a moleculei
  for (int i = 0; i < 5; i++) {
    fill(255);
    rect(width - buttonWidth - 40, 300 + i * (buttonHeight + buttonSpacing), buttonWidth, buttonHeight);
    fill(0);
    textAlign(CENTER, CENTER);
    text((i + 1) + ". " + moleculeNames[i], width - buttonWidth / 2 - 40, 300 + i * (buttonHeight + buttonSpacing) + buttonHeight / 2);
  }
}
 
void drawButtons() {
  // Verificarea dacă mouse-ul este apăsat peste butoane
  if (mousePressed) {
    // Verificarea butoanelor pentru transformare
    if (mouseX >= 20 && mouseX <= 20 + 140 && mouseY >= 20 && mouseY <= 20 + 50) {
      // Butonul pentru rotire
      rotateMolecule();
    } else if (mouseX >= 20 && mouseX <= 20 + 140 && mouseY >= 80 && mouseY <= 80 + 50) {
      // Butonul pentru translatare
      translateMolecule();
    } else if (mouseX >= 20 && mouseX <= 20 + 140 && mouseY >= 140 && mouseY <= 140 + 50) {
      // Butonul pentru zoom
      zoomMolecule();
    } else if (mouseX >= 20 && mouseX <= 20 + 70 && mouseY >= 200 && mouseY <= 200 + 25) {
      // Butonul "+" pentru zoom in
      zoomIn();
    } else if (mouseX >= 90 && mouseX <= 90 + 70 && mouseY >= 200 && mouseY <= 200 + 25) {
      // Butonul "-" pentru zoom out
      zoomOut();
    } else if (mouseX >= 20 && mouseX <= 20 + 160 && mouseY >= 260 && mouseY <= 260 + 50) {
      // Butonul pentru controlul translatării
      moveMolecule();
    } else if (mouseX >= 20 && mouseX <= 20 + 70 && mouseY >= 320 && mouseY <= 320 + 25) {
      // Butonul pentru deplasarea în sus
      moveUp();
    } else if (mouseX >= 90 && mouseX <= 90 + 70 && mouseY >= 320 && mouseY <= 320 + 25) {
      // Butonul pentru deplasarea în jos
      moveDown();
    } else if (mouseX >= 20 && mouseX <= 20 + 70 && mouseY >= 360 && mouseY <= 360 + 25) {
      // Butonul pentru deplasarea la stânga
      moveLeft();
    } else if (mouseX >= 90 && mouseX <= 90 + 70 && mouseY >= 360 && mouseY <= 360 + 25) {
      // Butonul pentru deplasarea la dreapta
      moveRight();
    }
    // Verificarea butoanelor de selecție a moleculei
    for (int i = 0; i < 5; i++) {
      int buttonY = 300 + i * (buttonHeight + buttonSpacing);
      if (mouseX >= width - 40 - 140 && mouseX <= width - 40 && mouseY >= buttonY && mouseY <= buttonY + 50) {
        selectedMolecule = i;
      }
    }
  }
}
 
void rotateMolecule() {
  if (selectedMolecule >= 0 && selectedMolecule < moleculeRotation.length) {
    moleculeRotation[selectedMolecule].x += PI / 8;
  }
}
 
void translateMolecule() {
  if (selectedMolecule >= 0 && selectedMolecule < moleculeTranslation.length) {
    moleculeTranslation[selectedMolecule].x += 10;
  }
}
 
void zoomMolecule() {
  if (selectedMolecule >= 0 && selectedMolecule < moleculeScale.length) {
    moleculeScale[selectedMolecule].mult(1.1);
  }
}
 
void zoomIn() {
  zoomMolecule();
}
 
void zoomOut() {
  if (selectedMolecule >= 0 && selectedMolecule < moleculeScale.length) {
    moleculeScale[selectedMolecule].mult(0.9);
  }
}
 
void moveMolecule() {
  // No need to implement, as translateMolecule already handles movement
}
 
void moveUp() {
  if (selectedMolecule >= 0 && selectedMolecule < moleculeTranslation.length) {
    moleculeTranslation[selectedMolecule].y -= 10;
  }
}
 
void moveDown() {
  if (selectedMolecule >= 0 && selectedMolecule < moleculeTranslation.length) {
    moleculeTranslation[selectedMolecule].y += 10;
  }
}
 
void moveLeft() {
  if (selectedMolecule >= 0 && selectedMolecule < moleculeTranslation.length) {
    moleculeTranslation[selectedMolecule].x -= 10;
  }
}
 
void moveRight() {
  if (selectedMolecule >= 0 && selectedMolecule < moleculeTranslation.length) {
    moleculeTranslation[selectedMolecule].x += 10;
  }
}
