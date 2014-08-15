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

    if (cardinalCaracterValidado(header)==255):
        comando = serialport.read()
        if (cardinalCaracterValidado(comando)==7):
            posicionYaw = cardinalCaracterValidado(serialport.read())
            posicionPitch = cardinalCaracterValidado(serialport.read())
            posicionRoll = cardinalCaracterValidado(serialport.read())
            velocidadYaw = cardinalCaracterValidado(serialport.read())
            velocidadPitch = cardinalCaracterValidado(serialport.read())
            velocidadRoll = cardinalCaracterValidado(serialport.read())
            altura = cardinalCaracterValidado(serialport.read())
            checksum = cardinalCaracterValidado(serialport.read())
            if ((cardinalCaracterValidado(header) ^ ord(comando) ^ posicionYaw ^ posicionPitch ^ posicionRoll ^ velocidadYaw ^ velocidadPitch ^ velocidadRoll ^ altura) == checksum):
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
    checksum = (255 ^ 1 ^ listaMovimientos[0] ^ listaMovimientos[1] ^ listaMovimientos[2])
    paquete = (chr(255)+chr(1)+chr(listaMovimientos[0])+chr(listaMovimientos[1])+chr(listaMovimientos[2])+chr(checksum))
    for i in range(6):  
        print (ord(paquete[i]))
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

puertoSerial = serial.Serial(port="COM3", baudrate=38400, timeout=0.05)
while (True):
    recibirComandos (puertoSerial)
    #puertoSerial.flushInput()    
#    header = puertoSerial.read(1)
#    if (len(header)>0):
#        print(ord(header))