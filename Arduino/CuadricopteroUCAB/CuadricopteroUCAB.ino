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
#define PWM_MAXIMO 250 //maximo PWM que puede enviar el arduino a los motores
#define CODIGO_APAGADO 'Z'
#define CODIGO_ENCENDIDO 'T'
#define CODIGO_MOVIMIENTO 'M'
#define CODIGO_CONSTANTES 'K'
#define CODIGO_ENVIO_DATOS 'S'
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
#define K_COMP 0.95
#define DT_envioDatos 200
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
double DT = 0;
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
  // Modo FAST PWM en los pines 9, 10 y 11 //
  TCCR2A = _BV(COM2A1) | _BV(COM2B1) | _BV(WGM21) | _BV(WGM20);
  TCCR2B = _BV(CS22);

  TCCR1A = _BV(COM1A1) | _BV(COM1B1) | _BV(WGM10);
  TCCR1B = _BV(CS11) | _BV(CS10) | _BV(WGM12);
  ///////////////////////////////////////////


  // Configuracion de los puertos para sensores y motores //
  pinMode(USTRIGPIN, OUTPUT);
  pinMode(USECHOPIN, INPUT);
  pinMode(PUERTOMOTORDERECHO, OUTPUT);
  pinMode(PUERTOMOTORIZQUIERDO, OUTPUT);
  pinMode(PUERTOMOTORSUPERIOR, OUTPUT);
  pinMode(PUERTOMOTORINFERIOR, OUTPUT);
  analogWrite(PUERTOMOTORDERECHO, 0);
  analogWrite(PUERTOMOTORIZQUIERDO, 0);
  analogWrite(PUERTOMOTORSUPERIOR, 0);
  analogWrite(PUERTOMOTORINFERIOR, 0);
  //////////////////////////////////////////////////////////


  // Inicializacion de la comunicacion Serial, I2C y acelerometro/giroscopio //
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
  /////////////////////////////////////////////////////////////////////////////


  // Parametros de los Algoritmos PID //
  PID_pAngular_Yaw.SetSampleTime(DT_PID_posicionAngular);
  PID_pAngular_Pitch.SetSampleTime(DT_PID_posicionAngular);
  PID_pAngular_Roll.SetSampleTime(DT_PID_posicionAngular);
  PID_vAngular_Yaw.SetSampleTime(DT_PID_velocidadAngular);
  PID_vAngular_Pitch.SetSampleTime(DT_PID_velocidadAngular);
  PID_vAngular_Roll.SetSampleTime(DT_PID_velocidadAngular);
  PID_altura.SetSampleTime(DT_PID_altura);

  PID_pAngular_Yaw.SetOutputLimits(-180.0, 180.0);
  PID_pAngular_Pitch.SetOutputLimits(-180.0, 180.0);
  PID_pAngular_Roll.SetOutputLimits(-180.0, 180.0);
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
  //////////////////////////////////////


  // Inicio de conteo para manejo de frecuencia de envio de datos y DT de muestreo //
  tiempoUltimoMuestreo = micros();
  tiempoUltimoEnvio = millis();
  ///////////////////////////////////////////////////////////////////////////////////
}

void loop()
{

  //anguloDeseadoYPR[1] = 20.0;

  // Yaw-  P: 1    I: 0   D: 0
  PID_pAngular_Yaw.SetTunings(0, 0, 0);
  PID_pAngular_Pitch.SetTunings(0, 0, 0);
  PID_pAngular_Roll.SetTunings(0, 0, 0);

  // Yaw-  P: 1.3  I: 0    D: 0
  PID_vAngular_Yaw.SetTunings(0.4, 0, 0);
  PID_vAngular_Pitch.SetTunings(0.08, 0, 0.04);
  PID_vAngular_Roll.SetTunings(0.08, 0, 0.04);

  modoEjecucion = '_';
  velocidadBasePWM = 120;
  RecibirComando();

  SecuenciaDeInicio();

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


  //  CalcularOffsetYaw();
  i = 0;
  if (modoEjecucion != '_')
  {
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
        AplicarPWMmotores();
      }
      FiltroComplementario();
      i++;
      delay(20);
    }
  }
  else
  {
    analogWrite(PUERTOMOTORDERECHO, 0);
    analogWrite(PUERTOMOTORIZQUIERDO, 0);
    analogWrite(PUERTOMOTORSUPERIOR, 0);
    analogWrite(PUERTOMOTORINFERIOR, 0);
  }
}

void ImprimirEstado()
{
  if (millis() - tiempoUltimoEnvio >= DT_envioDatos)
  {
    Serial.println(CODIGO_ENVIO_DATOS);
    Serial.print("Altura: ");
    Serial.print(USAltura);
    Serial.println();
    Serial.print("Yaw: ");
    Serial.print(double(anguloYPR[0]));
    Serial.print(" ");
    Serial.print(double(G_velocidadYPR[0]));
    Serial.println();
    Serial.print("Pitch: ");
    Serial.print(double(anguloYPR[1]));
    Serial.print(" ");
    Serial.print(double(G_velocidadYPR[1]));
    Serial.println();
    Serial.print("Roll: ");
    Serial.print(double(anguloYPR[2]));
    Serial.print(" ");
    Serial.print(double(G_velocidadYPR[2]));
    Serial.print("\n");

    Serial.print("Comandos PWM: ");
    Serial.print("Yaw: ");
    Serial.print(double(correccionPWM_YPR[0]));
    Serial.println();
    Serial.print("Pitch: ");
    Serial.print(double(correccionPWM_YPR[1]));
    Serial.println();
    Serial.print("Roll: ");
    Serial.print(double(correccionPWM_YPR[2]));
    Serial.print("\n");
    Serial.print("\n");
    tiempoUltimoEnvio = millis();
  }
}


