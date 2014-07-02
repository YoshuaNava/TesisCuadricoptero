
#define DT_muestreo 200
#define ALTURA_MAXIMA 150
#define USTRIGPIN 14 //puerto de trigger del ultrasonido.
#define USECHOPIN 15 //puerto de echo del ultradonido.


float USAltura=0; // Distancia medida por el sensor de ultrasonido

long tiempoUltimoMuestreo = 0;

void setup()
{
  Serial.begin(115200);
  pinMode(USTRIGPIN, OUTPUT); 
  pinMode(USECHOPIN, INPUT);  
}

void loop()
{
      CalcularAltura();
    if(tiempoUltimoMuestreo - millis() >= DT_muestreo)
    {
      Serial.println((int)USAltura);
      tiempoUltimoMuestreo = millis();
    }
}

void CalcularAltura()
{
  long duracion = 0;
  float distancia = 0;
  digitalWrite(USTRIGPIN, LOW);
  delayMicroseconds(2);
  digitalWrite(USTRIGPIN, HIGH);
  delayMicroseconds(10);  
  digitalWrite(USTRIGPIN, LOW);
  duracion = pulseIn(USECHOPIN, HIGH,10000);
  distancia = (duracion/2)/58.2;
  delay(10);

  if(distancia < ALTURA_MAXIMA)
  {
    USAltura = distancia;
//    Serial.print(USAltura);
//    Serial.println("cm");
  }
}

