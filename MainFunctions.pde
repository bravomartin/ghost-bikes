
void mapAccidents(int counter) {
  background(0);
  if (counter >locs.length) {
    counter = locs.length;
    println("end");
  }
  for (int i = 0; i < counter; i++) {
    PVector loc = mapVector(locs[i]);

    stroke(255, 50);
    line (loc.x, loc.y, loc.z, here.x, here.y, loc.z);
    fill(255);
    noStroke();
    pushMatrix();
      translate(loc.x, loc.y, loc.z);
      sphere(10);
      //ellipse(loc.x, loc.y, 6, 6);  
      float angle = findAngle(loc);
      fill(255, 100, 100);
      angle = Math.round(angle*100.0)/100.0;
      textSize(9);
      rotateX(-PI/2);
      text(angle+ " / on " + dates[i].toString(), 5, 3, 0);
    popMatrix();


  }
  fill(255, 0, 0);
  ellipse (here.x, here.y, 10, 10);
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

