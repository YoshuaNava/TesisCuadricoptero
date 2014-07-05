void setup() {
  // put your setup code here, to run once:
  pinMode(5, OUTPUT);
  pinMode(9, OUTPUT);
  pinMode(10, OUTPUT);
  pinMode(11, OUTPUT);

  Serial.begin(115200);

  TCCR2A = _BV(COM2A1) | _BV(COM2B1) | _BV(WGM21) | _BV(WGM20);
  TCCR2B = _BV(CS22);
  
  TCCR1A = _BV(COM1A1) | _BV(COM1B1) | _BV(WGM10);
  TCCR1B = _BV(CS11) | _BV(CS10) | _BV(WGM12);
  //  bitSet(TCCR2B, WGM22);
}

void loop() {
  // put your main code here, to run repeatedly:
  analogWrite(5,120);
  analogWrite(9,120);
  analogWrite(10,120);
  analogWrite(11,120);
  delay(1000);

  analogWrite(5,0);
  analogWrite(9,0);
  analogWrite(10,0);
  analogWrite(11,0);
  delay(2000);

//  Serial.println("Registros");
//  Serial.println("TCCR1A");
//  Serial.println(TCCR1A, BIN);
//  Serial.println("TCCR1B");
//  Serial.println(TCCR1B, BIN);
//  Serial.println("TCCR2A");
//  Serial.println(TCCR2A, BIN);
//  Serial.println("TCCR2B");
//  Serial.println(TCCR2B, BIN);  
//  Serial.println();
//  delay(3000);
}
