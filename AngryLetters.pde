import java.io.File;

String fileName = "angry.txt";

String mSecret = "";
int fontSize = 400;
int fontAlpha = 1;
int lastDraw;

boolean WEB = true;

void setup() {
  try {
    for (String s: loadStrings(fileName)) {
      mSecret += s.replace(" ", "");
    }
  }
  catch(java.lang.NullPointerException e) {
    println("ERROR: probably couldn't open file. Does "+dataPath(fileName)+" really exist??");
    exit();
  }

  new File(dataPath(fileName)).delete();

  if (WEB) { 
    size(1600, 900);
  }
  else { 
    size(1024, 1600);
  }

  background(255);
  lastDraw = millis()-1000;
}

void draw() {
  if ((millis()-lastDraw > 1000) && fontAlpha<255) {
    background(255);
    drawLetter(fontAlpha);
    String dateTime = ""+year()+pad(month())+pad(day())+pad(hour())+pad(minute())+pad(second());
    save("data/AngryLetters"+dateTime+".png");
    lastDraw = millis();
    fontAlpha *= 2;
  }

  if (fontAlpha>=255) {
    exit();
  }
}

void drawLetter(int fontAlpha) {
  int snap = (WEB)?(width/6):(width/4);
  PVector runLoc = new PVector(0, 0.9*fontSize);
  PVector locVar = new PVector(0.05*fontSize, 0.1*fontSize);

  textFont(createFont("Helvetica", fontSize));
  fill(0, fontAlpha);

  for (char c: mSecret.toCharArray()) {
    float mX = runLoc.x+snap-float(int(runLoc.x)%snap);
    if (mX+textWidth(c) > width) {
      mX = 0;
      runLoc.y += 0.9*fontSize;
    }
    if (runLoc.y > height) {
      runLoc.y = 0.9*fontSize;
    }
    text(c, mX+random(-locVar.x, locVar.x), runLoc.y+random(-locVar.y, locVar.y));
    runLoc.x = mX+textWidth(c);
  }
}

String pad(int i) {
  return (""+(i<10?"0":"")+i);
}

