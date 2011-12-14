//1995-04-04 07:00:00
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");

// duration to which it will scale the time.
int DURATION = 1000*60*15;

// Control Variables
boolean TIMED = true;
boolean IN3D = true;
boolean MOUSE = false;
boolean SHOW = false;
boolean MAPP = false;

String here_addr = "721 Broadway, NY 10003";
String home_addr = "159 Ellery Street, NY 11206";
PVector here, home;
PVector[] locs;
Date[] dates;
Date first, last;
float[] times, scaledTimes;
float time;
float x_max, x_min, y_max, y_min;
int[] deaths;

float[] ypos;

int counter = 0;
float[] randomRotations;


void setup() {
  String[] DATA = loadStrings("bike_fatalities_with_hour.csv");
  size(1000, 700, OPENGL);
  smooth();

  locs = new PVector[DATA.length];
  dates = new Date[DATA.length];
  deaths = new int[DATA.length];
  times = new float[DATA.length];
  scaledTimes = new float[DATA.length];
  randomRotations = new float[DATA.length];
  ypos = new float[DATA.length];

  here = getLatLon(here_addr);
  home = getLatLon(home_addr);
  here = mapVector(here);
  home = mapVector(home);

  for (int i = 0; i < DATA.length; i++) {
    String[] splits = DATA[i].split(",");
    locs[i] = new PVector (float(splits[2]), float(splits[3]), 0);
    try {
      dates[i] =  sdf.parse(splits[0]);
      times[i] = (float)dates[i].getTime();
      ypos[i] =  height/2+random(-300, 300);
    } 
    catch (Exception e) {
      println(e);
    }
    deaths[i] = int(splits[1]);
  }

  //calculate scaling // commented out because it's hard coded in the function now... we know we're talking about ny.
  //  x_max = max(x_coord);
  //  y_max = max(y_coord);
  //  x_min = min(x_coord);
  //  y_min = min(y_coord);
  //  float x_delta = x_max-x_min;
  //  float y_delta = y_max-y_min;
  //  float dif = x_delta-y_delta;
  //  //make y proportional to x
  //  y_max+=dif;

  findExtremeDates(dates);
  // accidentsDates();
  for (int i = 0; i < times.length; i++) {
    times[i] = times[i]-first.getTime();
    scaledTimes[i] = map(times[i], 0, last.getTime()-first.getTime(), 0, DURATION);
    locs[i].z = map(times[i], 0, last.getTime()-first.getTime(), 0, 200);
    //  println(locs[i].z);
  }
} 

void draw() {
  if (IN3D) {
    //  scale(.6);
    translate(here.x, here.y, 0 );
    translate(90, 250);
    println(mouseX+" "+mouseY);
    rotateX(PI/2);
    rotateZ(mouseY*0.01);  
    translate(-here.x, -here.y, 0 );
    //  rotateY(/1000.0);
  }
  for (int i = 0; i < scaledTimes.length; i++) {
    if (TIMED) {    
      if (millis()-2000 > scaledTimes[i] && counter < i ) {
        counter = i;
      }
    } 
    else {
      float mouse = map(mouseX, 0, width, scaledTimes[0], scaledTimes[scaledTimes.length-1]); 
      if (mouse > scaledTimes[i]) {
        counter = i;
      }
    }
  }
  if (MAPP && !IN3D) {
    accidentsDates(counter);
  }
  else {
    mapAccidents(counter);
  }
}

void keyPressed() {
  if (key == '3') {
    IN3D = !IN3D;
  }
  if (key == 't' || key == 'T') {
    TIMED = !TIMED;
  }
  if (key == 's' || key == 'S') {
    SHOW = !SHOW;
  }
  if (key == 'm' || key == 'M') {
    MAPP = !MAPP;
    IN3D = !IN3D;
  }
}

