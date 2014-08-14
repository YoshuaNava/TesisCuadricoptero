# -*- coding: utf-8 -*-

import serial
import struct
        


def cardinalCaracterValidado(caracter):
    if(len(caracter) > 0):
        if((ord(caracter) > 0) and (ord(caracter) <= 255)):
            return ord(caracter)
    else:
        return 1000
        

def recibirComandos (serialport) :  
#    serialport = AbrirPuerto()
#    if (serialport.inWaiting() > 0)
    header = serialport.read()
    print "header = " + str(cardinalCaracterValidado(header))

    if (cardinalCaracterValidado(header)==255):
        comando = serialport.read()
        if (cardinalCaracterValidado(comando)==5):
            posicionYaw = cardinalCaracterValidado(serialport.read())
            posicionPitch = cardinalCaracterValidado(serialport.read())
            posicionRoll = cardinalCaracterValidado(serialport.read())
            velocidadYaw = cardinalCaracterValidado(serialport.read())
            velocidadPitch = cardinalCaracterValidado(serialport.read())
            velocidadRoll = cardinalCaracterValidado(serialport.read())
            altura = cardinalCaracterValidado(serialport.read())
            checksum = cardinalCaracterValidado(serialport.read())
            if ((cardinalCaracterValidado(header) ^ comando ^ posicionYaw ^ posicionPitch ^ posicionRoll ^ velocidadYaw ^ velocidadPitch ^ velocidadRoll) == checksum):
                print(posicionYaw)
                print(posicionPitch)
                print(posicionRoll)
                print(velocidadYaw)
                print(velocidadPitch)
                print(velocidadRoll)
                print (altura)
                print(checksum)
                return True
            else:
                return False
        
        if (cardinalCaracterValidado(comando)==6):
            comandoACK = cardinalCaracterValidado(serialport.read())
            checksum = cardinalCaracterValidado(serialport.read())
        
            if ((ord(header) ^ ord(comando) ^ comandoACK) == checksum):
                print(cardinalCaracterValidado(header))
                print(cardinalCaracterValidado(comando))     
                print(comandoACK)   
                print(checksum)

                return True
            else:
                return False
            
           
               
def controlMotores(intValor,puerto):
#    puerto = AbrirPuerto()
    paquete = (chr(255)+chr(1)+chr(intValor)+chr(255 ^ 1 ^ intValor))
    puerto.write(paquete)

def controlMovimiento(listaMovimientos,puerto):
#   puerto = AbrirPuerto()
    checksum = (255 ^ 1 ^ listaMovimientos[0] ^ listaMovimientos[1] ^ listaMovimientos[2] ^ listaMovimientos[3] ^ listaMovimientos[4])
    paquete = (chr(255)+chr(1)+chr(listaMovimientos[0])+chr(listaMovimientos[1])+chr(listaMovimientos[2])+chr(listaMovimientos[3])+chr(listaMovimientos[4])+chr(checksum))
    puerto.write(paquete)
    
    
    
def AbrirPuerto():
    puertoSerial = serial.Serial("COM3", 38400, timeout=0.5)
    return puertoSerial

    
def CerrarPuerto(puertoSerial):
    puertoSerial.close()


def EnviarCaracter(puerto, caracter):
    puerto.write(caracter)


def EnviarEntero(puerto, numero):
    numero_low = int(numero % 256)
    numero_high = int(numero / 256)
    #print numero_low
    #print numero_high
    puerto.write(struct.pack('B',numero_low))
    puerto.write(struct.pack('B',numero_high))
    

def EnviarComandoCuadricoptero(puerto, codigo, comandoPitch, comandoRoll, checksum):
    EnviarCaracter(puerto, codigo)
    EnviarEntero(puerto,comandoPitch)
    EnviarEntero(puerto,comandoRoll)
    EnviarEntero(puerto,checksum)

def Enviar():
    controlMotores(1,puertoSerial)

puertoSerial = serial.Serial(port="/dev/ttyUSB0", baudrate=38400, timeout=0.05)
contador = 0
while (True):
    #controlMotores(1,puertoSerial)
    recibirComandos (puertoSerial)
    contador = contador + 1
    print "Paquetes recibidos = " + str(contador)
    #puertoSerial.flushInput()    
#    header = puertoSerial.read(1)
#    if (len(header)>0):
#        print(ord(header))