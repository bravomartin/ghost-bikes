PVector mapVector (PVector p) {
  x_max = -73.712616; // these values were calculated for this particular dataset for the dots to fit the screen
  x_min = -74.17148;
  y_max = 40.895218;
  y_min = 40.436356;
  PVector out = new PVector(map(p.x, x_min, x_max, 20, width-20), 50+map(p.y, y_max, y_min, 20, height-20));  
  return out;
}


void findExtremeDates(Date[] dates) {

  int minFrequency = 0;

  try {
    last = sdf.parse("1990-01-01T00:00:00");
    first = sdf.parse("2020-01-01T00:00:00");
  }
  catch (Exception e) {
    println(e);
  }

  for (int i = 0; i < dates.length; i++) {

    if (i > 1) {
      if (!dates[i].after(dates[i-1])) {
        println(dates[i] + "   " + dates[i-i]);
      }
    }


    if (dates[i].after(last)) {
      last = dates[i];
    }
    if (dates[i].before(first)) {
      first = dates[i];
    }
  } 
  println("first: " +first);
  println("last: " +last);
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
  println(numberStrings);
  //  println(input); 
  PVector LatLon = new PVector(float(numberStrings[3]), float(numberStrings[2]) );
  //Now we send back the floating point numbers as a pair
  return(LatLon);
}


float findAngle (PVector p) {
  PVector axis = new PVector(0,-100);
//  axis.add(here);
  PVector pp = PVector.sub(p,here);
  float a = PVector.angleBetween(here, pp);
  
  return degrees(a);
  
  
  
}

