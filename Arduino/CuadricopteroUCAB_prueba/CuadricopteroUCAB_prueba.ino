
#include <FiltroLP_Giroscopio.h>
#include <FiltroLP_Acelerometro.h>
#include <Wire.h>
#include <L3G.h>
#include <LSM303.h>
#include <PID_v1.h>
#include <NewPing.h>


//CONSTANTES y VARIABLES:
//MOTORES:
#define PUERTOMOTORDERECHO 5 //puerto de PWM del motor derecho
#define PUERTOMOTORIZQUIERDO 9 //puerto de PWM del motor izquierdo
#define PUERTOMOTORINFERIOR 10 //puerto de PWM del motor inferior
#define PUERTOMOTORSUPERIOR 11 //puerto de PWM del motor superior
#define PWM_MAXIMO 220 //maximo PWM que puede enviar el arduino a los motores
int velocidadBasePWM = 180;
char modoEjecucion = '_';
int motorDerecho = 0;
int motorIzquierdo = 0;
int motorDelantero = 0;
int motorTrasero = 0;
//FIN MOTORES

//ULTRASONIDO:
#define USPIN 15 //puerto de datos del ultradonido.
#define ALTURA_MAXIMA 150
#define INCREMENTO_ALTURA_COMANDO 5 ///////////////////////////// CAMBIAR A 5????
NewPing sonar(USPIN, USPIN, ALTURA_MAXIMA);
unsigned int uS;
double alturaDeseada = 0;
double distancia = 0;
double USAltura = 0; // Distancia medida por el sensor de ultrasonido
double correccionAltura = 0;
double covarianzaProcesoFisicoAltura = 0.1;
double covarianzaRuidoSensorAltura = 10.0;
double estimacionAltura = 0.0;
double covarianzaRuidoEstimacionAltura = 3.0;
double gananciaKalman = 0.0;
//FIN ULTRASONIDO


//CODIGOS DE COMUNICACION:
#define DT_envioDatos 5
#define LED_ENCENDIDO 13
#define CODIGO_INICIO_MENSAJE 255
#define CODIGO_ENCENDIDO 0
#define CODIGO_MOVIMIENTO 1
#define CODIGO_ACK 6
#define CODIGO_ESTADO 7
#define MAXIMO_ANGULO_COMANDO 30
unsigned char headerMensaje;
unsigned char codigoRecibido;
unsigned char comandoEncendidoRecibido;
unsigned char comandoPitch;
unsigned char comandoRoll;
unsigned char comandoAltura;
unsigned char checksum;
unsigned char mensajeEstado[15];
unsigned char ack[4];
//FIN CODIGOS DE COMUNICACION


//IMU
#define ToRad(x) ((x)*0.01745329252)  // *pi/180
#define ToDeg(x) ((x)*57.2957795131)  // *180/pi
#define G_GYRO 0.00875
#define K_COMP 0.99
#define G_ACC 0.00562
#define DT_sensor_altura 29
#define DT_acelerometro 20
#define DT_giroscopio 11
#define DT_PID_altura 50
#define DT_PID_posicionAngular 20
#define DT_PID_velocidadAngular 10

