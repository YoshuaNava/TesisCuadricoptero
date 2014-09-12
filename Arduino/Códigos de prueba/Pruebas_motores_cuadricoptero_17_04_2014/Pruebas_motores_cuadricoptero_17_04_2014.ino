

int motor1 = 5;
int motor2 = 9;
int motor3 = 10;
int motor4 = 11;

int valorPWM = 180;
int milisegundosActivo = 2000;
int reposo = 500;


void setup()
{
  pinMode(motor1, OUTPUT);
  pinMode(motor2, OUTPUT);
  pinMode(motor3, OUTPUT);
  pinMode(motor4, OUTPUT);
  Serial.begin(9600);
}


void motor1Continuo()
{
  analogWrite(motor1,valorPWM);
}


void parMotoresSecuencia()
{
  analogWrite(motor1,valorPWM);
  analogWrite(motor2,valorPWM);
  delay(milisegundosActivo);
  analogWrite(motor1,0);
  analogWrite(motor2,0);
  delay(reposo);
  
  
  analogWrite(motor3,valorPWM);
  analogWrite(motor4,valorPWM);
  delay(milisegundosActivo);
  analogWrite(motor3,0);
  analogWrite(motor4,0);
  delay(reposo);
}


void prenderMotoresJuntosIntensidadVariable()
{
  int intensidad = Serial.parseInt();
  Serial.println(intensidad);
  if(intensidad!=0)
  {
    delay(3000);
    analogWrite(motor1,intensidad);
    analogWrite(motor2,intensidad);
    analogWrite(motor3,intensidad);  
    analogWrite(motor4,intensidad);
  }
}



void prenderMotoresJuntosAcelerarVariableDetener()
{
  int intensidad = 0;
  char comando = '0';
  
  comando = Serial.read();
  if (comando == 'U')
  {
    Serial.println("Encender motores");
    while (intensidad == 0)
    {
      intensidad = Serial.parseInt();
      Serial.println(intensidad);
    }
    while (comando != 'D')
    {
        analogWrite(motor1,intensidad);
        analogWrite(motor2,intensidad);
        analogWrite(motor3,intensidad);  
        analogWrite(motor4,intensidad);
      comando = Serial.read();
    }
    Serial.println("Apagar motores");
    analogWrite(motor1,0);
    analogWrite(motor2,0);
    analogWrite(motor3,0);  
    analogWrite(motor4,0);
  }
}




void prenderMotoresJuntos()
{
  analogWrite(motor1,valorPWM);
  analogWrite(motor2,valorPWM);
  analogWrite(motor3,valorPWM);  
  analogWrite(motor4,valorPWM);
}



void prenderMotoresSecuencia()
{  
  analogWrite(motor1,valorPWM);
  delay(milisegundosActivo);
  analogWrite(motor1,0);
  delay(reposo);
  
  analogWrite(motor2,valorPWM);
  delay(milisegundosActivo);
  analogWrite(motor2,0);
  delay(reposo);
  
  analogWrite(motor3,valorPWM);
  delay(milisegundosActivo);
  analogWrite(motor3,0);
  delay(reposo);
  
  analogWrite(motor4,valorPWM);
  delay(milisegundosActivo);
  analogWrite(motor4,0);
  delay(reposo);
}

void loop()
{
  //prenderMotoresSecuencia();
    //motor1Continuo();
  //parMotoresSecuencia();
  //prenderMotoresJuntosAcelerarVariableDetener();
  prenderMotoresJuntos();
//  analogWrite(motor4,10);
//  delay(3000);
//  analogWrite(motor4,0);
//  delay(3000);
}

