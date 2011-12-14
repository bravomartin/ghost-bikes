PVector mapVector (PVector p) {
  x_max = -73.712616; // these values were calculated for this particular dataset for the dots to fit the screen
  x_min = -74.17148;
  y_max = 40.895218;
  y_min = 40.436356;
  PVector out = new PVector(map(p.x, x_min, x_max, 20, width-20), 50+map(p.y, y_max, y_min, 20, height-20),p.z);  
  return out;
}


void findExtremeDates(Date[] dates) {
  try {
    last = sdf.parse("1990-01-01T00:00:00");
    first = sdf.parse("2020-01-01T00:00:00");
  }
  catch (Exception e) {
    println(e);
  }
  for (int i = 1; i < dates.length; i++) {
      if (dates[i].after(last)) {
      last = dates[i];
    }
    if (dates[i].before(first)) {
      first = dates[i];
    }
  }
}



PVector getLatLon(String location) {
  String[] words = split(location, ' ');
  location = join(words, '+');
  String geoURL = "http://maps.google.com/maps/geo";
  //Construct the url
  String url = geoURL + "?output=csv&key=abcdefg&q=" + location;
  //Load the data
  String[] input = loadStrings(url);
  //The data comes in as an array of strings that is 1 string long. 
  //Here we take the first string and split it by a comma to get 4 strings. 
  String[] numberStrings = input[0].split(",");
  //We do this to be/get a pair of floating point numbers, so we may convert them. 
  //  println(input); 
  PVector LatLon = new PVector(float(numberStrings[3]), float(numberStrings[2]),0);
  //Now we send back the floating point numbers as a pair
  return(LatLon);
}



PVector findVector (PVector p) {
    PVector pp = PVector.sub(p,here);
  return pp;
}

float findAngle (PVector p) {
  PVector axis = new PVector(0,-100,0);
  PVector pp = findVector(p);
  float a = PVector.angleBetween(axis, pp);

  return degrees(a);
}





/**
cylinder taken from http://wiki.processing.org/index.php/Cylinder
@author matt ditton
*/
 
void cylinder(float w, float h, int sides)
{
  float angle;
  float[] x = new float[sides+1];
  float[] z = new float[sides+1];
 
  //get the x and z position on a circle for all the sides
  for(int i=0; i < x.length; i++){
    angle = TWO_PI / (sides) * i;
    x[i] = sin(angle) * w;
    z[i] = cos(angle) * w;
  }
 
  //draw the top of the cylinder
  beginShape(TRIANGLE_FAN);
 
  vertex(0,   -h/2,    0);
 
  for(int i=0; i < x.length; i++){
    vertex(x[i], -h/2, z[i]);
  }
 
  endShape();
 
  //draw the center of the cylinder
  beginShape(QUAD_STRIP); 
 
  for(int i=0; i < x.length; i++){
    vertex(x[i], -h/2, z[i]);
    vertex(x[i], h/2, z[i]);
  }
 
  endShape();
 
  //draw the bottom of the cylinder
  beginShape(TRIANGLE_FAN); 
 
  vertex(0,   h/2,    0);
 
  for(int i=0; i < x.length; i++){
    vertex(x[i], h/2, z[i]);
  }
 
  endShape();
}
