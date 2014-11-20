#include <FiltroLP_Giroscopio.h>
#include <FiltroLP_Acelerometro.h>
#include <FiltroMediaMovil_Acelerometro.h>
#include <FiltroMediaMovil_Giroscopio.h>
#include <Wire.h>
#include <L3G.h>
#include <LSM303.h>
#include <PID_v1.h>
#include <NewPing.h>


/********************************************        CONSTANTES y VARIABLES        ********************************************/
//MOTORES:
#define PUERTOMOTORDERECHO 5 //puerto de PWM del motor derecho
#define PUERTOMOTORIZQUIERDO 9 //puerto de PWM del motor izquierdo
#define PUERTOMOTORINFERIOR 10 //puerto de PWM del motor inferior
#define PUERTOMOTORSUPERIOR 11 //puerto de PWM del motor superior
#define PWM_MAXIMO 240 //maximo PWM que puede enviar el arduino a los motores
int velocidadBasePWM = 120;
char modoEjecucion = '_';
int motorDerecho = 0;
int motorIzquierdo = 0;
int motorDelantero = 0;
int motorTrasero = 0;
//FIN MOTORES


//CODIGOS DE COMUNICACION:
#define modoTelemetriaTotal 1
#define DT_envioDatosTelemetriaTotal 5
#define DT_envioDatosEstado 30
#define LED_ENCENDIDO 13
#define CODIGO_INICIO_MENSAJE 255
#define CODIGO_ENCENDIDO 0
#define CODIGO_MOVIMIENTO 1
#define CODIGO_ACK 6
#define CODIGO_ESTADO 7
#define CODIGO_TELEMETRIA_TOTAL 8
#define MAXIMO_ANGULO_COMANDO 70
unsigned char headerMensaje;
unsigned char codigoRecibido;
unsigned char comandoEncendidoRecibido;
unsigned char comandoPitch;
unsigned char comandoRoll;
unsigned char comandoAltura;
unsigned char checksum;
unsigned char mensajeEstado[15];
unsigned char mensajeTelemetriaTotal[42];
unsigned char ack[4];
long tiempoUltimoEnvio = 0;
//FIN CODIGOS DE COMUNICACION


//ULTRASONIDO:
#define USPIN 15 //puerto de datos del ultradonido.
#define ALTURA_MAXIMA 150
#define INCREMENTO_ALTURA_COMANDO 5 ///////////////////////////// CAMBIAR A 5????
NewPing sonar(USPIN, USPIN, ALTURA_MAXIMA);
long tiempoUltimoMuestreoAltura = 0;
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
double velocidad_Z = 0.0;
double Z_previo = 0.0;
//FIN ULTRASONIDO


