
#include <Wire.h>
#include <L3G.h>
#include <LSM303.h>

//CONSTANTES:
//IMPORTANTE!!: ARREGLAR CON LOS PUERTOS QUE VAMOS A CONECTAR EN EL ARDUINO

//ULTRASONIDO:
#define USTRIGPIN 6 //puerto de trigger del ultrasonido.
#define USECHOPIN 7 //puerto de echo del ultradonido.
#define USRANGOMAXIMO 200 // rango maximo de ultrasonido
#define USRANGOMINIMO 0 // rango minimo de ultrasonido
//FIN ULTRASONIDO

//MOTORES:
#define PUERTOMOTORDERECHO 11 //puerto de PWM del motor derecho
#define PUERTOMOTORIZQUIERDO 10 //puerto de PWM del motor izquierdo
#define PUERTOMOTORINFERIOR 5 //puerto de PWM del motor inferior
#define PUERTOMOTORSUPERIOR 9 //puerto de PWM del motor superior
#define PWM_MAXIMO 255 //maximo PWM que puede enviar el arduino a los motores
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
#define DT_muestreo 0.05

L3G gyro;
LSM303 compass;
char report[80];
float offsetInicialAngulos[3] = {
  0,0,0};
float anguloDeseadoYPR[3] = {
  0,0,0};
float G_velocidadYPR[3] = {
  0,0,0};
float G_anguloYPR[3] = {
  0,0,0};
float A_aceleracionYPR[3] = {
  0,0,0};
float A_anguloYPR[3] = {
  0,0,0};
float anguloYPR[3] = {
  0,0,0};
float velocidadDeseadaYPR[3] = {
  0,0,0};
float correccionPWM_YPR[3] = {
  0,0,0};
long tiempo = 0;
float DT = 0;
//FIN IMU

//GENERALES:
#define ALTURAMAX 30 //altura maxima expresada en centimetros
#define MAX_VALOR_INTEGRAL 180
//FIN GENERALES



//VARIABLES GLOBALES:
int velocidadBasePWM = 0;
long USDuracion=0; // Tiempo que tarda en rebotar el ultrasonido
long USAltura=0; // Distancia medida por el sensor de ultrasonido

char calibrarYPR = '_';

long tiempoUltimoMuestreo = 0;

//CONTROL:
float kPpitch_velocidad = 0;
float kIpitch_velocidad = 0;
float kDpitch_velocidad = 0;
float errorPitch_velocidad = 0;
float integralPitch_velocidad = 0;
float derivadaPitch_velocidad = 0;
float errorPrevioPitch_velocidad = 0;
float kPpitch = 0;
float kIpitch = 0;
float kDpitch = 0;
float errorPitch = 0;
float integralPitch = 0;
float derivadaPitch = 0;
float errorPrevioPitch = 0;

float kProll_velocidad = 0;
float kIroll_velocidad = 0;
float kDroll_velocidad = 0;
float errorRoll_velocidad = 0;
float integralRoll_velocidad = 0;
float derivadaRoll_velocidad = 0;
float errorPrevioRoll_velocidad = 0;
float kProll = 0;
float kIroll = 0;
float kDroll = 0;
float errorRoll = 0;
float integralRoll = 0;
float derivadaRoll = 0;
float errorPrevioRoll = 0;

float kPyaw_velocidad = 0;
float errorYaw_velocidad = 0;
float errorAltura = 0;
int correccionAltura = 0;
//FIN CONTROL


 
 void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
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
  tiempo = micros();
}

