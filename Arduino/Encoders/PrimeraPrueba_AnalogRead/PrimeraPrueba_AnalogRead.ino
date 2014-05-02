
void setup() {
  // put your setup code here, to run once:
  Serial.begin(38400);
}

void loop() {
  // put your main code here, to run repeatedly:
  int valor = analogRead(2);
  
  Serial.println(valor);
}