//IMU
#define ToRad(x) ((x)*0.01745329252)  // *pi/180
#define ToDeg(x) ((x)*57.2957795131)  // *180/pi
#define G_GYRO 0.00875
#define G_ACC 0.015874
#define K_COMP 0.97
#define DT_sensor_altura 29
#define DT_acelerometro 1
#define DT_giroscopio 6
#define DT_PID_altura 50
#define DT_PID_posicionAngular 20
#define DT_PID_velocidadAngular 6
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
  14946, -355, -1957
};
double anguloDeseadoYPR[3] = {
  0, 0, 0
};
double G_velocidadYPR_filtrada[3] = {
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
double A_aceleracionYPR_filtrada[3] = {
  0, 0, 0
};
double A_anguloYPR[3] = {
  0, 0, 0
};
double A_anguloYPR_filtrado[3] = {
  0, 0, 0
};
double anguloYPR[3] = {
  0, 0, 0
};
double anguloYPR_filtrado[3] = {
  0, 0, 0
};
double velocidadDeseadaYPR[3] = {
  0, 0, 0
};
double correccionPWM_YPR[3] = {
  0, 0, 0
};
FiltroMediaMovil_Giroscopio filtroVelocidadYPR [3];
FiltroMediaMovil_Acelerometro filtroAceleracionYPR [3];
double DT = 0;
long tiempoUltimoMuestreoGiroscopio = 0;
long tiempoUltimoMuestreoAcelerometro = 0;
long tiempoUltimoMuestreoAngulos = 0;
//FIN IMU


//SISTEMAS DE CONTROL PID
PID PID_vAngular_Yaw(&G_velocidadYPR[0], &correccionPWM_YPR[0], &velocidadDeseadaYPR[0], 0, 0, 0, DIRECT);
PID PID_vAngular_Pitch(&G_velocidadYPR_filtrada[1], &correccionPWM_YPR[1], &velocidadDeseadaYPR[1], 0, 0, 0, DIRECT);
PID PID_vAngular_Roll(&G_velocidadYPR_filtrada[2], &correccionPWM_YPR[2], &velocidadDeseadaYPR[2], 0, 0, 0, DIRECT);
PID PID_pAngular_Yaw(&anguloYPR_filtrado[0], &velocidadDeseadaYPR[0], &anguloDeseadoYPR[0], 0, 0, 0, DIRECT);
PID PID_pAngular_Pitch(&anguloYPR_filtrado[1], &velocidadDeseadaYPR[1], &anguloDeseadoYPR[1], 0, 0, 0, DIRECT);
PID PID_pAngular_Roll(&anguloYPR_filtrado[2], &velocidadDeseadaYPR[2], &anguloDeseadoYPR[2], 0, 0, 0, REVERSE);
PID PID_altura(&estimacionAltura, &correccionAltura, &alturaDeseada, 0, 0, 0, DIRECT);
//FIN PID
/********************************************        FIN DE CONSTANTES y VARIABLES        ********************************************/


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
  if (modoTelemetriaTotal == 1)
  {
    Serial.begin(115200);
  }
  else
  {
    Serial.begin(38400);
  }
  Wire.begin();
  if (!gyro.init())
  {
    Serial.println("Failed to autodetect gyro type!");
    while (1);
  }
  gyro.enableDefault();
  compass.init();
  compass.enableDefault();
  CalcularOffsetGiroscopio();
//  CalcularOffsetAcelerometro();
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
  PID_pAngular_Yaw.SetTunings(1, 0.01, 0);
  PID_vAngular_Yaw.SetTunings(0.4, 0, 0);
  PID_vAngular_Pitch.SetTunings(0.95, 0.01, 0.005);
  PID_vAngular_Roll.SetTunings(0.95, 0.1, 0.005);
  //////////////////////////////////////

  // Inicio de conteo para manejo de frecuencia de envio de datos y DT de muestreo //
  tiempoUltimoMuestreoAngulos = micros();
  tiempoUltimoMuestreoAltura = millis();
  tiempoUltimoEnvio = millis();
  ///////////////////////////////////////////////////////////////////////////////////
}


void loop()
{
  modoEjecucion = '_';
  RecibirComando();
  SecuenciaDeInicio();
  SecuenciaDeVuelo();
}


