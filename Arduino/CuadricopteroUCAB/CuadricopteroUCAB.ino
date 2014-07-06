#include <PID_v1.h>
#include <Wire.h>
#include <L3G.h>
#include <LSM303.h>

//CONSTANTES:
//IMPORTANTE!!: ARREGLAR CON LOS PUERTOS QUE VAMOS A CONECTAR EN EL ARDUINO

//ULTRASONIDO:
#define USTRIGPIN 14 //puerto de trigger del ultrasonido.
#define USECHOPIN 15 //puerto de echo del ultradonido.
#define USRANGOMAXIMO 200 // rango maximo de ultrasonido
#define USRANGOMINIMO 0 // rango minimo de ultrasonido
#define ALTURA_MAXIMA 150
//FIN ULTRASONIDO

//MOTORES:
#define PUERTOMOTORDERECHO 5 //puerto de PWM del motor derecho
#define PUERTOMOTORIZQUIERDO 9 //puerto de PWM del motor izquierdo
#define PUERTOMOTORINFERIOR 10 //puerto de PWM del motor inferior
#define PUERTOMOTORSUPERIOR 11 //puerto de PWM del motor superior
#define PWM_MAXIMO 190 //maximo PWM que puede enviar el arduino a los motores
int motorDerecho = 0;
int motorIzquierdo = 0;
int motorDelantero = 0;
int motorTrasero = 0;
//FIN MOTORES


//IMU
#define ToRad(x) ((x)*0.01745329252)  // *pi/180
#define ToDeg(x) ((x)*57.2957795131)  // *180/pi
#define G_GYRO 0.00875
#define G_ACC 0.0573
#define K_COMP 0.9
#define DT_envioDatos 100
#define DT_PID_altura 0
#define DT_PID_posicionAngular 50
#define DT_PID_velocidadAngular 5

L3G gyro;
LSM303 compass;
char report[80];
double yaw_offset = 0;
double anguloDeseadoYPR[3] = {
  0, 0, 0
};
double G_velocidadYPR[3] = {
  0, 0, 0
};
double G_anguloYPR[3] = {
  0, 0, 0
};
double A_aceleracionYPR[3] = {
  0, 0, 0
};
double A_anguloYPR[3] = {
  0, 0, 0
};
double anguloYPR[3] = {
  0, 0, 0
};
double velocidadDeseadaYPR[3] = {
  0, 0, 0
};
double correccionPWM_YPR[3] = {
  0, 0, 0
};
double alturaDeseada = 0;
double USAltura = 0; // Distancia medida por el sensor de ultrasonido
double correccionAltura = 0;
float DT = 0;
//FIN IMU

//VARIABLES GLOBALES:
int velocidadBasePWM = 0;
long tiempoUltimoMuestreo = 0;
long tiempoUltimoEnvio = 0;
char modoEjecucion = '_';



PID PID_vAngular_Yaw(&G_velocidadYPR[0], &correccionPWM_YPR[0], &velocidadDeseadaYPR[0], 0, 0, 0, DIRECT);
PID PID_vAngular_Pitch(&G_velocidadYPR[1], &correccionPWM_YPR[1], &velocidadDeseadaYPR[1], 0, 0, 0, DIRECT);
PID PID_vAngular_Roll(&G_velocidadYPR[2], &correccionPWM_YPR[2], &velocidadDeseadaYPR[2], 0, 0, 0, DIRECT);
PID PID_pAngular_Yaw(&anguloYPR[0], &velocidadDeseadaYPR[0], &anguloDeseadoYPR[0], 0, 0, 0, DIRECT);
PID PID_pAngular_Pitch(&anguloYPR[1], &velocidadDeseadaYPR[1], &anguloDeseadoYPR[1], 0, 0, 0, DIRECT);
PID PID_pAngular_Roll(&anguloYPR[2], &velocidadDeseadaYPR[2], &anguloDeseadoYPR[2], 0, 0, 0, DIRECT);
PID PID_altura(&USAltura, &correccionAltura, &alturaDeseada, 0, 0, 0, DIRECT);


