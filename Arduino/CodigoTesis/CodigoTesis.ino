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
#define CALIBRAR_PITCH 1
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
#define K_COMP 0.98
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
int tiempoMaximoMillis = 0;
int correccionPitchPWM = 0; //Compensacion en PWM para estabilizar al robot en el eje de Pitch.
int correccionRollPWM = 0; //Compensacion en PWM para estabilizar al robot en el eje de Roll.
long USDuracion=0; // Tiempo que tarda en rebotar el ultrasonido
long USAltura=0; // Distancia medida por el sensor de ultrasonido
bool comunicacionActiva = true;
boolean constantesRecibidas = false;
float tiempoInicioEjecucion=0;
int toleranciaTiempo=3000;


//CONTROL:
float kP = 0;
float kI = 0;
float kD = 0;

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


long inicioTransmision = 0;
long finTransmision = 0;



void setup() {
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

  pinMode(USTRIGPIN, OUTPUT); 
  pinMode(USECHOPIN, INPUT);
  pinMode(PUERTOMOTORDERECHO, OUTPUT);
  pinMode(PUERTOMOTORIZQUIERDO, OUTPUT);
  pinMode(PUERTOMOTORSUPERIOR, OUTPUT);
  pinMode(PUERTOMOTORINFERIOR, OUTPUT);
  tiempo = micros();
}

void loop() {
  CicloCalibracion();
  //Software_Reset();
}

void CicloCalibracion()
{
  int i= 0;
  while (i<50)
  {
    FiltroComplementario();
    Serial.flush();
    i++;
  }


  while (constantesRecibidas == false)
  {
    RecibirDatosPC();
    Serial.flush();
    delay(50);
    FiltroComplementario();
  }

  i=0;
  while(i < velocidadBasePWM)
  {
    if(CALIBRAR_PITCH == 1)
    {
      motorDerecho = 0;
      motorIzquierdo = 0;
      motorDelantero = i;
      motorTrasero = i;
    }
    else
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

  while (constantesRecibidas == true)
  {
    USAltura = 0;

    FiltroComplementario();
    EnviarDatosPC();
    RecibirDatosPC();
    PID();
    AplicarPWMmotores();
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

  if(CALIBRAR_PITCH == 1)
  {
    motorDerecho = 0;
    motorIzquierdo = 0;
    motorDelantero = velocidadBasePWM + correccionPitch;
    motorTrasero = velocidadBasePWM - correccionPitch;
  }
  else
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





void USCalcularAltura (){
  /* El siguiente trigPin/echoPin ciclo es usado para determinar la 
   distancia de el objeto mas cercano del que rebotan las ondas de 
   ultra-sonido
   ORIGEN:http://arduinobasics.blogspot.com/2012/11/arduinobasics-hc-sr04-ultrasonic-sensor.html
   */
}




void EnviarDatosPC (){
  //ALERTA: POR HACER
  boolean Salida=true;

  inicioTransmision = millis();

  //if((millis() - finTransmision) > 5)
  {
    Serial.println('k');
    Serial.println(anguloYPR[0]/10);
    Serial.println(anguloYPR[1]/10);
    Serial.println(anguloYPR[2]/10);
    Serial.println(USAltura);
    Serial.println(anguloYPR[0]/10 + anguloYPR[1]/10 + anguloYPR[2]/10 + USAltura);
    //Serial.println(millis() - inicioTransmision);
  }

  finTransmision = millis();
}


boolean RecibirDatosPC(){
  int dataByte = '_';
  if(Serial.available() > 0)
  {
    dataByte = Serial.read(); //save data into integer variable dataByte
  }
  int tiempoMaximoMillisRecibido, kPrecibida, kIrecibida, kDrecibida, velocidadBaseRecibida, anguloDeseadoRecibido;
  int sumaConstantesRecibida = 0, sumaConstantesCalculada = 0;
  int sumaVARecibida = 0, sumaVACalculada = 0;
  if (char(dataByte) == 'z')
  {
    if(Serial.available() > 0)
    {
      kPrecibida = Serial.read();
    }
    if(Serial.available() > 0)
    { 
      kIrecibida = Serial.read();
    }
    if(Serial.available() > 0)
    { 
      kDrecibida = Serial.read();
    }
    if(Serial.available() > 0)
    { 
      velocidadBaseRecibida = Serial.read();
    }
    if(Serial.available() > 0)
    { 
      anguloDeseadoRecibido = Serial.read();
    }
    if(Serial.available() > 0)
    { 
      sumaConstantesRecibida = Serial.read();
    }
    if(Serial.available() > 0)
    { 
      sumaVARecibida = Serial.read();
    }
    sumaConstantesCalculada = kPrecibida + kIrecibida + kDrecibida;
    sumaVACalculada = velocidadBaseRecibida + anguloDeseadoRecibido;

    //Serial.println("Datos");
    //Serial.println(kPrecibida);
    //Serial.println(kIrecibida);
    //Serial.println(kDrecibida);
    //Serial.println(velocidadBaseRecibida);
    //Serial.println(sumaCalculada);
    //Serial.println(sumaRecibida);
    //Serial.println();

    if((sumaConstantesCalculada == sumaConstantesRecibida) && (sumaVACalculada == sumaVARecibida))
    {
      //      Serial.println("Constantes");
      velocidadBasePWM = velocidadBaseRecibida;
      anguloDeseado = anguloDeseadoRecibido - 90;
      constantesRecibidas = true;

      Serial.println('rrrrrrrrrrrrrrrrrrrrrrr');
      //Serial.flush();

      if (CALIBRAR_PITCH == 1)
      {
        kPpitch = (float) kPrecibida/100;
        kIpitch = (float) kIrecibida/100;
        kDpitch = (float) kDrecibida/100;
      }
      else
      {
        kProll = (float) kPrecibida/100;
        kIroll = (float) kIrecibida/100;
        kDroll = (float) kDrecibida/100;
      }
    }

    kPrecibida = 0;
    kIrecibida = 0;
    kDrecibida = 0;
    velocidadBaseRecibida = 0;
    sumaConstantesRecibida = 0;
    sumaConstantesCalculada = 0;
    sumaVARecibida = 0;
    sumaVACalculada = 0;

    return true;
  }
  if (char(dataByte) == 'f')
  {
    kP = 0;
    kI = 0;
    kD = 0;
    kPpitch = 0;
    kIpitch = 0;
    kDpitch = 0;
    kProll = 0;
    kIroll = 0;
    kDroll = 0;
    velocidadBasePWM = 0;
    PID();
    AplicarPWMmotores();
    constantesRecibidas = false;
    Serial.println('ssssssssssssssssssssssssssssss');
    return true;
  }

  return false;
}



void AplicarPWMmotores()
{
  //        motorDerecho = anguloYPR[1]*0.3 + 60;
  //        motorIzquierdo = -anguloYPR[1]*0.3 + 60;        
  analogWrite(PUERTOMOTORDERECHO, motorDerecho);
  analogWrite(PUERTOMOTORIZQUIERDO, motorIzquierdo);
  analogWrite(PUERTOMOTORSUPERIOR, motorDelantero);
  analogWrite(PUERTOMOTORINFERIOR, motorTrasero);      
  //  analogWrite(PUERTOMOTORSUPERIOR,0);
  //  analogWrite(PUERTOMOTORINFERIOR,0);
}



void Software_Reset() // Restarts program from beginning but does not reset the peripherals and registers
{
  asm volatile ("  jmp 0");  
} 



