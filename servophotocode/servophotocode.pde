
// Code for servo to move to pre-determined angle via servo rotation. 
// initial sourced from Circ-09 and Circ-04 arduino and made to fit application.
// As well as code from the arduino playgroud - http://www.arduino.cc/playground/ComponentLib/Servo

#include <Servo.h>              // Initial setup - Telling Arduino that Servo code will be sourced.
#include <Firmata.h>

                                 // Beginning of Int / Servo Fields that link to different fields or start at a 0 value.

int photoResistor = 1;                                  // This tells Arduino to source the Photoresistor from analogue pin 0 on the board. 
int photoLightValue = 0;                                // This sets the initial value of light to 0.
int temperaturePin = 0;                                 // This tells Arduino to source the Temperature sensor from analogue pin 1 on the board.

const int RED_LED_PIN = 9;
const int GREEN_LED_PIN = 10;
const int BLUE_LED_PIN = 11;


  int redIntensity = 0;
 int greenIntensity = 0;
 int blueIntensity = 0;



  int ledPin = 8;


Servo servomotor1;                                      // This tells Arduino that a single servo motor is being used and names it servomotor1.
Servo servomotor2;                                      // This tells Arduino that a single servo motor is being used and names it servomotor2.
Servo servomotor3;                                      // This tells Arduino that a single servo motor is being used and names it servomotor3.

int motor1 = 3;                                          // Links the motor1 "string" to pin 3.
int motor2 = 4;                                          // Links the motor2 "string" to pin 4.
int motor3 = 5;                                          // Links the motor3 "string" to pin 4.

int ServoOutput = 0;




void setup()                                             // Begining of Constructor - Linking the different servo motors to the motors that are linked to the different pins on the Arduino board. 

{
                                                         // Used at the start for returning of a value's via the serial moniter.
Firmata.setFirmwareVersion(0, 1);
Firmata.begin(57600);
// Serial.begin(9600); 
  
 pinMode(ledPin, OUTPUT);

servomotor1.attach(motor1);                              //Servomotor 1 is linked to motor1 which links to the designated pin number.
servomotor2.attach(motor2);                              //Servomotor 2 is linked to motor1 which links to the designated pin number.
servomotor3.attach(motor3);                              //Servomotor 3 is linked to motor1 which links to the designated pin number.

}




void loop()                     // Begining of Method - Linking the Servo's rotation to level of light.

{

photoLightValue = analogRead(photoResistor);             //The Photoresistor is told to read the level of light.

Firmata.sendAnalog(1, photoLightValue);
// Serial.println(photoLightValue);                           //This Prints the level of light that is being picked up by the photo resistor and places it in the serial moniter.


ServoOutput = map(photoLightValue, 100, 600, 0, 120);   // This sets the output of the servo motor to be at a different rotation dependant on light value, the angle of motor has been derived from trial and error.
// Serial.println(ServoOutput);



 if (photoLightValue >=300) {
   digitalWrite(ledPin, HIGH);
 delay (1000);
   }
 else {
 digitalWrite(ledPin, LOW);
  delay (1000);
   }
 
 
 
servomotor1.write(ServoOutput);                           //Tells Servo Motor 1 to move to the position designated from the Output field.
delay (1000);
servomotor2.write(ServoOutput);                           //Tells Servo Motor 2 to move to the position designated from the Output field.
delay (1000);
servomotor3.write(ServoOutput);                           //Tells Servo Motor 3 to move to the position designated from the Output field.
delay (1000);

delay (100);                                              // Delays the time it takes for the servo to move to the position.



 float temperature = getVoltage(temperaturePin);  //getting the voltage reading from the temperature sensor
 temperature = (temperature - .5) * 100;          //converting from 10 mv per degree wit 500 mV offset
                                                  //to degrees ((volatge - 500mV) times 100)
 
 
   if (temperature <=21) {
  analogWrite(RED_LED_PIN, redIntensity = 0);
  analogWrite(GREEN_LED_PIN, greenIntensity = 0);
 analogWrite(BLUE_LED_PIN, blueIntensity = 255);
 }
 
 if (temperature =22) {
  analogWrite(RED_LED_PIN, redIntensity = 0);
  analogWrite(GREEN_LED_PIN, greenIntensity = 255);
 analogWrite(BLUE_LED_PIN, blueIntensity = 0);
 }
 
  if (temperature =23) {
  analogWrite(RED_LED_PIN, redIntensity = 155);
  analogWrite(GREEN_LED_PIN, greenIntensity = 50);
 analogWrite(BLUE_LED_PIN, blueIntensity = 0);
 }
 
 if (temperature =24) {
  analogWrite(RED_LED_PIN, redIntensity = 105);
  analogWrite(GREEN_LED_PIN, greenIntensity = 70);
 analogWrite(BLUE_LED_PIN, blueIntensity = 0);
 }
 
  if (temperature =25) {
  analogWrite(RED_LED_PIN, redIntensity = 255);
  analogWrite(GREEN_LED_PIN, greenIntensity = 0);
 analogWrite(BLUE_LED_PIN, blueIntensity = 0);
 }
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
    
 
Firmata.sendAnalog(0, temperature);                  //printing the result
 delay(1000);                                     //waiting a second

 

    
// Serial.println(temperature);





}









/*
 * getVoltage() - returns the voltage on the analog input defined by
 * pin
 */
float getVoltage(int pin){
 return (analogRead(pin) * .004882814); //converting from a 0 to 1024 digital range

                                        // to 0 to 5 volts (each 1 reading equals ~ 5 millivolts
}


