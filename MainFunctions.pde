
void mapAccidents(int top) {
  background(0);
  if(top >locs.length) top = locs.length;

  for (int i = 0; i < top; i++) {
    PVector loc = mapVector(locs[i]);

    stroke(255, 50);
    line (loc.x, loc.y, here.x, here.y);

    fill(255);
    noStroke();
    ellipse(loc.x, loc.y, 6, 6);
    float angle = findAngle(loc);

    fill(255, 100, 100);
    textSize(9);
    text(angle+ ' ' + dates[i].toString(), loc.x, loc.y);
  }
  fill(255, 0, 0);
  ellipse (here.x, here.y, 10, 10);
  fill(0, 255, 0);
  ellipse (home.x, home.y, 10, 10);
}


void accidentsDates() {
  background(0);
  for (int i = 0; i < dates.length; i++) {
    fill(255);
    stroke(255);
    float x = map (times[i], min(times), max(times), 30, width-30 );

    float y = height/2+random(-300, 300);
    ellipse(x, y, 7, 7);
    textSize(7);
    text(dates[i].toString(), x, y);
  }
  float m = (width-20)/(15);
  for (int i = 0; i<15; i++) {

    stroke(255);
    line(10+m*i, 0, 10+m*i, height);
  }
}

