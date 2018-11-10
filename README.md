# APRS-simulator
Send APRS with processing <br>
F4GOH Anthony f4goh@orange.fr <br>
https://hamprojects.wordpress.com/
<br>
## Send APRS sentences on APRS server ##
- Position.
-	Weather.
-	Telemetry.

## Installation ##
To use the APRS-simulator :  
- Go to https://github.com/f4goh/APRS-simulator, click the [Download ZIP](https://github.com/f4goh/APRS-simulator/archive/master.zip) button and save the ZIP file to a convenient location on your PC.
- Uncompress the downloaded file.  This will result in a folder containing all the files for the library, that has a name that includes the branch name, usually APRS-simulator-master.
- Rename the folder to  APRS-simulator.

- to run it, install processing : <br>
  Go to https://processing.org/download/
  
## Usage notes ##

In setup change the callSign and use your password xxxxx <br>
change or delete filter request <br>

```c++
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
```
key p : send position <br>
key x : send weather <br>
key u : send telemetry Units <br>
key t : send telemetry Data <br>

Increase #003 number at each telemetry Data

```c++
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
```