L3G gyro;
LSM303 compass;
char report[80];
double yaw_offset = 0;
double pitch_offset = 0;
double roll_offset = 0;
double G_offsetYPR [3] = {
  0, 0, 0
};
double A_offsetYPR [3] = {
  0, 0, 0
};
double anguloDeseadoYPR[3] = {
  0, 0, 0
};
double G_velocidadYPR[3] = {
  0, 0, 0
};
double G_velocidadYPRoriginal[3] = {
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
double covarianzaProcesoFisicoAcelerometro[3] = {
  0.1, 0.1, 0.1
};
double covarianzaRuidoSensorAcelerometro[3] = {
  0.5925, 0.6905, 0.8495
};
double estimacionAcelerometro[3] = {
  0.0, 0.0, 0.0
};
double covarianzaRuidoEstimacionAcelerometro[3] = {
  35.6785, 38.5234, 44.4478
};
double gananciaKalmanAcelerometro[3] = {
  0.0, 0.0, 0.0
};
FiltroLP_Giroscopio filtroVelocidadYPR [3];
FiltroLP_Acelerometro filtroAceleracionYPR [3];
double DT = 0;
long tiempoUltimoMuestreoGiroscopio = 0;
long tiempoUltimoMuestreoAcelerometro = 0;
//FIN IMU

//VARIABLES GLOBALES:
long tiempoUltimoMuestreoAngulos = 0;
long tiempoUltimoMuestreoAltura = 0;
long tiempoUltimoEnvio = 0;





PID PID_vAngular_Yaw(&G_velocidadYPR[0], &correccionPWM_YPR[0], &velocidadDeseadaYPR[0], 0, 0, 0, DIRECT);
PID PID_vAngular_Pitch(&G_velocidadYPR[1], &correccionPWM_YPR[1], &velocidadDeseadaYPR[1], 0, 0, 0, DIRECT);
PID PID_vAngular_Roll(&G_velocidadYPR[2], &correccionPWM_YPR[2], &velocidadDeseadaYPR[2], 0, 0, 0, DIRECT);
PID PID_pAngular_Yaw(&anguloYPR[0], &velocidadDeseadaYPR[0], &anguloDeseadoYPR[0], 0, 0, 0, DIRECT);
PID PID_pAngular_Pitch(&anguloYPR[1], &velocidadDeseadaYPR[1], &anguloDeseadoYPR[1], 0, 0, 0, DIRECT);
PID PID_pAngular_Roll(&anguloYPR[2], &velocidadDeseadaYPR[2], &anguloDeseadoYPR[2], 0, 0, 0, REVERSE);
PID PID_altura(&estimacionAltura, &correccionAltura, &alturaDeseada, 0, 0, 0, DIRECT);


void setup() {
  // Modo FAST PWM en los pines 9, 10 y 11 //
  TCCR2A = _BV(COM2A1) | _BV(COM2B1) | _BV(WGM21) | _BV(WGM20);
  TCCR2B = _BV(CS22);

  TCCR1A = _BV(COM1A1) | _BV(COM1B1) | _BV(WGM10);
  TCCR1B = _BV(CS11) | _BV(CS10) | _BV(WGM12);
  ///////////////////////////////////////////


  // Configuracion de los puertos para sensores, motores y bandera de encendido//
  pinMode(LED_ENCENDIDO, OUTPUT);
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
  Serial.begin(38400);
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
  CalcularOffsetGiroscopio();
  CalcularOffsetAcelerometro();
  // Inicio de conteo para manejo de frecuencia de envio de datos y DT de muestreo //
  tiempoUltimoMuestreoAngulos = micros();
  tiempoUltimoMuestreoAltura = millis();
  tiempoUltimoEnvio = millis();
  ///////////////////////////////////////////////////////////////////////////////////
}

void loop()
{
  /*
  // Yaw-  P: 1    I: 0   D: 0
   PID_pAngular_Yaw.SetTunings(0, 0, 0);
   PID_pAngular_Pitch.SetTunings(1.7, 0, 0);
   PID_pAngular_Roll.SetTunings(1.7, 0, 0);
   
   // Yaw-  P: 1.3  I: 0    D: 0
   PID_vAngular_Yaw.SetTunings(0.4, 0, 0.002);
   PID_vAngular_Pitch.SetTunings(0.65, 0, 0.01); //P=0.75   //P=0.55
   PID_vAngular_Roll.SetTunings(0.65, 0, 0.01); //P=0.75   //P=0.55
   PID_altura.SetTunings(2.0, 0, 0);
   */

  modoEjecucion = '_';
  RecibirComando();
  //RecibirComandoASCII();
  SecuenciaDeInicio();
  SecuenciaDeVuelo();
}

void CalcularOffsetGiroscopio() {
  int numMuestras = 500;
  for (int n = 0; n < numMuestras ; n++) {
    gyro.read();
    G_offsetYPR[0] += gyro.g.z;
    G_offsetYPR[1] += gyro.g.x;
    G_offsetYPR[2] += gyro.g.y;
  }
  G_offsetYPR [0] = G_offsetYPR[0] / numMuestras;
  G_offsetYPR [1] = G_offsetYPR[1] / numMuestras;
  G_offsetYPR [2] = G_offsetYPR[2] / numMuestras;

}


void CalcularOffsetAcelerometro() {
  int numMuestras = 500;
  for (int n = 0; n < numMuestras ; n++) {
    compass.read();
    A_offsetYPR[0] += compass.a.z;
    A_offsetYPR[1] += compass.a.y;
    A_offsetYPR[2] += compass.a.x;
  }
  A_offsetYPR [0] = A_offsetYPR[0] / numMuestras;
  A_offsetYPR [1] = A_offsetYPR[1] / numMuestras;
  A_offsetYPR [2] = A_offsetYPR[2] / numMuestras;

}


void SecuenciaDeInicio()
{
  int i = 0;
  while (i < 50)
  {
    FiltroComplementario();
    CalcularAltura();
    EnviarMensajeEstado();
    RecibirComando();
    //RecibirComandoASCII();
    anguloDeseadoYPR[1] = 0;
    anguloDeseadoYPR[2] = 0;
    alturaDeseada = 0;
    i++;
  }

  alturaDeseada = estimacionAltura;


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
        PIDAltura();
        PID_VelocidadAngular();
        AplicarPWMmotores(i);
      }
      FiltroComplementario();
      CalcularAltura();
      PID_PosicionAngular();
      PID_VelocidadAngular();
      AplicarPWMmotores(velocidadBasePWM);
      EnviarMensajeEstado();
      RecibirComando();
      //RecibirComandoASCII();
      i++;
      delay(1);
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


void SecuenciaDeVuelo()
{
  while (modoEjecucion != '_')
  {
    RecibirComando();
    //RecibirComandoASCII();
    FiltroComplementario();
    CalcularAltura();
    PIDAltura();
    PID_PosicionAngular();
    PID_VelocidadAngular();
    AplicarPWMmotores(velocidadBasePWM);
    /*    Serial.println("*************** Motores *****************");
     Serial.println(motorDerecho);
     Serial.println(motorIzquierdo);
     Serial.println(motorDelantero);
     Serial.println(motorTrasero);
     Serial.println(correccionPWM_YPR[0]);
     Serial.println(correccionPWM_YPR[1]);
     Serial.println(correccionPWM_YPR[2]);
     Serial.println();*/
    EnviarMensajeEstado();
  }
}



void FiltroComplementario() {
  gyro.read();
  compass.read();

  DT = (double)(micros() - tiempoUltimoMuestreoAngulos) / 1000000;

  if (millis() - tiempoUltimoMuestreoGiroscopio >= DT_giroscopio)
  {
    G_velocidadYPR[0] = (double) ((gyro.g.z - G_offsetYPR[0]) * G_GYRO );
    G_velocidadYPR[1] = (double) ((gyro.g.x - G_offsetYPR[1]) * G_GYRO );
    G_velocidadYPR[2] = (double) ((gyro.g.y - G_offsetYPR[2]) * G_GYRO );

    G_velocidadYPRoriginal[0] = (double) ((gyro.g.z - G_offsetYPR[0]) * G_GYRO );
    G_velocidadYPRoriginal[1] = (double) ((gyro.g.x - G_offsetYPR[1]) * G_GYRO );
    G_velocidadYPRoriginal[2] = (double) ((gyro.g.y - G_offsetYPR[2]) * G_GYRO );

    G_velocidadYPR[0] = filtroVelocidadYPR [0].step ((double) G_velocidadYPR[0]);
    G_velocidadYPR[1] = filtroVelocidadYPR [1].step ((double) G_velocidadYPR[1]);
    G_velocidadYPR[2] = filtroVelocidadYPR [2].step ((double) G_velocidadYPR[2]);

    tiempoUltimoMuestreoGiroscopio = millis();

    anguloYPR[0] = (double) (anguloYPR[0] + G_velocidadYPR[0] * DT);
    anguloYPR[1] = (double) (K_COMP * (anguloYPR[1] + G_velocidadYPR[1] * DT);
    anguloYPR[2] = (double) (K_COMP * (anguloYPR[2] + G_velocidadYPR[2] * DT);    
  }

  if (millis() - tiempoUltimoMuestreoAcelerometro >= DT_acelerometro)
  {

    A_aceleracionYPR[0] = (double) (compass.a.z) * G_ACC;
    A_aceleracionYPR[1] = (double) (compass.a.y - A_offsetYPR[1]) * G_ACC;
    A_aceleracionYPR[2] = (double) (compass.a.x - A_offsetYPR[2]) * G_ACC;


    A_aceleracionYPR[0] = filtroAceleracionYPR[0].step((double) A_aceleracionYPR[0]);
    A_aceleracionYPR[1] = filtroAceleracionYPR[1].step((double) A_aceleracionYPR[1]);
    A_aceleracionYPR[2] = filtroAceleracionYPR[2].step((double) A_aceleracionYPR[2]);

    FiltroKalmanAceleracion();

    A_anguloYPR[0] = 0;
    A_anguloYPR[1] = (double) atan2(estimacionAcelerometro[1], sqrt(estimacionAcelerometro[0] * estimacionAcelerometro[0] + estimacionAcelerometro[2] * estimacionAcelerometro[2]));
    A_anguloYPR[1] = ToDeg(A_anguloYPR[1]);
    A_anguloYPR[2] = (double) atan2(estimacionAcelerometro[2], sqrt(estimacionAcelerometro[0] * estimacionAcelerometro[0] + estimacionAcelerometro[1] * estimacionAcelerometro[1]));
    A_anguloYPR[2] = ToDeg(A_anguloYPR[2]);
    /*
    A_anguloYPR[0] = 0;
     A_anguloYPR[1] = (double) atan2(A_aceleracionYPR[1], sqrt(A_aceleracionYPR[0] * A_aceleracionYPR[0] + A_aceleracionYPR[2] * A_aceleracionYPR[2]));
     A_anguloYPR[1] = ToDeg(A_anguloYPR[1]);
     A_anguloYPR[2] = (double) atan2(A_aceleracionYPR[2], sqrt(A_aceleracionYPR[0] * A_aceleracionYPR[0] + A_aceleracionYPR[1] * A_aceleracionYPR[1]));
     A_anguloYPR[2] = ToDeg(A_anguloYPR[2]);
     */

    tiempoUltimoMuestreoAcelerometro = millis();

    anguloYPR[1] += (1 - K_COMP) * A_anguloYPR[1]);
    anguloYPR[2] += (1 - K_COMP) * A_anguloYPR[2]);
  }

  anguloYPR[0] = ToRad(anguloYPR[0]);
  anguloYPR[0] = (double) atan2(sin(anguloYPR[0]), cos(anguloYPR[0]));
  anguloYPR[0] = ToDeg(anguloYPR[0]);

  anguloYPR[1] = ToRad(anguloYPR[1]);
  anguloYPR[1] = (double) atan2(sin(anguloYPR[1]), cos(anguloYPR[1]));
  anguloYPR[1] = ToDeg(anguloYPR[1]);

  anguloYPR[2] = ToRad(anguloYPR[2]);
  anguloYPR[2] = (double) atan2(sin(anguloYPR[2]), cos(anguloYPR[2]));
  anguloYPR[2] = ToDeg(anguloYPR[2]);

  tiempoUltimoMuestreoAngulos = micros();
}


void CalcularAltura()
{
  if (millis() - tiempoUltimoMuestreoAltura > DT_sensor_altura)
  {
    uS = sonar.ping();
    distancia = (double) (uS / US_ROUNDTRIP_CM);

    if ((distancia > 0) && (distancia < ALTURA_MAXIMA))
    {
      USAltura = distancia;
      FiltroKalmanAltura();
      mensajeEstado[8] = estimacionAltura;
      //    Serial.print(USAltura);
      //    Serial.println("cm");
    }
    tiempoUltimoMuestreoAltura = millis();
  }
}


void FiltroKalmanAltura()
{
  covarianzaRuidoEstimacionAltura = covarianzaRuidoEstimacionAltura + covarianzaProcesoFisicoAltura;
  gananciaKalman = covarianzaRuidoEstimacionAltura / (covarianzaRuidoEstimacionAltura + covarianzaRuidoSensorAltura);
  estimacionAltura = estimacionAltura + gananciaKalman * (USAltura - estimacionAltura);
  covarianzaRuidoEstimacionAltura = (1 - gananciaKalman) * covarianzaRuidoEstimacionAltura;
}


void FiltroKalmanAceleracion()
{
  covarianzaRuidoEstimacionAcelerometro[0] = covarianzaRuidoEstimacionAcelerometro[0] + covarianzaProcesoFisicoAcelerometro[0];
  gananciaKalmanAcelerometro[0] = covarianzaRuidoEstimacionAcelerometro[0] / (covarianzaRuidoEstimacionAcelerometro[0] + covarianzaRuidoSensorAcelerometro[0]);
  estimacionAcelerometro[0] = estimacionAcelerometro[0] + gananciaKalmanAcelerometro[0] * (A_aceleracionYPR[0] - estimacionAcelerometro[0]);
  covarianzaRuidoEstimacionAcelerometro[0] = (1 - gananciaKalmanAcelerometro[0]) * covarianzaRuidoEstimacionAcelerometro[0];

  covarianzaRuidoEstimacionAcelerometro[1] = covarianzaRuidoEstimacionAcelerometro[1] + covarianzaProcesoFisicoAcelerometro[1];
  gananciaKalmanAcelerometro[1] = covarianzaRuidoEstimacionAcelerometro[1] / (covarianzaRuidoEstimacionAcelerometro[1] + covarianzaRuidoSensorAcelerometro[1]);
  estimacionAcelerometro[1] = estimacionAcelerometro[1] + gananciaKalmanAcelerometro[1] * (A_aceleracionYPR[1] - estimacionAcelerometro[1]);
  covarianzaRuidoEstimacionAcelerometro[1] = (1 - gananciaKalmanAcelerometro[1]) * covarianzaRuidoEstimacionAcelerometro[1];

  covarianzaRuidoEstimacionAcelerometro[2] = covarianzaRuidoEstimacionAcelerometro[2] + covarianzaProcesoFisicoAcelerometro[2];
  gananciaKalmanAcelerometro[2] = covarianzaRuidoEstimacionAcelerometro[2] / (covarianzaRuidoEstimacionAcelerometro[2] + covarianzaRuidoSensorAcelerometro[2]);
  estimacionAcelerometro[2] = estimacionAcelerometro[2] + gananciaKalmanAcelerometro[2] * (A_aceleracionYPR[2] - estimacionAcelerometro[2]);
  covarianzaRuidoEstimacionAcelerometro[2] = (1 - gananciaKalmanAcelerometro[2]) * covarianzaRuidoEstimacionAcelerometro[2];
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



void AplicarPWMmotores(int velocidadMotoresPWM)
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
    motorDerecho = velocidadMotoresPWM + correccionPWM_YPR[2] + correccionPWM_YPR[0] + correccionAltura;
    motorIzquierdo = velocidadMotoresPWM - correccionPWM_YPR[2] + correccionPWM_YPR[0] + correccionAltura;
    motorDelantero = velocidadMotoresPWM - correccionPWM_YPR[1] - correccionPWM_YPR[0] + correccionAltura;
    motorTrasero = velocidadMotoresPWM + correccionPWM_YPR[1] - correccionPWM_YPR[0] + correccionAltura;
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




///////////////////COMUNICACION/////////////////////////////////////////



/*Procedimiento para enviar el estado del cuadricoptero
 Envia un paquete de 14 bytes
 posicion 0 = HEADER            (255)
 posicion 1 = CODIGO DE MENSAJE (7)
 posicion 2 = POSICION ANGULAR YAW (Valor positivo o == 0)
 posicion 3 = POSICION ANGULAR YAW (Valor negativo)
 posicion 4 = POSICION ANGULAR PITCH
 posicion 5 = POSICION ANGULAR ROLL
 posicion 6 = VELOCIDAD ANGULAR YAW (Valor positivo o == 0)
 posicion 7 = VELOCIDAD ANGULAR YAW (Valor negativo)
 posicion 8 = VELOCIDAD ANGULAR PITCH (Valor positivo o == 0)
 posicion 9 = VELOCIDAD ANGULAR PITCH (Valor negativo)
 posicion 10 = VELOCIDAD ANGULAR ROLL (Valor positivo o == 0)
 posicion 11 = VELOCIDAD ANGULAR ROLL (Valor negativo)
 posicion 12 = ALTURA
 posicion 13 = CHECKSUM (HECHO CON XOR DE LOS BYTES 0 AL 9)
 */
void PrepararPaqueteMensajeEstado()
{
  mensajeEstado[0] = CODIGO_INICIO_MENSAJE; //HEADER
  mensajeEstado[1] = CODIGO_ESTADO; //Codigo del mensaje
  /**POSICION YAW**/
  if (anguloYPR[0] >= 0)
  {
    mensajeEstado[2] = anguloYPR[0];
    mensajeEstado[3] = 0;
  }
  else
  {
    mensajeEstado[3] = abs(anguloYPR[0]);
    mensajeEstado[2] = 0;
  }
  /**POSICION PICH**/
  mensajeEstado[4] = anguloYPR[1] + 90;
  /**POSICION ROLL**/
  mensajeEstado[5] = anguloYPR[2] + 90;
  /**VELOCIDAD YAW**/
  if (G_velocidadYPR[0] >= 0)
  {
    mensajeEstado[6] = G_velocidadYPR[0];
    mensajeEstado[7] = 0;
  }
  else
  {
    mensajeEstado[7] = abs(G_velocidadYPR[0]);
    mensajeEstado[6] = 0;
  }
  /**VELOCIDAD PITCH**/
  if (G_velocidadYPR[1] >= 0)
  {
    mensajeEstado[8] = G_velocidadYPR[1];
    mensajeEstado[9] = 0;
  }
  else
  {
    mensajeEstado[9] = abs(G_velocidadYPR[1]);
    mensajeEstado[8] = 0;
  }
  /**VELOCIDAD ROLL**/
  if (G_velocidadYPR[2] >= 0)
  {
    mensajeEstado[10] = G_velocidadYPR[2];
    mensajeEstado[11] = 0;
  }
  else
  {
    mensajeEstado[11] = abs(G_velocidadYPR[2]);
    mensajeEstado[10] = 0;
  }

  mensajeEstado[12] = estimacionAltura;
  //  mensajeEstado[12] = alturaDeseada;
  if (modoEjecucion == 'T')
  {
    mensajeEstado[13] = 1;
  }
  else
  {
    mensajeEstado[13] = 0;
  }
  mensajeEstado[14] = (mensajeEstado[0] ^  mensajeEstado[1] ^   mensajeEstado[2] ^ mensajeEstado[3] ^ mensajeEstado[4] ^ mensajeEstado[5] ^ mensajeEstado[6] ^ mensajeEstado[7] ^ mensajeEstado[8] ^ mensajeEstado[9] ^ mensajeEstado[10] ^ mensajeEstado[11] ^ mensajeEstado[12] ^ mensajeEstado[13]); //CHECKSUM
}

void EnviarMensajeEstado()
{
  if (millis() - tiempoUltimoEnvio >= DT_envioDatos)
  {
    //ImprimirEstado();
    PrepararPaqueteMensajeEstado();
    Serial.write(mensajeEstado, 15);//ENVIAR EL PAQUETE DE 14 BYTES
    tiempoUltimoEnvio = millis();
  }
}


/*recepcion de mensajes*/

void RecibirComando()
{
  if (Serial.available() > 0)
  {
    if (Serial.available() > 0)
    {
      headerMensaje = Serial.read();
      delay(1);
      if (headerMensaje == CODIGO_INICIO_MENSAJE)
      {
        if (Serial.available() > 0)
        {
          codigoRecibido = Serial.read();
          delay(1);
          if (codigoRecibido == CODIGO_ENCENDIDO)
          {
            if (Serial.available() > 0)
            {
              comandoEncendidoRecibido = Serial.read();
              delay(1);
              if (Serial.available() > 0)
              {
                checksum = Serial.read();
                delay(1);
                if (CODIGO_INICIO_MENSAJE ^ CODIGO_ENCENDIDO ^ comandoEncendidoRecibido == checksum)
                {
                  if (comandoEncendidoRecibido == 1)
                  {
                    modoEjecucion = 'T';
                    digitalWrite(LED_ENCENDIDO, HIGH);
                  }
                  if (comandoEncendidoRecibido == 0)
                  {
                    modoEjecucion = '_';
                    anguloDeseadoYPR[1] = 0;
                    anguloDeseadoYPR[2] = 0;
                    alturaDeseada = 0;
                    digitalWrite(LED_ENCENDIDO, LOW);
                  }
                  EnviarAcknowledge(CODIGO_ENCENDIDO);
                }
              }
            }
          }
          if (codigoRecibido == CODIGO_MOVIMIENTO)
          {
            if (Serial.available() > 0)
            {
              comandoPitch = Serial.read();
              delay(1);
              if (Serial.available() > 0)
              {
                comandoRoll = Serial.read();
                delay(1);
                if (Serial.available() > 0)
                {
                  comandoAltura = Serial.read();
                  delay(1);
                  if (Serial.available() > 0)
                  {
                    checksum = Serial.read();
                    delay(1);
                    if (CODIGO_INICIO_MENSAJE ^ CODIGO_MOVIMIENTO ^ comandoPitch ^ comandoRoll ^ comandoAltura == checksum)
                    {
                      anguloDeseadoYPR[1] = comandoPitch - MAXIMO_ANGULO_COMANDO;
                      anguloDeseadoYPR[2] = comandoRoll - MAXIMO_ANGULO_COMANDO;
                      if (comandoAltura == '+')
                      {
                        if (alturaDeseada + INCREMENTO_ALTURA_COMANDO <= ALTURA_MAXIMA)
                        {
                          alturaDeseada = alturaDeseada + INCREMENTO_ALTURA_COMANDO;
                        }
                      }
                      else if (comandoAltura == '-')
                      {
                        if (alturaDeseada - INCREMENTO_ALTURA_COMANDO >= 0)
                        {
                          alturaDeseada = alturaDeseada - INCREMENTO_ALTURA_COMANDO;
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}


void EnviarAcknowledge(unsigned char codigoMensaje)
{
  ack[0] = CODIGO_INICIO_MENSAJE;
  ack[1] = CODIGO_ACK;
  ack[2] = codigoMensaje;
  ack[3] = (ack[0] ^ ack[1] ^ ack[2]);
  Serial.write(ack, 4);
}


void RecibirComandoASCII()
{
  if (Serial.available() > 0)
  {
    char comando = Serial.read();
    if (comando == 'T')
    {
      modoEjecucion = 'T';
      Serial.println("ENCENDER!");
    }
    if (comando == '_')
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


void ImprimirEstado()
{
  if (millis() - tiempoUltimoEnvio >= DT_envioDatos)
  {
    Serial.println('Y');
    Serial.println(int(anguloYPR[0]));
    Serial.println('P');
    Serial.println(int(anguloYPR[1]));
    Serial.println('R');
    Serial.println(int(anguloYPR[2]));
    Serial.println('y');
    Serial.println(int(G_velocidadYPR[0]));
    Serial.println('p');
    Serial.println(int(G_velocidadYPR[1]));
    Serial.println('r');
    Serial.println(int(G_velocidadYPR[2]));
    Serial.println('A');
    Serial.println(int(USAltura));
    //    Serial.println(correccionAltura);
    tiempoUltimoEnvio = millis();
  }
}