void CalcularOffsetYaw()
{
  int numMuestras = 500;
  for (int n = 0; n < numMuestras ; n++) {
    gyro.read();
    yaw_offset += (int)gyro.g.z * G_GYRO;
  }
  yaw_offset = yaw_offset / numMuestras;
}



void FiltroComplementario() {
  gyro.read();
  compass.read();

  DT = (double)(micros() - tiempoUltimoMuestreo) / 1000000;

  G_velocidadYPR[0] = (double) (gyro.g.z * G_GYRO - yaw_offset);
  G_velocidadYPR[1] = (double) gyro.g.y * G_GYRO;
  G_velocidadYPR[2] = (double) gyro.g.x * G_GYRO;


  A_aceleracionYPR[0] = (double) compass.a.z * G_ACC;
  A_aceleracionYPR[1] = (double) compass.a.y * G_ACC;
  A_aceleracionYPR[2] = (double) compass.a.x * G_ACC;

  A_anguloYPR[0] = 0;
  A_anguloYPR[1] = (double) atan2(A_aceleracionYPR[1], sqrt(A_aceleracionYPR[0] * A_aceleracionYPR[0] + A_aceleracionYPR[2] * A_aceleracionYPR[2]));
  A_anguloYPR[1] = ToDeg(A_anguloYPR[1]);
  A_anguloYPR[2] = (double) atan2(A_aceleracionYPR[2], sqrt(A_aceleracionYPR[0] * A_aceleracionYPR[0] + A_aceleracionYPR[1] * A_aceleracionYPR[1]));
  A_anguloYPR[2] = ToDeg(A_anguloYPR[2]);


  anguloYPR[0] = (double) (anguloYPR[0] + G_velocidadYPR[0] * DT);
  anguloYPR[0] = ToRad(anguloYPR[0]);
  anguloYPR[0] = (double) atan2(sin(anguloYPR[0]), cos(anguloYPR[0]));
  anguloYPR[0] = ToDeg(anguloYPR[0]);


  anguloYPR[1] = (double) (K_COMP * (anguloYPR[1] + G_velocidadYPR[1] * DT) + (1 - K_COMP) * A_anguloYPR[1]);
  anguloYPR[1] = ToRad(anguloYPR[1]);
  anguloYPR[1] = (double) atan2(sin(anguloYPR[1]), cos(anguloYPR[1]));
  anguloYPR[1] = ToDeg(anguloYPR[1]);

  anguloYPR[2] = (double) (K_COMP * (anguloYPR[2] + G_velocidadYPR[2] * DT) + (1 - K_COMP) * A_anguloYPR[2]);
  anguloYPR[2] = ToRad(anguloYPR[2]);
  anguloYPR[2] = (double) atan2(sin(anguloYPR[2]), cos(anguloYPR[2]));
  anguloYPR[2] = ToDeg(anguloYPR[2]);

  tiempoUltimoMuestreo = micros();
  ImprimirEstado();
}


void CalcularAltura()
{
  long duracion = 0;
  double distancia = 0;
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


  analogWrite(PUERTOMOTORDERECHO, motorDerecho);
  analogWrite(PUERTOMOTORIZQUIERDO, motorIzquierdo);
  analogWrite(PUERTOMOTORSUPERIOR, motorDelantero);
  analogWrite(PUERTOMOTORINFERIOR, motorTrasero);
}


void RecibirComando()
{
  if (Serial.available() > 0)
  {
    char comando = Serial.read();
    if (comando == CODIGO_ENCENDIDO)
    {
      modoEjecucion = 'T';
      Serial.println("ENCENDER!");
    }
    if (comando == CODIGO_APAGADO)
    {
      modoEjecucion = '_';
      Serial.println("APAGAR!");
    }
    if (comando == CODIGO_MOVIMIENTO)
    {
      int checksumCalculado = 0;
      int anguloRecibidoPitch = 0, anguloRecibidoPitch_low = 0, anguloRecibidoPitch_high = 0;
      int anguloRecibidoRoll = 0, anguloRecibidoRoll_low = 0, anguloRecibidoRoll_high = 0;
      int checksumRecibido = 0, checksumRecibido_low = 0, checksumRecibido_high = 0;

      if (Serial.available() > 0)
      {
        anguloRecibidoPitch_low = Serial.read();
        anguloRecibidoPitch_high = Serial.read();
        anguloRecibidoPitch = anguloRecibidoPitch_high * 256 + anguloRecibidoPitch_low;
      }
      if (Serial.available() > 0)
      {
        anguloRecibidoRoll_low = Serial.read();
        anguloRecibidoRoll_high = Serial.read();
        anguloRecibidoRoll = anguloRecibidoRoll_high * 256 + anguloRecibidoRoll_low;
      }
      if (Serial.available() > 0)
      {
        checksumRecibido_low = Serial.read();
        checksumRecibido_high = Serial.read();
        checksumRecibido = checksumRecibido_high * 256 + checksumRecibido_low;
      }

      checksumCalculado = anguloRecibidoPitch + anguloRecibidoRoll;

      if (checksumRecibido == checksumCalculado)
      {
        anguloDeseadoYPR[0] = 0;
        anguloDeseadoYPR[1] = anguloRecibidoPitch - 90;
        anguloDeseadoYPR[2] = anguloRecibidoRoll - 90;
        if (modoEjecucion == '_')
        {
          Serial.println("Angulos deseados en Pitch y Roll:");
          Serial.println(anguloDeseadoYPR[1]);
          Serial.println(anguloDeseadoYPR[2]);
          Serial.println();
        }
      }
    }
  }

}

