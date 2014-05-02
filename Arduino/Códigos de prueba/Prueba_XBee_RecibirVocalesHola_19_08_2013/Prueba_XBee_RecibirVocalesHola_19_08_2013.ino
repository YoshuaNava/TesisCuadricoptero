

void setup()
{
  Serial.begin(9600);
}



void loop()
{
  //Serial.println("Hola!!!");
  if (Serial.available()) //If there is data in the Serial Line
  {	
    int dataByte = Serial.read(); //save data into integer variable dataByte
    Serial.println(char(dataByte)); //Print to screen the variable received
  }
}
