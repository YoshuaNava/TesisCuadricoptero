int pwmDeseado = 0;
int tiempoMaximo = 0;

long tiempoInicio = 0;
long tiempoActual = 0;
int RPMmedidas = 0;
volatile long numCambiosColor = 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(38400);
}

void loop() {

  //  Serial.println("====================================================================");
  int numero =  RecibirNumero();
  //  Serial.println("????????????????????????????????????????????????????????????????????");

  // put your main code here, to run repeatedly:

  /*
  tiempoInicio = millis();
  tiempoActual = millis();
  attachInterrupt(0, ContarCambioColor, CHANGE);
  while(tiempoActual - tiempoInicio < tiempoMaximo)
  {
    tiempoActual = micros();
    Serial.println("Hola");
  }
  detachInterrupt(0);
  */
}

void ContarCambioColor()
{
  numCambiosColor++;
  Serial.println(numCambiosColor);
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
        Serial.println("Coma");
        posDecimalesRecibidas = 1;
      }
      else
      {
        if(entrada == 45)
        {
          numeroRecibido = 1;
          posDecimalesRecibidas = 0;
        }
        if(numeroRecibido == 0)
        {
          if ((entrada >= 48) && (entrada <= 57))
          {
            if (posDecimalesRecibidas)
            {
              if (posDecimales >= 0)
              {
                Serial.println("Digito:");
                Serial.println(ConvertirASCII_Int(entrada));
                Serial.println("Numero hasta el momento:");
                Serial.println(numero);
  
                numero = numero + ConvertirASCII_Int(entrada) * Potencia(10, posDecimales);
                posDecimales--;
              }
            }
            else
            {
              posDecimalesNum = ConvertirASCII_Int(entrada);
              posDecimales = posDecimalesNum - 1;
              Serial.println("Posiciones Decimales");
              Serial.println(posDecimales);
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
                Serial.println("Digito:");
                Serial.println(ConvertirASCII_Int(entrada));
                Serial.println("Checksum hasta el momento:");
                Serial.println(checksum);
  
                checksum = checksum + ConvertirASCII_Int(entrada) * Potencia(10, posDecimales);
                posDecimales--;
              }
            }
            else
            {
              posDecimales = ConvertirASCII_Int(entrada)-1;
              Serial.println("Posiciones Decimales");
              Serial.println(posDecimales);
            }
          }        
        }
      }
    }
  }
  
  if(posDecimalesNum + numero == checksum)
  {
    Serial.println("Numero recibido:");
    Serial.println(numero);
    Serial.println("Checksum");
    Serial.println(checksum);
    return numero;
  }
  else
  {
    return -1;
  }

}

