int pwmDeseado = -1;
int tiempoMaximo = -1;

long tiempoInicio = 0;
long tiempoActual = 0;
int RPMmedidas = 0;
volatile long numCambiosColor = 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(19200);
}

void loop() {

  //  Serial.println("====================================================================");
  if (Serial.available() > 0)
  {

    byte senalInicio = Serial.read();
    if (senalInicio == 'a')
    {
      int pwmDeseado =  RecibirNumero();
      int tiempoMaximo =  RecibirNumero();
      if ((pwmDeseado != -1) && (tiempoMaximo != -1))
      {
        //Serial.println("PWM deseado y tiempo maximo:");
        //Serial.println(pwmDeseado);
        //Serial.println(tiempoMaximo);
        Serial.println("r");


        tiempoInicio = millis();
        tiempoActual = millis();

        numCambiosColor = 0;
        attachInterrupt(0, ContarCambioColor, CHANGE);
        while (tiempoActual - tiempoInicio < tiempoMaximo)
        {
          tiempoActual = millis();
          //Serial.println(numCambiosColor);
        }
        //Serial.println("y");
        //Serial.println((numCambiosColor / (tiempoMaximo / 1000)));
        Serial.println(numCambiosColor);
        Serial.println("z");
        //Serial.println(numCambiosColor/(tiempoMaximo/1000));
        //Serial.println(numCambiosColor/(tiempoMaximo/1000));
        detachInterrupt(0);
      }
    }
  }
  Serial.flush();
  pwmDeseado = -1;
  tiempoMaximo = -1;  
  //  Serial.println("????????????????????????????????????????????????????????????????????");

  // put your main code here, to run repeatedly:



}

void ContarCambioColor()
{
  numCambiosColor++;
}

int ConvertirASCII_Int(byte valor)
{
  switch (valor)
  {
    case 48:
      return 0;
    case 49:
      return 1;
    case 50:
      return 2;
    case 51:
      return 3;
    case 52:
      return 4;
    case 53:
      return 5;
    case 54:
      return 6;
    case 55:
      return 7;
    case 56:
      return 8;
    case 57:
      return 9;
  }
}

int Potencia(int base, int exponente)
{
  int i;
  int resultado = 1;
  while (exponente > 0)
  {
    resultado = resultado * base;
    exponente --;
  }

  return resultado;

}


// Formato a recibir: numeroPosicionesDecimales,numero-numeroPosicionesDecimalesChecksum,checksum!
// Ejemplo para dos numeros distintos a ser leidos: 4,1234-4,1238!4,9000-4,9004! (1234 y 5000)
int RecibirNumero()
{
  byte entrada = '_';

  int digitos = 0;
  int numero = 0;
  int posDecimalesRecibidas = 0;
  int numeroRecibido = 0;
  int posDecimales = 0;
  int posDecimalesNum = 0;
  int checksum = 0;

  //  Serial.println("****************************************************");
  while (entrada != '!')
  {
    if (Serial.available() > 0)
    {
      entrada = Serial.read();

      if (entrada == 44)
      {
        //Serial.println("Coma");
        posDecimalesRecibidas = 1;
      }
      else
      {
        if (entrada == 45)
        {
          //Serial.println("Guion");
          numeroRecibido = 1;
          posDecimalesRecibidas = 0;
        }
        if (numeroRecibido == 0)
        {
          if ((entrada >= 48) && (entrada <= 57))
          {
            if (posDecimalesRecibidas)
            {
              if (posDecimales >= 0)
              {
                //Serial.println("Digito:");
                //Serial.println(ConvertirASCII_Int(entrada));
                //Serial.println("Numero hasta el momento:");
                //Serial.println(numero);

                numero = numero + ConvertirASCII_Int(entrada) * Potencia(10, posDecimales);
                posDecimales--;
              }
            }
            else
            {
              posDecimalesNum = ConvertirASCII_Int(entrada);
              posDecimales = posDecimalesNum - 1;
              //Serial.println("Posiciones Decimales");
              //Serial.println(posDecimales);
            }
          }
        }
        else
        {
          if ((entrada >= 48) && (entrada <= 57))
          {
            if (posDecimalesRecibidas)
            {
              if (posDecimales >= 0)
              {
                //Serial.println("Digito:");
                //Serial.println(ConvertirASCII_Int(entrada));
                //Serial.println("Checksum hasta el momento:");
                //Serial.println(checksum);

                checksum = checksum + ConvertirASCII_Int(entrada) * Potencia(10, posDecimales);
                posDecimales--;
              }
            }
            else
            {
              posDecimales = ConvertirASCII_Int(entrada) - 1;
              //Serial.println("Posiciones Decimales");
              //Serial.println(posDecimales);
            }
          }
        }
      }
    }
  }

  if (posDecimalesNum + numero == checksum)
  {
    //    Serial.println("Numero recibido:");
    //    Serial.println(numero);
    //    Serial.println("Checksum");
    //    Serial.println(checksum);
    return numero;
  }
  else
  {
    return -1;
  }

}

