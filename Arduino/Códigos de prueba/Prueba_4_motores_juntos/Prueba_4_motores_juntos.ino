
void setup()
{

  pinMode(5, OUTPUT);
  pinMode(9, OUTPUT);
  pinMode(10, OUTPUT);
  pinMode(11, OUTPUT);
}


void loop()
{
  analogWrite(5, 0);
  analogWrite(9, 0);
  analogWrite(10, 0);
  analogWrite(11, 120);

//  delay(1000);

//  analogWrite(5, 0);
//  analogWrite(9, 0);
//  analogWrite(10, 0);
//  analogWrite(11, 0);

  //delay(1000);

}


