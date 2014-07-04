void setup()
{
  pinMode(9, OUTPUT);
  bitSet(TCCR1B, WGM12);
  bitSet(TCCR2B, WGM12);
}


void loop()
{
  analogWrite(9, 150);
}