void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  Wire.begin();

  if (!gyro.init())
  {
    Serial.println("Failed to autodetect gyro type!");
    while (1);
  }

  gyro.enableDefault();
  compass.init();
  compass.enableDefault();

  pinMode(USTRIGPIN, OUTPUT);
  pinMode(USECHOPIN, INPUT);
  pinMode(PUERTOMOTORDERECHO, OUTPUT);
  pinMode(PUERTOMOTORIZQUIERDO, OUTPUT);
  pinMode(PUERTOMOTORSUPERIOR, OUTPUT);
  pinMode(PUERTOMOTORINFERIOR, OUTPUT);

  // Modo FAST PWM en los pines 9, 10 y 11 //
  TCCR2A = _BV(COM2A1) | _BV(COM2B1) | _BV(WGM21) | _BV(WGM20);
  TCCR2B = _BV(CS22);

  TCCR1A = _BV(COM1A1) | _BV(COM1B1) | _BV(WGM10);
  TCCR1B = _BV(CS11) | _BV(CS10) | _BV(WGM12);
  ///////////////////////////////////////////

  tiempoUltimoMuestreo = micros();
  tiempoUltimoEnvio = millis();

  //Parametros de los Algoritmos PID
  PID_pAngular_Yaw.SetSampleTime(DT_PID_posicionAngular);
  PID_pAngular_Pitch.SetSampleTime(DT_PID_posicionAngular);
  PID_pAngular_Roll.SetSampleTime(DT_PID_posicionAngular);
  PID_vAngular_Yaw.SetSampleTime(DT_PID_velocidadAngular);
  PID_vAngular_Pitch.SetSampleTime(DT_PID_velocidadAngular);
  PID_vAngular_Roll.SetSampleTime(DT_PID_velocidadAngular);
  PID_altura.SetSampleTime(DT_PID_altura);

  PID_pAngular_Yaw.SetOutputLimits(-90.0, 90.0);
  PID_pAngular_Pitch.SetOutputLimits(-90.0, 90.0);
  PID_pAngular_Roll.SetOutputLimits(-90.0, 90.0);
  PID_vAngular_Yaw.SetOutputLimits(-PWM_MAXIMO, PWM_MAXIMO);
  PID_vAngular_Pitch.SetOutputLimits(-PWM_MAXIMO, PWM_MAXIMO);
  PID_vAngular_Roll.SetOutputLimits(-PWM_MAXIMO, PWM_MAXIMO);
  PID_altura.SetOutputLimits(-PWM_MAXIMO, PWM_MAXIMO);

  PID_pAngular_Yaw.SetMode(AUTOMATIC);
  PID_pAngular_Pitch.SetMode(AUTOMATIC);
  PID_pAngular_Roll.SetMode(AUTOMATIC);
  PID_vAngular_Yaw.SetMode(AUTOMATIC);
  PID_vAngular_Pitch.SetMode(AUTOMATIC);
  PID_vAngular_Roll.SetMode(AUTOMATIC);
  PID_altura.SetMode(AUTOMATIC);
}

void loop()
{
  SecuenciaDeInicio();

  PID_pAngular_Yaw.SetTunings(5, 0, 0);
  PID_pAngular_Pitch.SetTunings(1, 0, 0);
  PID_pAngular_Roll.SetTunings(1, 0, 0);

  PID_vAngular_Yaw.SetTunings(0.2, 0, 0);
  PID_vAngular_Pitch.SetTunings(0.1, 0, 0);
  PID_vAngular_Roll.SetTunings(0.1, 0, 0);

  velocidadBasePWM = 80;
  modoEjecucion = 'T';

  while (modoEjecucion != '_')
  {
    //    CalcularAltura();
    //    USAltura = 0;

    FiltroComplementario();
    RecibirComando();
    PIDAltura();
    PID_PosicionAngular();
    PID_VelocidadAngular();
    AplicarPWMmotores();
  }
}


void SecuenciaDeInicio()
{
  int i = 0;
  while (i < 50)
  {
    FiltroComplementario();
    i++;
  }

  CalcularOffsetYaw();
  i = 0;
  while (i < velocidadBasePWM / 2)
  {
    if (modoEjecucion == '_')
    {
      motorDerecho = 0;
      motorIzquierdo = 0;
      motorDelantero = 0;
      motorTrasero = 0;
    }
    if (modoEjecucion == 'T')
    {
      motorDerecho = i;
      motorIzquierdo = i;
      motorDelantero = i;
      motorTrasero = i;
    }
    AplicarPWMmotores();
    FiltroComplementario();
    i++;
    delay(20);
  }
}

