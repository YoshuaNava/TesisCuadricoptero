
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
#define DT_muestreo 20

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
    anguloDeseadoYPR[2] = -20;

  
  velocidadBasePWM = 60;
  kPpitch = 0;
  kIpitch = 0;
  kDpitch = 0;

  kProll = 1;
  kIroll = 0;
  kDroll = 0;

  kPpitch_velocidad = 0;
  kIpitch_velocidad = 0;
  kDpitch_velocidad = 0;

  kProll_velocidad = 0.02;
  kIroll_velocidad = 0;
  kDroll_velocidad = 0.01;
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
    RecibirComando();
    PID_PosicionAngular();
    PID_VelocidadAngular();
    AplicarPWMmotores();
  }
}

void RecibirComando()
{
  if (Serial.available() > 0)
  {
    char comando = Serial.read();
    if (comando == 'K')
    {
      int checksumCalculado = 0;
      char operacion = ' ', terminoPID = ' ';
      int checksumRecibido = 0, checksumRecibido_low = 0, checksumRecibido_high = 0;
      int incremento_k_velocidad = 0, incremento_k_velocidad_low = 0, incremento_k_velocidad_high = 0;
      int multiplicador, multiplicador_low = 0, multiplicador_high = 0;
      if(Serial.available() > 0)
      {
         operacion = Serial.read(); 
      }
      if(Serial.available() > 0)
      {
         terminoPID = Serial.read();
      }
      if(Serial.available() > 0)
      {
        incremento_k_velocidad_low = Serial.read();
        incremento_k_velocidad_high = Serial.read();
        incremento_k_velocidad = incremento_k_velocidad_high*256 + incremento_k_velocidad_low;
      }
      if(Serial.available() > 0)
      {
        multiplicador_low = Serial.read();
        multiplicador_high = Serial.read();
        multiplicador = multiplicador_high*256 + multiplicador_low;
      }
      if(Serial.available() > 0)
      {
        checksumRecibido_low = Serial.read();
        checksumRecibido_high = Serial.read();
        checksumRecibido = checksumRecibido_high*256 + checksumRecibido_low;
      }    
      
      checksumCalculado = incremento_k_velocidad + terminoPID + operacion;
      
      if(checksumCalculado == checksumRecibido)
      {
        if(calibrarYPR == 'P')
        {
          if((operacion == '+') && (terminoPID == 'P'))
          {
            kPpitch_velocidad += (float) incremento_k_velocidad/multiplicador;
          }
          if((operacion == '+') && (terminoPID == 'D'))
          {
            kDpitch_velocidad += (float) incremento_k_velocidad/multiplicador;
          }
          if((operacion == '-') && (terminoPID == 'P'))
          {
            kPpitch_velocidad -= (float) incremento_k_velocidad/multiplicador;
          }
          if((operacion == '-') && (terminoPID == 'D'))
          {
            kDpitch_velocidad -= (float) incremento_k_velocidad/multiplicador;
          }          
          Serial.println("Pitch. Constantes modificadas:");
          Serial.println(kPpitch_velocidad,5);
          Serial.println(kDpitch_velocidad,5);
          Serial.println();
        }
      
        if(calibrarYPR == 'R')
        {
          if((operacion == '+') && (terminoPID == 'P'))
          {
            kProll_velocidad += (float) incremento_k_velocidad/multiplicador;
          }
          if((operacion == '+') && (terminoPID == 'D'))
          {
            kDroll_velocidad += (float) incremento_k_velocidad/multiplicador;
          }
          if((operacion == '-') && (terminoPID == 'P'))
          {
            kProll_velocidad -= (float) incremento_k_velocidad/multiplicador;
          }
          if((operacion == '-') && (terminoPID == 'D'))
          {
            kDroll_velocidad -= (float) incremento_k_velocidad/multiplicador;
          }
//          Serial.println("Incremento");
//          Serial.print((float)incremento_k_velocidad/multiplicador,5);
//          Serial.println();
          Serial.println("Roll. Constantes modificadas:");
          Serial.println(kProll_velocidad,5);
          Serial.println(kDroll_velocidad,5);
          Serial.println();
        }
      }
    }
    
    if (comando == 'C')
    {
      int checksumCalculado = 0, calibrarYPR_recibido = ' ';
      int anguloRecibidoPitch = 0, anguloRecibidoPitch_low = 0, anguloRecibidoPitch_high = 0;
      int anguloRecibidoRoll = 0, anguloRecibidoRoll_low = 0, anguloRecibidoRoll_high = 0;
      int checksumRecibido = 0, checksumRecibido_low = 0, checksumRecibido_high = 0;

      if(Serial.available() > 0)
      {
        anguloRecibidoPitch_low = Serial.read();
        anguloRecibidoPitch_high = Serial.read();
        anguloRecibidoPitch = anguloRecibidoPitch_high*256 + anguloRecibidoPitch_low;
      }
      if(Serial.available() > 0)
      {
        anguloRecibidoRoll_low = Serial.read();
        anguloRecibidoRoll_high = Serial.read();
        anguloRecibidoRoll = anguloRecibidoRoll_high*256 + anguloRecibidoRoll_low;
      }
      if(Serial.available() > 0)
      {
        calibrarYPR_recibido = Serial.read();
      }
      if(Serial.available() > 0)
      {
        checksumRecibido_low = Serial.read();
        checksumRecibido_high = Serial.read();
        checksumRecibido = checksumRecibido_high*256 + checksumRecibido_low;
      }
      
      checksumCalculado = anguloRecibidoPitch + anguloRecibidoRoll+ calibrarYPR_recibido;
      
      if(checksumRecibido == checksumCalculado)
      {
//        Serial.println("Valores recibidos");
//        Serial.println(String((int)anguloRecibidoPitch-90) + ' ' + String((int)anguloRecibidoRoll-90) + ' ' + String((char)calibrarYPR_recibido));
//        Serial.println(checksumCalculado-180);
//        Serial.println();

        anguloDeseadoYPR[0] = 0;
        anguloDeseadoYPR[1] = anguloRecibidoPitch - 90;
        anguloDeseadoYPR[2] = anguloRecibidoRoll - 90;
        if(calibrarYPR == '_')
        {
          Serial.println("ENCENDER");
        }
        calibrarYPR = calibrarYPR_recibido;
        if(calibrarYPR == 'P')
        {
          Serial.println(anguloDeseadoYPR[1]);
        }
        if(calibrarYPR == 'R')
        {
          Serial.println(anguloDeseadoYPR[1]);
        }

      }
    }

    if (comando == '~')
    {
            int checksumCalculado = 0, calibrarYPR_recibido = ' ';
      int anguloRecibidoPitch = 0, anguloRecibidoPitch_low = 0, anguloRecibidoPitch_high = 0;
      int anguloRecibidoRoll = 0, anguloRecibidoRoll_low = 0, anguloRecibidoRoll_high = 0;
      int checksumRecibido = 0, checksumRecibido_low = 0, checksumRecibido_high = 0;

      if(Serial.available() > 0)
      {
        anguloRecibidoPitch_low = Serial.read();
        anguloRecibidoPitch_high = Serial.read();
        anguloRecibidoPitch = anguloRecibidoPitch_high*256 + anguloRecibidoPitch_low;
      }
      if(Serial.available() > 0)
      {
        anguloRecibidoRoll_low = Serial.read();
        anguloRecibidoRoll_high = Serial.read();
        anguloRecibidoRoll = anguloRecibidoRoll_high*256 + anguloRecibidoRoll_low;
      }
      if(Serial.available() > 0)
      {
        calibrarYPR_recibido = Serial.read();
      }
      if(Serial.available() > 0)
      {
        checksumRecibido_low = Serial.read();
        checksumRecibido_high = Serial.read();
        checksumRecibido = checksumRecibido_high*256 + checksumRecibido_low;
      }
      
      checksumCalculado = anguloRecibidoPitch + anguloRecibidoRoll+ calibrarYPR_recibido;
      
      if(checksumRecibido == checksumCalculado)
      {
        anguloDeseadoYPR[0] = 0;
        anguloDeseadoYPR[1] = 0;
        anguloDeseadoYPR[2] = 0;
        calibrarYPR = '_';
        Serial.println("APAGAR!");
      }
    }

  }
  
  Serial.flush();
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

  
  A_aceleracionYPR[0] = (float) compass.a.z * G_ACC;
  A_aceleracionYPR[1] = (float) compass.a.y * G_ACC;
  A_aceleracionYPR[2] = (float) compass.a.x * G_ACC;
  A_anguloYPR[0] = 0;
  A_anguloYPR[1] = (float) atan2(A_aceleracionYPR[1], sqrt(A_aceleracionYPR[0]*A_aceleracionYPR[0] + A_aceleracionYPR[2]*A_aceleracionYPR[2]));
  A_anguloYPR[1] = ToDeg(A_anguloYPR[1]);
  A_anguloYPR[2] = (float) atan2(A_aceleracionYPR[2], sqrt(A_aceleracionYPR[0]*A_aceleracionYPR[0] + A_aceleracionYPR[1]*A_aceleracionYPR[1]));
  A_anguloYPR[2] = ToDeg(A_anguloYPR[2]);
  
  
  anguloYPR[0] = (float) (K_COMP * (anguloYPR[0] + G_velocidadYPR[0]*DT) + (1-K_COMP) * A_anguloYPR[0]);
  anguloYPR[1] = (float) (K_COMP * (anguloYPR[1] + G_velocidadYPR[1]*DT) + (1-K_COMP) * A_anguloYPR[1]);
  anguloYPR[2] = (float) (K_COMP * (anguloYPR[2] + G_velocidadYPR[2]*DT) + (1-K_COMP) * A_anguloYPR[2]);
      
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

//  if(millis() - tiempoUltimoMuestreo > DT_muestreo)
//  {
//    Serial.print(float(anguloYPR[2]));
//    Serial.print(" ");
//    Serial.print(float(velocidadDeseadaYPR[2]));
//    Serial.print(" ");
//    Serial.print(float(DT*1000));
//    Serial.print(" ");
//    Serial.print(float(correccionPWM_YPR[2]));
//    Serial.print("\n");
//    tiempoUltimoMuestreo = millis();
//  }
  

  analogWrite(PUERTOMOTORDERECHO, motorDerecho);
  analogWrite(PUERTOMOTORIZQUIERDO, motorIzquierdo);
  analogWrite(PUERTOMOTORSUPERIOR, motorDelantero);
  analogWrite(PUERTOMOTORINFERIOR, motorTrasero);      

  //Serial.println(anguloYPR[1]/10);
  //  analogWrite(PUERTOMOTORSUPERIOR,0);
  //  analogWrite(PUERTOMOTORINFERIOR,0);
}
