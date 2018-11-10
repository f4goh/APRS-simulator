/**
  APRS simulator on APRS.fi
 info qar http://www.aprs-is.net/q.aspx
  http://digined.pe1mew.nl/tools/phgcalculator.htm  P27
 telemetry samples on F5ILB-3
 
 */


import processing.net.*;

int gmt=+1;


Client c;

void setup() 
{
  size(450, 255);
  background(204);    
  // Connect to the server's IP address and port
  c = new Client(this, "euro.aprs2.net", 14580);
  if (c.active() == true) {
    println("connecte au serveur");
    c.write("user F4GOH-2 pass xxxxx vers Processing simulation filter b/F4GOH-11\n");
    c.write("F4GOH-2>APRS:!4753.41NI00016.61E&PHG7160/Processing simulation\n");
  } else {
    println("non connecte au serveur");
  }
}


void draw() 
{
}

void keyPressed()
{
  String heure=horaire();
  if (key=='p') {
    c.write("F4GOH-10>APRS,WIDE1-1,WIDE2-1,qAR,F4GOH-2:/"+heure+"4753.42N/00016.62Eb/bike\n");
    println("position...");
  }
  if (key=='w') {
    c.write("F4GOH-9>APRS,WIDE1-1,WIDE2-1,qAR,F4GOH-2:/"+heure+"4753.43N/00016.60E_.../...g...t0020r...p...P...h60b10130\n"); //page 70
    println("Weather...");
  }

  if (key=='u') {
    c.write("F4GOH-10>APRS,WIDE1-1,WIDE2-1,qAR,F4GOH-2::F4GOH-10 :PARM.Temp sea,Temp ext,Vbat,Ocean waves\n"); //page 75
    c.write("F4GOH-10>APRS,WIDE1-1,WIDE2-1,qAR,F4GOH-2::F4GOH-10 :UNIT.Deg C,Deg C,Volts,Meters\n");          //page 75
    c.write("F4GOH-10>APRS,WIDE1-1,WIDE2-1,qAR,F4GOH-2::F4GOH-10 :EQNS.0,1,-100,0,1,-100,0,0.1,0,0,0.1,0\n"); //page 76
    c.write("F4GOH-10>APRS,WIDE1-1,WIDE2-1,qAR,F4GOH-2::F4GOH-10 :BITS.00000000,Telemetry\n");                 //page 76
    println("telemetry Units...");
  }
  if (key=='t') {
    c.write("F4GOH-10>APRS,WIDE1-1,WIDE2-1,qAR,F4GOH-2:T#003,120,115,135,5,000,00000000\n"); //page 74
    println("telemetry Data...");
  }
}


String horaire()
{
  int heure=hour();
  heure=heure-gmt;
  if (heure<0) heure+=gmt;
  return nf(heure, 2)+nf(minute(), 2)+nf(second(), 2)+"z";
}


void clientEvent(Client someClient) {
  String input;
  input = c.readString();
  print(input);  //char by char
}

void exit() {
  c.stop();
}
