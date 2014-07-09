

#define DT_muestreo 0
#define ALTURA_MAXIMA 150
#define USPIN 15 //puerto de trigger del ultrasonido.


float USAltura=0; // Distancia medida por el sensor de ultrasonido

long tiempoUltimoMuestreo = 0;

void setup()
{
  Serial.begin(115200); 
}

void loop()
{
      //CalcularAltura();
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
  pinMode(USPIN, OUTPUT);
  digitalWrite(USPIN, LOW);
  delayMicroseconds(2);
  digitalWrite(USPIN, HIGH);
  delayMicroseconds(10);  
  digitalWrite(USPIN, LOW);
  pinMode(USPIN, INPUT);  
  duracion = pulseIn(USPIN, HIGH,10000);
  distancia = (duracion/2)/58.2;

  if(distancia < ALTURA_MAXIMA)
  {
    USAltura = distancia;
//    Serial.print(USAltura);
//    Serial.println("cm");
  }
}

