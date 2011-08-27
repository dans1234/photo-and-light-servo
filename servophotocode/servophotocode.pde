
// Code for servo to move to pre-determined angle via servo rotation. 
// initial sourced from Circ-09 and Circ-04 arduino and made to fit application.
// As well as code from the arduino playgroud - http://www.arduino.cc/playground/ComponentLib/Servo

#include <Servo.h>              // Initial setup - Telling Arduino that Servo code will be sourced.


                                 // Beginning of Int / Servo Fields that link to different fields or start at a 0 value.
                                 
int photoResistor = 0;                                  // This tells Arduino to source the Photoresistor from analogue pin 0 on the board. 
int PhotoLightValue = 0;                                // This sets the initial value of light to 0.

Servo servomotor1;                                      // This tells Arduino that a single servo motor is being used and names it servomotor1.
Servo servomotor2;                                      // This tells Arduino that a single servo motor is being used and names it servomotor2.
Servo servomotor3;                                      // This tells Arduino that a single servo motor is being used and names it servomotor3.

int motor1 = 3;                                          // Links the motor1 "string" to pin 3.
int motor2 = 4;                                          // Links the motor2 "string" to pin 4.
int motor3 = 5;                                          // Links the motor3 "string" to pin 4.

int ServoOutput = 0;




void setup()                   // Begining of Constructor - Linking the different servo motors to the motors that are linked to the different pins on the Arduino board. 

{
  
Serial.begin(9600);                                      // Used at the start for returning of a value's via the serial moniter.

servomotor1.attach(motor1);                              //Servomotor 1 is linked to motor1 which links to the designated pin number.
servomotor2.attach(motor2);                              //Servomotor 2 is linked to motor1 which links to the designated pin number.
servomotor3.attach(motor3);                              //Servomotor 3 is linked to motor1 which links to the designated pin number.

}




void loop()                     // Begining of Method - Linking the Servo's rotation to level of light.

{

PhotoLightValue = analogRead(photoResistor);             //The Photoresistor is told to read the level of light.

ServoOutput = map(PhotoLightValue, 300, 1000, 0, 180);   // This sets the output of the servo motor to be at a different rotation dependant on light value, the angle of motor has been derived from trial and error.

Serial.print(PhotoLightValue);                           //This Prints the level of light that is being picked up by the photo resistor and places it in the serial moniter.

servomotor1.write(ServoOutput);                           //Tells Servo Motor 1 to move to the position designated from the Output field.
servomotor2.write(ServoOutput);                           //Tells Servo Motor 2 to move to the position designated from the Output field.
servomotor3.write(ServoOutput);                           //Tells Servo Motor 3 to move to the position designated from the Output field.


delay (100);                                              // Delays the time it takes for the servo to move to the position.

}                                                         // Close / end 
