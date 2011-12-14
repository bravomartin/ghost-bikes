
void mapAccidents(int counter) {
  background(0);
  if (counter >locs.length) {
    counter = locs.length;
    println("end");
  }
  for (int i = 0; i < counter; i++) {
    PVector loc = mapVector(locs[i]);

    stroke(255, 50);
      strokeWeight(1);
     if (SHOW) line (loc.x, loc.y, loc.z, here.x, here.y, loc.z);

    PVector hit = findVector(loc);
    hit.normalize();
    hit.mult(45);
    hit.add(new PVector(here.x, here.y, loc.z));
    pushMatrix();
        translate(hit.x, hit.y, hit.z);
        fill(255);
        noStroke();
        sphere(3);
    
    popMatrix();
    pushMatrix();
      translate(loc.x, loc.y, loc.z);
      fill(100);
      noStroke();
      if (SHOW) sphere(3);
      //ellipse(loc.x, loc.y, 6, 6);  
      float angle = findAngle(loc);
      fill(255, 100, 100);
      angle = Math.round(angle*100.0)/100.0;
      textSize(9);
     if (IN3D)  rotateX(-PI/2);
       if (SHOW) text(angle+ " / on " + dates[i].toString(), 5, 3, 0);
    popMatrix();


  }
  fill(255, 0, 0);
  pushMatrix();
  
  translate (here.x, here.y, 0);
//  stroke(50);
//  strokeWeight(40);
//  line(0,0,0,0,0,200);
  noStroke();
  fill(40);
  rotateX(PI/2);
  translate(0,100,0);
  cylinder(40,200,30);
  popMatrix();
}


void accidentsDates(int counter) {
  background(0);
    strokeWeight(1);
  for (int i = 0; i < counter; i++) {
    fill(255);
    stroke(255);
    strokeWeight(1);
    float x = map (times[i], min(times), max(times), 30, width-30 );

    float y = height/2+random(-300, 300);
    ellipse(x, ypos[i], 7, 7);
    textSize(9);
    if(SHOW) text(dates[i].toString(), x, ypos[i]);
  }
    if (counter == 0) counter =1;
    float x = map (times[counter-1], min(times), max(times), 30, width-30 );
    textSize(10);

    if(!SHOW) text(dates[counter-1].toString(), x, ypos[counter-1]);

  float m = (width-20)/(15);
  for (int i = 0; i<15; i++) {

    stroke(255);
    line(10+m*i, 0, 10+m*i, height);
  }
}

