void setup()
{
  pinMode(9, OUTPUT);
  pinMode(13, OUTPUT);
  bitSet(TCCR1B, WGM12);
  //bitSet(TCCR2B, WGM12);
  digitalWrite(13, HIGH);
}


void loop()
{
  analogWrite(9, 250);
}
