# -*- coding: utf-8 -*-

import serial
import struct
        

def recibirComandos (serialport) :  
#    serialport = AbrirPuerto()                                                            
    header = serialport.read()
    while (len(header)>0):
        if (ord(header)==255):
            comando = serialport.read()
            if (ord(comando)==5):
                posicionYaw = ord(serialport.read())
                posicionPitch = ord(serialport.read())
                posicionRoll = ord(serialport.read())
                velocidadYaw = ord(serialport.read())
                velocidadPitch = ord(serialport.read())
                velocidadRoll = ord(serialport.read())
                altura = ord(serialport.read())
                checksum = ord(serialport.read())
                print(posicionYaw)
                print(posicionPitch)
                print(posicionRoll)
                print(velocidadYaw)
                print(velocidadPitch)
                print(velocidadRoll)
                print (altura)
                print(checksum)
                if ((ord(header) ^ comando ^ posicionYaw ^ posicionPitch ^ posicionRoll ^ velocidadYaw ^ velocidadPitch ^ velocidadRoll) == checksum):
                    return True
                else:
                    return False
           # if (ord(comando)==6):
            comandoACK = ord(serialport.read())
            checksum = ord(serialport.read())
            print(ord(header))
            print(ord(comando))     
            print(comandoACK)   
            print(checksum)
            
            if ((ord(header) ^ ord(comando) ^ comandoACK) == checksum):
                return True
            else:
                return False
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

puertoSerial = serial.Serial("COM3", 38400)
while (True):
    controlMotores(1,puertoSerial)
    recibirComandos (puertoSerial)
#    header = puertoSerial.read(1)
#    if (len(header)>0):
#        print(ord(header))