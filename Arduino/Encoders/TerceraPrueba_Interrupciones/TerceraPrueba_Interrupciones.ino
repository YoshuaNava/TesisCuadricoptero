
volatile long numCambiosColor = 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(57600);
  pinMode(3, INPUT);
  attachInterrupt(0, ContarCambioColor, CHANGE);
}

void loop() {
  
  // put your main code here, to run repeatedly:
  int valor = digitalRead(3);
}

void ContarCambioColor()
{
  numCambiosColor++;
  Serial.println(numCambiosColor);
}