void SecuenciaDeInicio()
{
  int i = 0;
  while (i < 50)
  {
    FiltroComplementario();
    CalcularAltura();
    EnviarMensajesTelemetriaPC();
    RecibirComando();
    anguloDeseadoYPR[1] = 0;
    anguloDeseadoYPR[2] = 0;
    alturaDeseada = 0;
    i++;
  }

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
      EnviarMensajesTelemetriaPC();
      RecibirComando();
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
    FiltroComplementario();
    CalcularAltura();
    //PIDAltura();
    PID_PosicionAngular();
    PID_VelocidadAngular();
    AplicarPWMmotores(velocidadBasePWM);
    EnviarMensajesTelemetriaPC();
  }
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


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////      PROCEDIMIENTOS PARA ESTIMAR LA POSICION ANGULAR MEDIANTE FILTRO COMPLEMENTARIO      /////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void FiltroComplementario() {
  gyro.read();
  compass.read();

  DT = (double)(micros() - tiempoUltimoMuestreoAngulos) / 1000000;

  if (millis() - tiempoUltimoMuestreoGiroscopio >= DT_giroscopio)
  {
    G_velocidadYPR[0] = (double) ((gyro.g.z - G_offsetYPR[0]) * G_GYRO );
    G_velocidadYPR[1] = (double) ((gyro.g.x - G_offsetYPR[1]) * G_GYRO );
    G_velocidadYPR[2] = (double) ((gyro.g.y - G_offsetYPR[2]) * G_GYRO );

    G_velocidadYPR_filtrada[0] = filtroVelocidadYPR [0].step ((double) G_velocidadYPR[0]);
    G_velocidadYPR_filtrada[1] = filtroVelocidadYPR [1].step ((double) G_velocidadYPR[1]);
    G_velocidadYPR_filtrada[2] = filtroVelocidadYPR [2].step ((double) G_velocidadYPR[2]);

    tiempoUltimoMuestreoGiroscopio = millis();
    anguloYPR[0] = (double) (anguloYPR[0] + G_velocidadYPR[0] * DT);
    anguloYPR[1] = (double) (K_COMP * (anguloYPR[1] + G_velocidadYPR[1] * DT) + (1 - K_COMP) * A_anguloYPR[1]);
    anguloYPR[2] = (double) (K_COMP * (anguloYPR[2] + G_velocidadYPR[2] * DT) + (1 - K_COMP) * A_anguloYPR[2]);

    anguloYPR_filtrado[0] = (double) (anguloYPR_filtrado[0] + G_velocidadYPR_filtrada[0] * DT);
    anguloYPR_filtrado[1] = (double) (K_COMP * (anguloYPR_filtrado[1] + G_velocidadYPR_filtrada[1] * DT) + (1 - K_COMP) * A_anguloYPR_filtrado[1]);
    anguloYPR_filtrado[2] = (double) (K_COMP * (anguloYPR_filtrado[2] + G_velocidadYPR_filtrada[2] * DT) + (1 - K_COMP) * A_anguloYPR_filtrado[2]);
  }

  if (millis() - tiempoUltimoMuestreoAcelerometro >= DT_acelerometro)
  {
    A_aceleracionYPR[0] = (double) (compass.a.z) * G_ACC;
    A_aceleracionYPR[1] = (double) (compass.a.y - A_offsetYPR[1]) * G_ACC;
    A_aceleracionYPR[2] = (double) (compass.a.x - A_offsetYPR[2]) * G_ACC;


    A_aceleracionYPR_filtrada[0] = filtroAceleracionYPR[0].step((double) A_aceleracionYPR[0]);
    A_aceleracionYPR_filtrada[1] = filtroAceleracionYPR[1].step((double) A_aceleracionYPR[1]);
    A_aceleracionYPR_filtrada[2] = filtroAceleracionYPR[2].step((double) A_aceleracionYPR[2]);


    A_anguloYPR[0] = 0;
    A_anguloYPR[1] = (double) atan2(A_aceleracionYPR[1], sqrt(A_aceleracionYPR[0] * A_aceleracionYPR[0] + A_aceleracionYPR[2] * A_aceleracionYPR[2]));
    A_anguloYPR[1] = ToDeg(A_anguloYPR[1]);
    A_anguloYPR[2] = (double) atan2(A_aceleracionYPR[2], sqrt(A_aceleracionYPR[0] * A_aceleracionYPR[0] + A_aceleracionYPR[1] * A_aceleracionYPR[1]));
    A_anguloYPR[2] = ToDeg(A_anguloYPR[2]);
    
    A_anguloYPR_filtrado[0] = 0;
    A_anguloYPR_filtrado[1] = (double) atan2(A_aceleracionYPR_filtrada[1], sqrt(A_aceleracionYPR_filtrada[0] * A_aceleracionYPR_filtrada[0] + A_aceleracionYPR_filtrada[2] * A_aceleracionYPR_filtrada[2]));
    A_anguloYPR_filtrado[1] = ToDeg(A_anguloYPR_filtrado[1]);
    A_anguloYPR_filtrado[2] = (double) atan2(A_aceleracionYPR_filtrada[2], sqrt(A_aceleracionYPR_filtrada[0] * A_aceleracionYPR_filtrada[0] + A_aceleracionYPR_filtrada[1] * A_aceleracionYPR_filtrada[1]));
    A_anguloYPR_filtrado[2] = ToDeg(A_anguloYPR_filtrado[2]);
    tiempoUltimoMuestreoAcelerometro = millis();
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

  anguloYPR_filtrado[0] = ToRad(anguloYPR_filtrado[0]);
  anguloYPR_filtrado[0] = (double) atan2(sin(anguloYPR_filtrado[0]), cos(anguloYPR_filtrado[0]));
  anguloYPR_filtrado[0] = ToDeg(anguloYPR_filtrado[0]);

  anguloYPR_filtrado[1] = ToRad(anguloYPR_filtrado[1]);
  anguloYPR_filtrado[1] = (double) atan2(sin(anguloYPR_filtrado[1]), cos(anguloYPR_filtrado[1]));
  anguloYPR_filtrado[1] = ToDeg(anguloYPR_filtrado[1]);

  anguloYPR_filtrado[2] = ToRad(anguloYPR_filtrado[2]);
  anguloYPR_filtrado[2] = (double) atan2(sin(anguloYPR_filtrado[2]), cos(anguloYPR_filtrado[2]));
  anguloYPR_filtrado[2] = ToDeg(anguloYPR_filtrado[2]);
  
  tiempoUltimoMuestreoAngulos = micros();
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////      PROCEDIMIENTOS PARA CALCULAR LA ALTURA DEL CUADRICOPTERO      /////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
  * En CalcularAltura() se calcula la distancia del sensor ultrasonico al suelo emitiendo un pulso, y calculando el tiempo de respuesta del mismo. 
    Conociendo previamente la velocidad del sonido, puede calcularse la distancia que recorrió la onda, ida y vuelta. El procedimiento se apoya en
    la libreria NewPing para Arduino, que utiliza rutinas con temporizadores.
  * En FiltroKalmanAltura() se estima la distancia real del sensor ultrasonico al suelo mediante un filtro de Kalman de primer orden.
*/
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
      velocidad_Z = estimacionAltura - Z_previo;
      Z_previo = estimacionAltura;
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



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////      RUTINAS PARA EJECUTAR LOS PID DE POSICION ANGULAR, VELOCIDAD ANGULAR Y ALTURA      /////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void PID_PosicionAngular()
{
  PID_pAngular_Yaw.Compute();
//  PID_pAngular_Pitch.Compute();
//  PID_pAngular_Roll.Compute();
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



/////////////////////////////////////////      RUTINA DE APLICACION DE PWM A LOS MOTORES      /////////////////////////////////////////
// Valida el estado de la variable modoEjecucion:
//      * Si es igual a '_', envía PWM=0 a todos los puertos.
//      * Si es igual a 'T', se calcula el valor de PWM a enviar a los motores a partir de la velocidad base del PWM establecida y las
//        salidas de los sistemas de control PID de velocidad angular y altura.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
    motorDerecho = velocidadMotoresPWM - correccionPWM_YPR[2] + correccionPWM_YPR[0] + correccionAltura;
    motorIzquierdo = velocidadMotoresPWM + correccionPWM_YPR[2] + correccionPWM_YPR[0] + correccionAltura;
    motorDelantero = velocidadMotoresPWM + correccionPWM_YPR[1] - correccionPWM_YPR[0] + correccionAltura;
    motorTrasero = velocidadMotoresPWM - correccionPWM_YPR[1] - correccionPWM_YPR[0] + correccionAltura;
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



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////      RUTINA DE PREPARACION DEL PAQUETE DE MENSAJE DE ESTADO      /////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/* Procedimiento para preparar paquetes de mensaje de estado. (14 bytes)
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
   posicion 13 = CHECKSUM (HECHO CON XOR DE LOS BYTES 0 AL 12)
 */
void PrepararPaqueteMensajeEstado()
{
  mensajeEstado[0] = CODIGO_INICIO_MENSAJE; //HEADER
  mensajeEstado[1] = CODIGO_ESTADO; //Codigo del mensaje

  if (anguloYPR_filtrado[0] >= 0)
  {
    mensajeEstado[2] = anguloYPR_filtrado[0];
    mensajeEstado[3] = 0;
  }
  else
  {
    mensajeEstado[3] = abs(anguloYPR_filtrado[0]);
    mensajeEstado[2] = 0;
  }
  mensajeEstado[4] = anguloYPR_filtrado[1] + 90;
  mensajeEstado[5] = anguloYPR_filtrado[2] + 90;

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
  if (G_velocidadYPR_filtrada[1] >= 0)
  {
    mensajeEstado[8] = G_velocidadYPR_filtrada[1];
    mensajeEstado[9] = 0;
  }
  else
  {
    mensajeEstado[9] = abs(G_velocidadYPR_filtrada[1]);
    mensajeEstado[8] = 0;
  }
  if (G_velocidadYPR_filtrada[2] >= 0)
  {
    mensajeEstado[10] = G_velocidadYPR_filtrada[2];
    mensajeEstado[11] = 0;
  }
  else
  {
    mensajeEstado[11] = abs(G_velocidadYPR_filtrada[2]);
    mensajeEstado[10] = 0;
  }

  mensajeEstado[12] = velocidadBasePWM;
//  mensajeEstado[12] = estimacionAltura;
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


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////      RUTINA DE PREPARACION DEL PAQUETE DE MENSAJE DE TELEMETRIA TOTAL     /////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/* Procedimiento para preparar paquetes de mensaje de telemetria total.  (42 bytes)
   posicion 0 = HEADER            (255)
   posicion 1 = CODIGO DE MENSAJE (7)
   posicion 2 = POSICION ANGULAR YAW (Valor positivo o == 0)
   posicion 3 = POSICION ANGULAR YAW (Valor negativo)
   posicion 4 = POSICION ANGULAR PITCH (Valor positivo o == 0)
   posicion 5 = POSICION ANGULAR PITCH (Valor negativo)
   posicion 6 = POSICION ANGULAR ROLL (Valor positivo o == 0)
   posicion 7 = POSICION ANGULAR ROLL (Valor negativo)
   posicion 8 = VELOCIDAD ANGULAR YAW (Valor positivo o == 0)
   posicion 9 = VELOCIDAD ANGULAR YAW (Valor negativo)
   posicion 10 = VELOCIDAD ANGULAR PITCH (Valor positivo o == 0)
   posicion 11 = VELOCIDAD ANGULAR PITCH (Valor negativo)
   posicion 12 = VELOCIDAD ANGULAR ROLL (Valor positivo o == 0)
   posicion 13 = VELOCIDAD ANGULAR ROLL (Valor negativo)
   posicion 14 = VELOCIDAD ANGULAR YAW FILTRADA (Valor positivo o == 0)
   posicion 15 = VELOCIDAD ANGULAR YAW FILTRADA (Valor negativo)
   posicion 16 = VELOCIDAD ANGULAR PITCH FILTRADA (Valor positivo o == 0)
   posicion 17 = VELOCIDAD ANGULAR PITCH FILTRADA (Valor negativo)
   posicion 18 = VELOCIDAD ANGULAR ROLL FILTRADA (Valor positivo o == 0)
   posicion 19 = VELOCIDAD ANGULAR ROLL FILTRADA (Valor negativo)
   posicion 20 = ACELERACION LINEAL Z (Valor positivo o == 0)
   posicion 21 = ACELERACION LINEAL Z (Valor negativo)
   posicion 22 = ACELERACION LINEAL Y (Valor positivo o == 0)
   posicion 23 = ACELERACION LINEAL Y (Valor negativo)
   posicion 24 = ACELERACION LINEAL X (Valor positivo o == 0)
   posicion 25 = ACELERACION LINEAL X (Valor negativo)
   posicion 26 = ACELERACION LINEAL Z FILTRADA (Valor positivo o == 0)
   posicion 27 = ACELERACION LINEAL Z FILTRADA (Valor negativo)
   posicion 28 = ACELERACION LINEAL Y FILTRADA (Valor positivo o == 0)
   posicion 29 = ACELERACION LINEAL Y FILTRADA (Valor negativo)
   posicion 30 = ACELERACION LINEAL X FILTRADA (Valor positivo o == 0)
   posicion 31 = ACELERACION LINEAL X FILTRADA (Valor negativo)
   posicion 32 = ALTURA - POSICION EN Z
   posicion 33 = ALTURA FILTRADA - POSICION EN Z FILTRADA 
   posicion 34 = VELOCIDAD EN Z (Valor positivo o == 0)
   posicion 35 = VELOCIDAD EN Z (Valor negativo)
   posicion 36 = PWM MOTOR DELANTERO
   posicion 37 = PWM MOTOR TRASERO
   posicion 38 = PWM MOTOR DERECHO
   posicion 39 = PWM MOTOR IZQUIERDO
   posicion 40 = ESTADO DE ENCENDIDO DE MOTORES
   posicion 41 = CHECKSUM (HECHO CON XOR DE LOS BYTES 0 AL 40)
 */
void PrepararPaqueteMensajeTelemetriaTotal()
{
  mensajeTelemetriaTotal[0] = CODIGO_INICIO_MENSAJE; //HEADER
  mensajeTelemetriaTotal[1] = CODIGO_TELEMETRIA_TOTAL; //Codigo del mensaje
  if (anguloYPR_filtrado[0] >= 0)
  {
    mensajeTelemetriaTotal[2] = anguloYPR_filtrado[0];
    mensajeTelemetriaTotal[3] = 0;
  }
  else
  {
    mensajeTelemetriaTotal[3] = abs(anguloYPR_filtrado[0]);
    mensajeTelemetriaTotal[2] = 0;
  }
  if (anguloYPR_filtrado[1] >= 0)
  {
    mensajeTelemetriaTotal[4] = anguloYPR_filtrado[1];
    mensajeTelemetriaTotal[5] = 0;
  }
  else
  {
    mensajeTelemetriaTotal[5] = abs(anguloYPR_filtrado[1]);
    mensajeTelemetriaTotal[4] = 0;
  }
  if (anguloYPR_filtrado[2] >= 0)
  {
    mensajeTelemetriaTotal[6] = anguloYPR_filtrado[2];
    mensajeTelemetriaTotal[7] = 0;
  }
  else
  {
    mensajeTelemetriaTotal[7] = abs(anguloYPR_filtrado[2]);
    mensajeTelemetriaTotal[6] = 0;
  }

  if (G_velocidadYPR[0] >= 0)
  {
    mensajeTelemetriaTotal[8] = G_velocidadYPR[0];
    mensajeTelemetriaTotal[9] = 0;
  }
  else
  {
    mensajeTelemetriaTotal[9] = abs(G_velocidadYPR[0]);
    mensajeTelemetriaTotal[8] = 0;
  }
  if (G_velocidadYPR[1] >= 0)
  {
    mensajeTelemetriaTotal[10] = G_velocidadYPR[1];
    mensajeTelemetriaTotal[11] = 0;
  }
  else
  {
    mensajeTelemetriaTotal[11] = abs(G_velocidadYPR[1]);
    mensajeTelemetriaTotal[10] = 0;
  }
  if (G_velocidadYPR[2] >= 0)
  {
    mensajeTelemetriaTotal[12] = G_velocidadYPR[2];
    mensajeTelemetriaTotal[13] = 0;
  }
  else
  {
    mensajeTelemetriaTotal[13] = abs(G_velocidadYPR[2]);
    mensajeTelemetriaTotal[12] = 0;
  }

  if (G_velocidadYPR_filtrada[0] >= 0)
  {
    mensajeTelemetriaTotal[14] = G_velocidadYPR_filtrada[0];
    mensajeTelemetriaTotal[15] = 0;
  }
  else
  {
    mensajeTelemetriaTotal[15] = abs(G_velocidadYPR_filtrada[0]);
    mensajeTelemetriaTotal[14] = 0;
  }
  if (G_velocidadYPR_filtrada[1] >= 0)
  {
    mensajeTelemetriaTotal[16] = G_velocidadYPR_filtrada[1];
    mensajeTelemetriaTotal[17] = 0;
  }
  else
  {
    mensajeTelemetriaTotal[17] = abs(G_velocidadYPR_filtrada[1]);
    mensajeTelemetriaTotal[16] = 0;
  }
  if (G_velocidadYPR_filtrada[2] >= 0)
  {
    mensajeTelemetriaTotal[18] = G_velocidadYPR_filtrada[2];
    mensajeTelemetriaTotal[19] = 0;
  }
  else
  {
    mensajeTelemetriaTotal[19] = abs(G_velocidadYPR_filtrada[2]);
    mensajeTelemetriaTotal[18] = 0;
  }

  if (A_aceleracionYPR[2] >= 0)
  {
    mensajeTelemetriaTotal[20] = A_aceleracionYPR[2];
    mensajeTelemetriaTotal[21] = 0;
  }
  else
  {
    mensajeTelemetriaTotal[21] = abs(A_aceleracionYPR[2]);
    mensajeTelemetriaTotal[20] = 0;
  }
  if (A_aceleracionYPR[1] >= 0)
  {
    mensajeTelemetriaTotal[22] = A_aceleracionYPR[1];
    mensajeTelemetriaTotal[23] = 0;
  }
  else
  {
    mensajeTelemetriaTotal[23] = abs(A_aceleracionYPR[1]);
    mensajeTelemetriaTotal[22] = 0;
  }
  if (A_aceleracionYPR[0] >= 0)
  {
    mensajeTelemetriaTotal[24] = A_aceleracionYPR[0];
    mensajeTelemetriaTotal[25] = 0;
  }
  else
  {
    mensajeTelemetriaTotal[25] = abs(A_aceleracionYPR[0]);
    mensajeTelemetriaTotal[24] = 0;
  }

  if (A_aceleracionYPR_filtrada[2] >= 0)
  {
    mensajeTelemetriaTotal[26] = A_aceleracionYPR_filtrada[2];
    mensajeTelemetriaTotal[27] = 0;
  }
  else
  {
    mensajeTelemetriaTotal[27] = abs(A_aceleracionYPR_filtrada[2]);
    mensajeTelemetriaTotal[26] = 0;
  }
  if (A_aceleracionYPR_filtrada[1] >= 0)
  {
    mensajeTelemetriaTotal[28] = A_aceleracionYPR_filtrada[1];
    mensajeTelemetriaTotal[29] = 0;
  }
  else
  {
    mensajeTelemetriaTotal[29] = abs(A_aceleracionYPR_filtrada[1]);
    mensajeTelemetriaTotal[28] = 0;
  }
  if (A_aceleracionYPR_filtrada[0] >= 0)
  {
    mensajeTelemetriaTotal[30] = A_aceleracionYPR_filtrada[0];
    mensajeTelemetriaTotal[31] = 0;
  }
  else
  {
    mensajeTelemetriaTotal[31] = abs(A_aceleracionYPR_filtrada[0]);
    mensajeTelemetriaTotal[30] = 0;
  }

//  mensajeTelemetriaTotal[32] = USAltura;
  mensajeTelemetriaTotal[32] = velocidadBasePWM;
  mensajeTelemetriaTotal[33] = estimacionAltura;
  if (velocidad_Z >= 0)
  {
    mensajeTelemetriaTotal[34] = velocidad_Z;
    mensajeTelemetriaTotal[35] = 0;
  }
  else
  {
    mensajeTelemetriaTotal[35] = abs(velocidad_Z);
    mensajeTelemetriaTotal[34] = 0;
  }
  mensajeTelemetriaTotal[36] = motorDelantero;
  mensajeTelemetriaTotal[37] = motorTrasero;
  mensajeTelemetriaTotal[38] = motorDerecho;
  mensajeTelemetriaTotal[39] = motorIzquierdo;
  
  if (modoEjecucion == 'T')
  {
    mensajeTelemetriaTotal[40] = 1;
  }
  else
  {
    mensajeTelemetriaTotal[40] = 0;
  }
  mensajeTelemetriaTotal[41] = (mensajeTelemetriaTotal[0] ^  mensajeTelemetriaTotal[1] ^   mensajeTelemetriaTotal[2] ^ mensajeTelemetriaTotal[3] ^ mensajeTelemetriaTotal[4] ^ mensajeTelemetriaTotal[5] ^ mensajeTelemetriaTotal[6] ^ mensajeTelemetriaTotal[7] ^ mensajeTelemetriaTotal[8] ^ mensajeTelemetriaTotal[9] ^ mensajeTelemetriaTotal[10] ^ mensajeTelemetriaTotal[11] ^ mensajeTelemetriaTotal[12] ^ mensajeTelemetriaTotal[13] ^ mensajeTelemetriaTotal[14] ^ mensajeTelemetriaTotal[15] ^ mensajeTelemetriaTotal[16] ^ mensajeTelemetriaTotal[17] ^ mensajeTelemetriaTotal[18] ^ mensajeTelemetriaTotal[19] ^ mensajeTelemetriaTotal[20] ^ mensajeTelemetriaTotal[21] ^ mensajeTelemetriaTotal[22] ^ mensajeTelemetriaTotal[23] ^ mensajeTelemetriaTotal[24] ^ mensajeTelemetriaTotal[25] ^ mensajeTelemetriaTotal[26] ^ mensajeTelemetriaTotal[27] ^ mensajeTelemetriaTotal[28] ^ mensajeTelemetriaTotal[29] ^ mensajeTelemetriaTotal[30] ^ mensajeTelemetriaTotal[31] ^ mensajeTelemetriaTotal[32] ^ mensajeTelemetriaTotal[33] ^ mensajeTelemetriaTotal[34] ^ mensajeTelemetriaTotal[35] ^ mensajeTelemetriaTotal[36] ^ mensajeTelemetriaTotal[37] ^ mensajeTelemetriaTotal[38] ^ mensajeTelemetriaTotal[39] ^ mensajeTelemetriaTotal[40]); //CHECKSUM
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////      PROCEDIMIENTO PARA ENVIAR MENSAJES DE TELEMETRIA A LA PC      /////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/* Se valida el estado de la bandera modoTelemetriaTotal.
    * Si modoTelemetriaTotal==0, se envian mensajes de estado.
    * Si modoTelemetriaTotal==1, se envian mensajes de telemetria total.
*/
void EnviarMensajesTelemetriaPC()
{
  if (modoTelemetriaTotal == 0)
  {
    if (millis() - tiempoUltimoEnvio >= DT_envioDatosEstado)
    {
      PrepararPaqueteMensajeEstado();
      Serial.write(mensajeEstado, 14);//ENVIAR EL PAQUETE DE 14 BYTES
      tiempoUltimoEnvio = millis();
    }
  }
  else
  {
    if (millis() - tiempoUltimoEnvio >= DT_envioDatosTelemetriaTotal)
    {
      PrepararPaqueteMensajeTelemetriaTotal();
      Serial.write(mensajeTelemetriaTotal, 42);//ENVIAR EL PAQUETE DE 42 BYTES
      tiempoUltimoEnvio = millis();
    }  
  }
}



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////      PROCEDIMIENTO PARA RECIBIR MENSAJES DESDE LA PC      /////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/* Se lee el puerto serial, y se verifica, de forma sucesiva que:
    1) El primer dato recibido sea un char de codigo 255 (Header de los mensajes del protocolo).
    2) El valor del segundo dato recibido (Codigo del mensaje), a partir de lo cual se recibe:
        a) Comando de encendido/apagado (Codigo==0).
        b) Comando de movimiento (Codigo==1).
    3) Se realizar un checksum con todos los datos recibidos, y se compara con el ultimo dato recibido en cada caso (Checksum recibido).
    4) Si el checksum recibido es igual al checksum calculado, el mensaje ha llegado correctamente, y se ejecuta el comando modificando
       las variables modoEjecucion, velocidadDeseadaYPR y velocidadBasePWM segun corresponda. Si se recibio un mensaje de encendido, se
       envia un mensaje de acknowledge a la PC.
  Si en algun momento no se recibe un mensaje, o si el checksum recibido no coincide con el checksum calculado, se detiene la recepcion
  del mensaje, y la ejecucion del procedimiento llega a su fin.
