//paquetes de mensajes a enviar
unsigned char mensajeEstado[10];
unsigned char ack[4];
//Comandos recibidos para movimiento
unsigned char comandoDerecha;
unsigned char comandoIzquierda;
unsigned char comandoAdelante;
unsigned char comandoAtras;
unsigned char comandoAltura;
//Comandos recibidos para apagado o encendido de motores
unsigned char comandoMotores; 


void setup()
{
  Serial.begin(38400);
}

void loop()
{ 
  recibir_comando();
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
  mensajeEstado[1]=6;
  mensajeEstado[2]=codigoMensaje;
  mensajeEstado[3]=(mensajeEstado[0] ^ mensajeEstado[1] ^ mensajeEstado[2] );
  Serial.write(mensajeEstado, 4);
}

boolean recibir_comando()
{
  int buffer = Serial.available();
  int posicionBuffer = 0;
  if (buffer>0)
  {
    unsigned char headerMensaje =Serial.read();
    while (headerMensaje != 255 && posicionBuffer < buffer)
    {
      headerMensaje=Serial.read();
    }
    if (headerMensaje == 255)
    {
      unsigned char codigoMensaje = Serial.read();


    }
  }
  return true;
}

boolean comprobar_guardar_mensaje(unsigned char codigoMensaje)
{
  unsigned char checksum;
  if (codigoMensaje == 1)
  {
    comandoDerecha = Serial.read();
    comandoIzquierda=Serial.read();
    comandoAdelante=Serial.read();
    comandoAtras=Serial.read();
    comandoAltura=Serial.read();
     checksum = (255 ^ 1 ^ comandoDerecha ^ comandoIzquierda ^ comandoAdelante ^ comandoAtras ^ comandoAltura); 
    if (checksum=Serial.read())
    {
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


