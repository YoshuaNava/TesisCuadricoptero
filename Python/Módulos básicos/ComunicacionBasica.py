# -*- coding: utf-8 -*-

import serial
import struct
        


def cardinalCaracter_Validar(caracter):
    if(len(caracter) > 0):
        if((ord(caracter) >= 0) and (ord(caracter) <= 255)):
            return ord(caracter)
    else:
        return 1000
        

def recibirComandos (serialport) :  
#    serialport = AbrirPuerto()
#    if (serialport.inWaiting() > 0)
    header = serialport.read()

    if (cardinalCaracter_Validar(header)==255):
        comando = serialport.read()
        if (cardinalCaracter_Validar(comando)==7):
            P_posicionYaw = cardinalCaracter_Validar(serialport.read())
            N_posicionYaw = cardinalCaracter_Validar(serialport.read())
            P_posicionPitch = cardinalCaracter_Validar(serialport.read())
            N_posicionPitch = cardinalCaracter_Validar(serialport.read())
            P_posicionRoll = cardinalCaracter_Validar(serialport.read())
            N_posicionRoll = cardinalCaracter_Validar(serialport.read())
            P_velocidadYaw = cardinalCaracter_Validar(serialport.read())
            N_velocidadYaw = cardinalCaracter_Validar(serialport.read())
            P_velocidadPitch = cardinalCaracter_Validar(serialport.read())
            N_velocidadPitch = cardinalCaracter_Validar(serialport.read())
            P_velocidadRoll = cardinalCaracter_Validar(serialport.read())
            N_velocidadRoll = cardinalCaracter_Validar(serialport.read())
            altura = cardinalCaracter_Validar(serialport.read())
            checksum = cardinalCaracter_Validar(serialport.read())

            if((header != None) and (comando != None) and (P_posicionYaw != None) and (P_posicionPitch != None) and (P_posicionRoll != None) and (P_velocidadYaw != None) and (P_velocidadPitch != None) and (P_velocidadRoll != None) and (N_posicionYaw != None) and (N_posicionPitch != None) and (N_posicionRoll != None) and (N_velocidadYaw != None) and (N_velocidadPitch != None) and (N_velocidadRoll != None) and (altura != None) and (checksum != None)):
                if ((cardinalCaracter_Validar(header) ^ cardinalCaracter_Validar(comando) ^ P_posicionYaw ^ N_posicionYaw ^ P_posicionPitch ^ N_posicionPitch ^ P_posicionRoll ^ N_posicionRoll ^ P_velocidadYaw ^ N_velocidadYaw ^ P_velocidadPitch ^ N_velocidadPitch ^ P_velocidadRoll ^ N_velocidadRoll ^ altura) == checksum):
                    print "\nDatos recibidos:"            
                    print(P_posicionYaw)
                    print(N_posicionYaw)
                    print(P_posicionPitch)
                    print(N_posicionPitch)
                    print(P_posicionRoll)
                    print(N_posicionRoll)
                    print(P_velocidadYaw)
                    print(N_velocidadYaw)
                    print(P_velocidadPitch)
                    print(N_velocidadPitch)
                    print(P_velocidadRoll)
                    print(N_velocidadRoll)
                    print(altura)
                    print(checksum)
                    return True
                else:
                    return False
        
        if (cardinalCaracter_Validar(comando)==6):
            comandoACK = cardinalCaracter_Validar(serialport.read())
            checksum = cardinalCaracter_Validar(serialport.read())
        
            if ((ord(header) ^ ord(comando) ^ comandoACK) == checksum):
                print(cardinalCaracter_Validar(header))
                print(cardinalCaracter_Validar(comando))     
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

puertoSerial = serial.Serial(port="/dev/ttyUSB0", baudrate=38400, timeout=0.05)
while (True):
    recibirComandos (puertoSerial)
    #puertoSerial.flushInput()    
#    header = puertoSerial.read(1)
#    if (len(header)>0):
#        print(ord(header))