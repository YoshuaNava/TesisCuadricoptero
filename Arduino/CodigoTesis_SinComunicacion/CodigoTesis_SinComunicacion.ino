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
#define PUERTOMOTORINFERIOR 9 //puerto de PWM del motor inferior
#define PUERTOMOTORSUPERIOR 5 //puerto de PWM del motor superior
#define PWM_MAXIMO 120 //maximo PWM que puede enviar el arduino a los motores
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
#define K_COMP 0.93
L3G gyro;
LSM303 compass;
char report[80];
float velocidadYPR[3] = {
  0,0,0};
float anguloYPR[3] = {
  0,0,0};
long tiempo = 0;
float DT = 0;
//FIN IMU

//GENERALES:
#define ALTURAMAX 30 //altura maxima expresada en centimetros
#define MAX_VALOR_INTEGRAL 1000
//FIN GENERALES



//VARIABLES GLOBALES:
int velocidadBasePWM = 0;
int anguloDeseado = 0;
int correccionPitchPWM = 0; //Compensacion en PWM para estabilizar al robot en el eje de Pitch.
int correccionRollPWM = 0; //Compensacion en PWM para estabilizar al robot en el eje de Roll.
long USDuracion=0; // Tiempo que tarda en rebotar el ultrasonido
long USAltura=0; // Distancia medida por el sensor de ultrasonido

int calibrarPR = 0;

//CONTROL:
float kPpitch = 0;
float kIpitch = 0;
float kDpitch = 0;
float errorPitch = 0;
float integralPitch = 0;
float derivadaPitch = 0;
float errorPrevioPitch = 0;
int correccionPitch = 0;

float kProll = 0;
float kIroll = 0;
float kDroll = 0;
float errorRoll = 0;
float integralRoll = 0;
float derivadaRoll = 0;
float errorPrevioRoll = 0;
int correccionRoll = 0;

float kPyaw = 0;
float errorYaw = 0;
int correccionYaw = 0;
float errorAltura = 0;
int correccionAltura = 0;
//FIN CONTROL


 
 void setup() {
  // put your setup code here, to run once:
  Serial.begin(57600);
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
  
  velocidadBasePWM = 70;
  kPpitch = 0.4;
  kIpitch = 0;
  kDpitch = 0;

  kProll = 0;
  kIroll = 0;
  kDroll = 0;
  anguloDeseado = 0;
  calibrarPR = 1;
  
  i=0;
  while(i < velocidadBasePWM)
  {
    if(calibrarPR == 1)
    {
      motorDerecho = 0;
      motorIzquierdo = 0;
      motorDelantero = i;
      motorTrasero = i;
    }
    if(calibrarPR == 2)
    {
      motorDerecho = i;
      motorIzquierdo = i;
      motorDelantero = 0;
      motorTrasero = 0;  
    }
    AplicarPWMmotores();
    i++;
    delay(20);
  }
  
  while (true)
  {
    USAltura = 0;

    FiltroComplementario();
    PID();
    AplicarPWMmotores();
  }
}

void PID()
{
  errorPitch = (float) anguloYPR[1]/10 - anguloDeseado;
  integralPitch = integralPitch + errorPitch;
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
  correccionPitch = kPpitch*errorPitch + kIpitch*integralPitch + kDpitch*derivadaPitch;

  errorRoll = (float) anguloYPR[2]/10 - anguloDeseado;
  integralRoll = integralRoll + errorRoll;
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
  correccionRoll = kProll*errorRoll + kIroll*integralRoll + kDroll*derivadaRoll;

  if(calibrarPR == 0)
  {
    motorDerecho = 0;
    motorIzquierdo = 0;
    motorDelantero = 0;
    motorTrasero = 0;
  }
  if(calibrarPR == 1)
  {
    motorDerecho = 0;
    motorIzquierdo = 0;
    motorDelantero = velocidadBasePWM + correccionPitch;
    motorTrasero = velocidadBasePWM - correccionPitch;
  }
  if(calibrarPR == 2)
  {
    motorDerecho = velocidadBasePWM + correccionRoll;
    motorIzquierdo = velocidadBasePWM - correccionRoll;
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
}

void FiltroComplementario() {
  gyro.read();
  compass.read();

  DT= (double)(micros()-tiempo)/1000000;

  velocidadYPR[0] = (float) gyro.g.z*G_GYRO;
  velocidadYPR[1] = (float) gyro.g.y*G_GYRO;
  velocidadYPR[2] = (float) gyro.g.x*G_GYRO;
  anguloYPR[0] = (float) (K_COMP * (anguloYPR[0] + velocidadYPR[0]*DT) + (float)(1-K_COMP) * compass.a.z * G_ACC);
  anguloYPR[1] = (float) (K_COMP * (anguloYPR[1] + velocidadYPR[1]*DT) + (float)(1-K_COMP) * compass.a.y * G_ACC);
  anguloYPR[2] = (float) (K_COMP * (anguloYPR[2] + velocidadYPR[2]*DT) + (float)(1-K_COMP) * compass.a.x * G_ACC);

  tiempo=micros();
}

void AplicarPWMmotores()
{
  //        motorDerecho = anguloYPR[1]*0.3 + 60;
  //        motorIzquierdo = -anguloYPR[1]*0.3 + 60;        
  analogWrite(PUERTOMOTORDERECHO, motorDerecho);
  analogWrite(PUERTOMOTORIZQUIERDO, motorIzquierdo);
  analogWrite(PUERTOMOTORSUPERIOR, motorDelantero);
  analogWrite(PUERTOMOTORINFERIOR, motorTrasero);      

  //Serial.println(anguloYPR[1]/10);
  //  analogWrite(PUERTOMOTORSUPERIOR,0);
  //  analogWrite(PUERTOMOTORINFERIOR,0);
}