*/
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
                    velocidadDeseadaYPR[1] = 0.0;
                    velocidadDeseadaYPR[2] = 0.0;
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
                      if ((abs(comandoPitch - MAXIMO_ANGULO_COMANDO) < MAXIMO_ANGULO_COMANDO) && (abs(comandoRoll - MAXIMO_ANGULO_COMANDO) < MAXIMO_ANGULO_COMANDO))
                      {
                        velocidadDeseadaYPR[1] = -(comandoPitch - MAXIMO_ANGULO_COMANDO);
                        velocidadDeseadaYPR[2] = (comandoRoll - MAXIMO_ANGULO_COMANDO);
                        if (comandoAltura <= PWM_MAXIMO)
                        {
                          velocidadBasePWM = comandoAltura;
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



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////      PROCEDIMIENTO PARA ENVIAR MENSAJE DE ACKNOWLEDGE A LA PC      /////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*  Se prepara y envia un mensaje de acknowledge, cuyo contenido viene dado por codigoMensaje.
*/
void EnviarAcknowledge(unsigned char codigoMensaje)
{
  ack[0] = CODIGO_INICIO_MENSAJE;
  ack[1] = CODIGO_ACK;
  ack[2] = codigoMensaje;
  ack[3] = (ack[0] ^ ack[1] ^ ack[2]);
  Serial.write(ack, 4);
}
