# -*- coding: utf-8 -*-

import serial
import struct
                                                        
#serialport = serial.Serial("COM3", 38400)
         
def recibirComandos () : 
    #global serialport
    header = "";
    serialport = AbrirPuerto()                                                            
    header = serialport.read()
    print(len(header))
    while (len(header)>0):
        print(ord(header))
        header = serialport.read()
        if (ord(header)==255):
            comando = serialport.read()
            if (ord(comando)==7):
                posicionYaw = ord(serialport.read())
                posicionPitch = ord(serialport.read())
                posicionRoll = ord(serialport.read())
                velocidadYaw = ord(serialport.read())
                velocidadPitch = ord(serialport.read())
                velocidadRoll = ord(serialport.read())
                checksum = ord(serialport.read())
                if ((header ^ comando ^ posicionYaw ^ posicionPitch ^ posicionRoll ^ velocidadYaw ^ velocidadPitch ^ velocidadRoll) == checksum):
                    print ("LLEGO!")                    
                    return True
                else:
                    print("MALO!")
                    return False
            if (ord(comando)==6):
                comandoACK = ord(serialport.read())
                checksum = ord(serialport.read())
#                if (bin((ord(header)) ^ bin(comando) ^ bin(comandoACK)) == checksum):
#                    print ("LLEGO!")                    
#                    return True
#                else:
#                    print("MALO!")
#                    return False
    print("ERROR")
    serialport.close();
    return False
            
           
               
def controlMotores(intValor):
    puerto = AbrirPuerto()
    paquete = (chr(255)+chr(1)+chr(intValor))
    puerto.write(paquete)
    CerrarPuerto(puerto)

def controlMovimiento(listaMovimientos):
    #global serialport
    puerto = AbrirPuerto()
    checksum = (255 ^ 1 ^ listaMovimientos[0] ^ listaMovimientos[1] ^ listaMovimientos[2] ^ listaMovimientos[3] ^ listaMovimientos[4])
    paquete = (chr(255)+chr(1)+chr(listaMovimientos[0])+chr(listaMovimientos[1])+chr(listaMovimientos[2])+chr(checksum))
    puerto.write(paquete)
    CerrarPuerto(puerto)
    
    
    
def AbrirPuerto():
    puertoSerial = serial.Serial("COM3", 38400)
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
    
while (True):
#    listamovimientos = []
#    for i in range(5):
#       listamovimientos.append(0)
#    listamovimientos[0]=1
#    listamovimientos[1]=2
#    listamovimientos[2]=3
#    controlMovimiento(listamovimientos)
    recibirComandos()