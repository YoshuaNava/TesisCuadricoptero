# -*- coding: utf-8 -*-

import serial
import math
import struct



def AbrirPuerto(nombrePuerto, tasaBaudios):
    puertoSerial = serial.Serial(nombrePuerto, tasaBaudios)
    return puertoSerial
    
def CerrarPuerto(puertoSerial):
    puertoSerial.close()


def NumDigitos(numero):
    if  numero == 0:
        return 1
    else:
        return int(math.log10(numero))+1

def EnviarCaracter(puerto, caracter):
    puerto.write(caracter)


def EnviarEntero(puerto, numero):
    numero_low = int(numero % 256)
    numero_high = int(numero / 256)
    #print numero_low
    #print numero_high
    puerto.write(struct.pack('B',numero_low))
    puerto.write(struct.pack('B',numero_high))
    

def EnviarComandoCuadricoptero(puerto, codigo, comandoPitch, comandoRoll, calibrarYPR, checksum):
    EnviarCaracter(puerto, codigo)
    EnviarEntero(puerto,comandoPitch)
    EnviarEntero(puerto,comandoRoll)
    EnviarCaracter(puerto, calibrarYPR)
    EnviarEntero(puerto,checksum)
    