byte valorSensor = 0;

long numCambiosColor = 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(38400);
  pinMode(3, INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  int valor = digitalRead(3);
  if (valor != valorSensor)
  {
    valorSensor = !valorSensor;
    numCambiosColor++;
    Serial.println(numCambiosColor);
  }

}