void CalcularOffsetYaw()
{
  int numMuestras = 500;
  for (int n = 0; n < numMuestras ; n++) {
    gyro.read();
    yaw_offset += (int)gyro.g.z*G_GYRO;
  }
  yaw_offset = yaw_offset / numMuestras;

  Serial.println();
  Serial.print("YAW Offset: ");
  Serial.print(yaw_offset);
  Serial.println();
}



void FiltroComplementario() {
  gyro.read();
  compass.read();

  DT = (double)(micros() - tiempoUltimoMuestreo) / 1000000;

  G_velocidadYPR[0] = (float) (gyro.g.z * G_GYRO - yaw_offset);
  G_velocidadYPR[1] = (float) gyro.g.y * G_GYRO;
  G_velocidadYPR[2] = (float) gyro.g.x * G_GYRO;


  A_aceleracionYPR[0] = (float) compass.a.z * G_ACC;
  A_aceleracionYPR[1] = (float) compass.a.y * G_ACC;
  A_aceleracionYPR[2] = (float) compass.a.x * G_ACC;

  A_anguloYPR[0] = 0;
  A_anguloYPR[1] = (float) atan2(A_aceleracionYPR[1], sqrt(A_aceleracionYPR[0] * A_aceleracionYPR[0] + A_aceleracionYPR[2] * A_aceleracionYPR[2]));
  A_anguloYPR[1] = ToDeg(A_anguloYPR[1]);
  A_anguloYPR[2] = (float) atan2(A_aceleracionYPR[2], sqrt(A_aceleracionYPR[0] * A_aceleracionYPR[0] + A_aceleracionYPR[1] * A_aceleracionYPR[1]));
  A_anguloYPR[2] = ToDeg(A_anguloYPR[2]);


  anguloYPR[0] = (float) (anguloYPR[0] + G_velocidadYPR[0] * DT);
  anguloYPR[0] = ToRad(anguloYPR[0]);
  anguloYPR[0] = (float) atan2(sin(anguloYPR[0]), cos(anguloYPR[0]));
  anguloYPR[0] = ToDeg(anguloYPR[0]);
  
  anguloYPR[1] = (float) (K_COMP * (anguloYPR[1] + G_velocidadYPR[1] * DT) + (1 - K_COMP) * A_anguloYPR[1]);
  anguloYPR[1] = ToRad(anguloYPR[1]);
  anguloYPR[1] = (float) atan2(sin(anguloYPR[1]), cos(anguloYPR[1]));
  anguloYPR[1] = ToDeg(anguloYPR[1]);  
  
  anguloYPR[2] = (float) (K_COMP * (anguloYPR[2] + G_velocidadYPR[2] * DT) + (1 - K_COMP) * A_anguloYPR[2]);
  anguloYPR[2] = ToRad(anguloYPR[2]);
  anguloYPR[2] = (float) atan2(sin(anguloYPR[2]), cos(anguloYPR[2]));
  anguloYPR[2] = ToDeg(anguloYPR[2]);  

  tiempoUltimoMuestreo = micros();
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
  duracion = pulseIn(USECHOPIN, HIGH);
  distancia = (duracion / 2) / 58.2;
  delay(10);

  if (distancia < ALTURA_MAXIMA)
  {
    USAltura = distancia;
    //    Serial.print(USAltura);
    //    Serial.println("cm");
  }
  else
  {
    USAltura = 0;
  }
}

void PID_PosicionAngular()
{
  PID_pAngular_Yaw.Compute();
  PID_pAngular_Pitch.Compute();
  PID_pAngular_Roll.Compute();
}

void PID_VelocidadAngular()
{
  PID_vAngular_Yaw.Compute();
  PID_vAngular_Pitch.Compute();
  PID_vAngular_Roll.Compute();
}

void PIDAltura()
{
  PID_altura.Compute();
}



