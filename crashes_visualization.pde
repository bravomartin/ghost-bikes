//1995-04-04 07:00:00
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");

// add vectors

//my vector
String here_addr = "721 Broadway, NY 10003";
String home_addr = "159 Ellery Street, NY 11206";
PVector here, home;
PVector[] locs;
Date[] dates;
Date first, last;
float[] times;
float x_max, x_min, y_max, y_min;
int[] deaths;

void setup(){
 String[] DATA = loadStrings("bike_fatalities_with_hour.csv");
  size(1000, 700);
  smooth();

  locs = new PVector[DATA.length];
  dates = new Date[DATA.length];
  deaths = new int[DATA.length];
  times = new float[DATA.length];

  here = getLatLon(here_addr);
  home = getLatLon(home_addr);
  here = mapVector(here);
  home = mapVector(home);

  for (int i = 0; i < DATA.length; i++) {
    String[] splits = DATA[i].split(",");
    locs[i] = new PVector (float(splits[2]), float(splits[3]));
    try {
      dates[i] =  sdf.parse(splits[0]);
      times[i] = (float)dates[i].getTime();
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
}

void draw() {
  float time = millis()/1000;
  mapAccidents(int(time));
}