void loop() {
  int i= 0;
  while (i<50)
  {
    FiltroComplementario();
    Serial.flush();
    i++;
  }

    offsetInicialAngulos[0] = 0;
    offsetInicialAngulos[1] = 0;
    offsetInicialAngulos[2] = 0;
    anguloDeseadoYPR[0] = 0;
    anguloDeseadoYPR[1] = 0;
    anguloDeseadoYPR[2] = 0;

  
  velocidadBasePWM = 60;
  kPpitch = 0;
  kIpitch = 0;
  kDpitch = 0;

  kProll = 0;
  kIroll = 0;
  kDroll = 0;

  kPpitch_velocidad = 0;
  kIpitch_velocidad = 0;
  kDpitch_velocidad = 0;

  kProll_velocidad = 0.07;
  kIroll_velocidad = 0;
  kDroll_velocidad = 0;
  calibrarYPR = 'R';
  
  i=0;
  while(i < velocidadBasePWM/2)
  {
    if(calibrarYPR == '_')
    {
      motorDerecho = 0;
      motorIzquierdo = 0;
      motorDelantero = 0;
      motorTrasero = 0;
    }
    if(calibrarYPR == 'P')
    {
      motorDerecho = 0;
      motorIzquierdo = 0;
      motorDelantero = i;
      motorTrasero = i;
    }
    if(calibrarYPR == 'R')
    {
      motorDerecho = i;
      motorIzquierdo = i;
      motorDelantero = 0;
      motorTrasero = 0;  
    }
    AplicarPWMmotores();
    FiltroComplementario();
    i++;
    delay(20);
  }
  
  while (true)
  {
    USAltura = 0;

    FiltroComplementario();
    PID_PosicionAngular();
    PID_VelocidadAngular();
    AplicarPWMmotores();
  }
}



void PID_PosicionAngular()
{
  errorPitch = (float) (anguloDeseadoYPR[1] - (anguloYPR[1] - offsetInicialAngulos[1]));
  integralPitch = 0.1*integralPitch + errorPitch;
  if(integralPitch > MAX_VALOR_INTEGRAL)
  {
    integralPitch = MAX_VALOR_INTEGRAL;
  }
  else if (integralPitch < -MAX_VALOR_INTEGRAL)
  {
    integralPitch = -MAX_VALOR_INTEGRAL;
  }
  derivadaPitch = errorPitch - errorPrevioPitch;
  errorPrevioPitch = errorPitch;
  velocidadDeseadaYPR[1] = kPpitch*errorPitch + kIpitch*integralPitch + kDpitch*derivadaPitch;

  errorRoll = (float) (anguloDeseadoYPR[2] - (anguloYPR[2] - offsetInicialAngulos[2]));
  integralRoll = 0.1*integralRoll + errorRoll;
  if(integralRoll > MAX_VALOR_INTEGRAL)
  {
    integralRoll = MAX_VALOR_INTEGRAL;
  }
  else if (integralRoll < -MAX_VALOR_INTEGRAL)
  {
    integralRoll = -MAX_VALOR_INTEGRAL;
  }
  derivadaRoll = errorRoll - errorPrevioRoll;
  errorPrevioRoll = errorRoll;
  velocidadDeseadaYPR[2] = kProll*errorRoll + kIroll*integralRoll + kDroll*derivadaRoll;
}


void PID_VelocidadAngular()
{  
  errorPitch_velocidad = (float) (velocidadDeseadaYPR[1] - G_velocidadYPR[1]);
  integralPitch_velocidad = 0.1*integralPitch_velocidad + errorPitch_velocidad;
  if(integralPitch_velocidad > MAX_VALOR_INTEGRAL)
  {
    integralPitch_velocidad = MAX_VALOR_INTEGRAL;
  }
  else if (integralPitch_velocidad < -MAX_VALOR_INTEGRAL)
  {
    integralPitch_velocidad = -MAX_VALOR_INTEGRAL;
  }
  derivadaPitch_velocidad = errorPitch_velocidad - errorPrevioPitch_velocidad;
  errorPrevioPitch_velocidad = errorPitch_velocidad;
  correccionPWM_YPR[1] = kPpitch_velocidad*errorPitch_velocidad + kIpitch_velocidad*integralPitch_velocidad + kDpitch_velocidad*derivadaPitch_velocidad;

  errorRoll_velocidad = (float) (velocidadDeseadaYPR[2] - G_velocidadYPR[2]);
  integralRoll_velocidad = 0.1*integralRoll_velocidad + errorRoll_velocidad;
  if(integralRoll_velocidad > MAX_VALOR_INTEGRAL)
  {
    integralRoll_velocidad = MAX_VALOR_INTEGRAL;
  }
  else if (integralRoll_velocidad < -MAX_VALOR_INTEGRAL)
  {
    integralRoll_velocidad = -MAX_VALOR_INTEGRAL;
  }
  derivadaRoll_velocidad = errorRoll_velocidad - errorPrevioRoll_velocidad;
  errorPrevioRoll_velocidad = errorRoll_velocidad;
  correccionPWM_YPR[2] = kProll_velocidad*errorRoll_velocidad + kIroll_velocidad*integralRoll_velocidad + kDroll_velocidad*derivadaRoll_velocidad;
}