void AplicarPWMmotores()
{
  if (modoEjecucion == '_')
  {
    motorDerecho = 0;
    motorIzquierdo = 0;
    motorDelantero = 0;
    motorTrasero = 0;
  }
  if (modoEjecucion == 'T')
  {
    motorDerecho = velocidadBasePWM - correccionPWM_YPR[2] + correccionPWM_YPR[0];
    motorIzquierdo = velocidadBasePWM + correccionPWM_YPR[2] + correccionPWM_YPR[0];
    motorDelantero = velocidadBasePWM - correccionPWM_YPR[1] - correccionPWM_YPR[0];
    motorTrasero = velocidadBasePWM + correccionPWM_YPR[1] - correccionPWM_YPR[0];
  }


  if (motorDelantero > PWM_MAXIMO)
  {
    motorDelantero = PWM_MAXIMO;
  }
  else if (motorDelantero < 0)
  {
    motorDelantero = 0;
  }
  if (motorTrasero > PWM_MAXIMO)
  {
    motorTrasero = PWM_MAXIMO;
  }
  else if (motorTrasero < 0)
  {
    motorTrasero = 0;
  }
  if (motorDerecho > PWM_MAXIMO)
  {
    motorDerecho = PWM_MAXIMO;
  }
  else if (motorDerecho < 0)
  {
    motorDerecho = 0;
  }
  if (motorIzquierdo > PWM_MAXIMO)
  {
    motorIzquierdo = PWM_MAXIMO;
  }
  else if (motorIzquierdo < 0)
  {
    motorIzquierdo = 0;
  }

  //  Serial.println("Angulos, error de angulo, error de velocidad y comando para los motores");
  //  Serial.println(String((int)(anguloYPR[1]-offsetInicialAngulos[1]))+' '+String((int)(anguloYPR[2]-offsetInicialAngulos[2])));
  //  Serial.println(String((int)errorPitch)+' '+String((int)errorRoll));
  //  Serial.println(String((int)errorPitch_velocidad) + ' ' + String((int)errorRoll_velocidad));
  //  Serial.println(String((int)correccionPWM_YPR[1]) + ' ' + String((int)correccionPWM_YPR[2]));
  //  Serial.println(String(motorIzquierdo)+' '+String(motorDerecho));
  //  Serial.println();

  if (millis() - tiempoUltimoEnvio > DT_envioDatos)
  {
    Serial.println('S');
    Serial.print("Altura: ");
    Serial.print(USAltura);
    Serial.println();
    Serial.print("Yaw: ");
    Serial.print(float(anguloYPR[0]));
    Serial.print(" ");
    Serial.print(float(G_velocidadYPR[0]));
    Serial.println();
    Serial.print("Pitch: ");
    Serial.print(float(anguloYPR[1]));
    Serial.print(" ");
    Serial.print(float(G_velocidadYPR[1]));
    Serial.println();
    Serial.print("Roll: ");
    Serial.print(float(anguloYPR[2]));
    Serial.print(" ");
    Serial.print(float(G_velocidadYPR[2]));
    Serial.print("\n");

    Serial.print("Comandos PWM: ");
    Serial.print("Yaw: ");
    Serial.print(float(correccionPWM_YPR[0]));
    Serial.println();
    Serial.print("Pitch: ");
    Serial.print(float(correccionPWM_YPR[1]));
    Serial.println();
    Serial.print("Roll: ");
    Serial.print(float(correccionPWM_YPR[2]));
    Serial.print("\n");
    Serial.print("\n");
    tiempoUltimoEnvio = millis();
  }


  analogWrite(PUERTOMOTORDERECHO, motorDerecho);
  analogWrite(PUERTOMOTORIZQUIERDO, motorIzquierdo);
  analogWrite(PUERTOMOTORSUPERIOR, motorDelantero);
  analogWrite(PUERTOMOTORINFERIOR, motorTrasero);

  //Serial.println(anguloYPR[1]/10);
  //  analogWrite(PUERTOMOTORSUPERIOR,0);
  //  analogWrite(PUERTOMOTORINFERIOR,0);
}


void RecibirComando()
{
  if (Serial.available() > 0)
  {
    char comando = Serial.read();
    if (comando == 'Z')
    {
      modoEjecucion = '_';
      Serial.println("APAGAR!");
    }
  }

}

