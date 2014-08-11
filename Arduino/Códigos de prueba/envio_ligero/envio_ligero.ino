//paquetes de mensajes a enviar
unsigned char mensajeEstado[10];
unsigned char ack[4];
//Comandos recibidos para movimiento
unsigned char comandoRoll;
unsigned char comandoPitch;
unsigned char comandoAltura;
//Comandos recibidos para apagado o encendido de motores
unsigned char comandoMotores; 


void setup()
{
  Serial.begin(38400);
}

void loop()
{ 
  enviar_ack(1);
}

/*Procedimiento para enviar el estado del cuadricoptero
 Envia un paquete de 10 bytes
 posicion 0 = HEADER            (255)
 posicion 1 = CODIGO DE MENSAJE (7)
 posicion 2 = POSICION ANGULAR YAW
 posicion 3 = POSICION ANGULAR PITCH
 posicion 4 = POSICION ANGULAR ROLL
 posicion 5 = VELOCIDAD ANGULAR YAW
 posicion 6 = VELOCIDAD ANGULAR PITCH
 posicion 7 = VELOCIDAD ANGULAR ROLL
 posicion 8 = ALTURA
 posicion 9 = CHECKSUM (HECHO CON XOR DE LOS BYTES 0 AL 9)
 */
void enviar_mensajeEstado()
{
  mensajeEstado[0]=255;//HEADER
  mensajeEstado[1] = 7;//CODIGO MENSAJE
  mensajeEstado[9]=(mensajeEstado[0] ^  mensajeEstado[1] ^   mensajeEstado[2] ^ mensajeEstado[3] ^ mensajeEstado[4] ^ mensajeEstado[5] ^ mensajeEstado[6] ^ mensajeEstado[9] ^ mensajeEstado[7] ^ mensajeEstado[8] );//CHECKSUM 
  Serial.write(mensajeEstado,10);//ENVIAR EL PAQUETE DE 10 BYTES
}

void enviar_ack(unsigned char codigoMensaje)
{
  ack[0]=255;
  ack[1]=6;
  ack[2]=codigoMensaje;
  unsigned char asd=(ack[0] ^ ack[1] ^ ack[2] );
  Serial.write(255);
  Serial.write(6);
  Serial.write(codigoMensaje);
  Serial.write(asd);
}

boolean recibir_comando()
{
  int buffer = Serial.available();
  if (buffer>0)
  {
    unsigned char headerMensaje =Serial.read();
   delay(1);
   // Serial.println (headerMensaje);
    while (headerMensaje != 255)
    {
      headerMensaje=Serial.read();
    }
    if (headerMensaje == 255)
    {
      unsigned char codigoMensaje = Serial.read();
      delay(1);
     // Serial.println(codigoMensaje);
      return (comprobar_guardar_mensaje(codigoMensaje));

    }
  }
  return false;
}

boolean comprobar_guardar_mensaje(unsigned char codigoMensaje)
{
  unsigned char checksum;
  if (codigoMensaje == 1)
  {
    comandoRoll = Serial.read();
   delay(1);
    comandoPitch=Serial.read();
   delay(1);
    comandoAltura=Serial.read();
   delay(1);
    unsigned char asd = Serial.read();
   delay(1);
   Serial.println("-----------------------------------------");
   Serial.println(comandoRoll);
   Serial.println(comandoPitch);
   Serial.println(comandoAltura);
   Serial.println("-----------------------------------------");
    checksum = (255 ^ 1 ^ comandoRoll ^ comandoPitch ^ comandoAltura); 
    if (checksum==asd)
    {
      enviar_ack(codigoMensaje);
      return true;
    }
  }
  if (codigoMensaje == 2)
  {
    comandoMotores = Serial.read();
    checksum = (255 ^ 2 ^ comandoMotores); 
    if (checksum=Serial.read())
    {
      enviar_ack(codigoMensaje);
      return true;
    }  
  }
  return false;
}