void FiltroComplementario() {
  gyro.read();
  compass.read();

  DT= (double)(micros()-tiempo)/1000000;
  
  G_velocidadYPR[0] = (float) gyro.g.z * G_GYRO;
  G_velocidadYPR[1] = (float) gyro.g.y * G_GYRO;
  G_velocidadYPR[2] = (float) gyro.g.x * G_GYRO;
  G_anguloYPR[0] = anguloYPR[0] + G_velocidadYPR[0] * DT;
  G_anguloYPR[1] = anguloYPR[1] + G_velocidadYPR[1] * DT;
  G_anguloYPR[2] = anguloYPR[2] + G_velocidadYPR[2] * DT;
  
  A_aceleracionYPR[0] = (float) compass.a.z * G_ACC;
  A_aceleracionYPR[1] = (float) compass.a.y * G_ACC;
  A_aceleracionYPR[2] = (float) compass.a.x * G_ACC;
  A_anguloYPR[0] = 0;
  A_anguloYPR[1] = (float) atan2(-A_aceleracionYPR[1], A_aceleracionYPR[0]);
  A_anguloYPR[1] = ToDeg(A_anguloYPR[1]);
  A_anguloYPR[2] = (float) atan2(A_aceleracionYPR[2], A_aceleracionYPR[0]);
  A_anguloYPR[2] = ToDeg(A_anguloYPR[2]);
  
  anguloYPR[0] = (float) (K_COMP * G_anguloYPR[0] + (1-K_COMP) * A_anguloYPR[0]);
  anguloYPR[1] = (float) (K_COMP * G_anguloYPR[1] + (1-K_COMP) * A_anguloYPR[1]);
  anguloYPR[2] = (float) (K_COMP * G_anguloYPR[2] + (1-K_COMP) * A_anguloYPR[2]);
      
  tiempo=micros();
}


void AplicarPWMmotores()
{
    if(calibrarYPR == '_')
  {
    motorDerecho = 0;
    motorIzquierdo = 0;
    motorDelantero = 0;
    motorTrasero = 0;
  }
  if(calibrarYPR == 'P')
  {
    motorDerecho = 0;
    motorIzquierdo = 0;
    motorDelantero = velocidadBasePWM + correccionPWM_YPR[1];
    motorTrasero = velocidadBasePWM - correccionPWM_YPR[1];
  }
  if(calibrarYPR == 'R')
  {
    motorDerecho = velocidadBasePWM - correccionPWM_YPR[2];
    motorIzquierdo = velocidadBasePWM + correccionPWM_YPR[2];
    motorDelantero = 0;
    motorTrasero = 0;  
  }

  if (motorDelantero>PWM_MAXIMO)
  {
    motorDelantero = PWM_MAXIMO;
  }
  else if (motorDelantero<0)
  {
    motorDelantero = 0;  
  }
  if (motorTrasero>PWM_MAXIMO)
  {
    motorTrasero = PWM_MAXIMO;
  }
  else if (motorTrasero<0)
  {
    motorTrasero = 0;  
  }
  if (motorDerecho>PWM_MAXIMO)
  {
    motorDerecho = PWM_MAXIMO;
  }
  else if (motorDerecho<0)
  {
    motorDerecho = 0;  
  }
  if (motorIzquierdo>PWM_MAXIMO)
  {
    motorIzquierdo = PWM_MAXIMO;
  }
  else if (motorIzquierdo<0)
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

  if(millis() - tiempoUltimoMuestreo > DT_muestreo)
  {
    Serial.print(float(errorRoll));
    Serial.print(" ");
    Serial.print(float(motorIzquierdo));
    Serial.print("\n");
    tiempoUltimoMuestreo = millis();
  }
  

  analogWrite(PUERTOMOTORDERECHO, motorDerecho);
  analogWrite(PUERTOMOTORIZQUIERDO, motorIzquierdo);
  analogWrite(PUERTOMOTORSUPERIOR, motorDelantero);
  analogWrite(PUERTOMOTORINFERIOR, motorTrasero);      

  //Serial.println(anguloYPR[1]/10);
  //  analogWrite(PUERTOMOTORSUPERIOR,0);
  //  analogWrite(PUERTOMOTORINFERIOR,0);
}
